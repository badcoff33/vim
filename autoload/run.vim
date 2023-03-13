vim9script

g:run_dict = []
g:run_popup_line_min = 3
g:run_popup_line_max = 10
g:run_popup_line = g:run_popup_line_min

def g:Winopts(): dict<any>
    var d = { pos: "botright",
        line: g:run_popup_line,
        col: &columns,
        tabpage: -1,
        highlight: 'Pmenu',
        padding: [0, 1, 0, 1],
    }
    return d
enddef

def g:WinoptsDone(): dict<any>
    var d = { pos: "botright",
        line: g:run_popup_line,
        col: &columns,
        tabpage: -1,
        highlight: 'PmenuSel',
        padding: [0, 1, 0, 1],
        time: 3500,
    }
    return d
enddef

def g:WinoptsError(): dict<any>
    var d = { pos: "botright",
        line: g:run_popup_line,
        col: &columns,
        tabpage: -1,
        highlight: 'ErrorMsg',
        padding: [0, 1, 0, 1],
        time: 3500,
    }
    return d
enddef

def SetNewPosition()
    g:run_popup_line += 1
    if g:run_popup_line > g:run_popup_line_max
        g:run_popup_line = g:run_popup_line_min
    endif
enddef

def RemoveChannelFromDict(ch: string)
    var r: list<any>

    for e in g:run_dict
        if e.channel != ch
            add(r, e)
        endif
    endfor

    g:run_dict = r
enddef

export def ErrorCb(ch: channel,  msg: string)
    var ch_nr = split(string(ch), " ")[1]
    for d in g:run_dict
        if d.channel == ch_nr
            SetNewPosition()
            popup_create("Error:" .. msg, g:WinoptsError())
        endif
    endfor
enddef

export def CloseCb(ch: channel)
    var ch_nr = split(string(ch), " ")[1]
    var lines = 0
    var errors = 0
    var warnings = 0

    for d in g:run_dict
        if d.channel == ch_nr
            if has_key(d, "timer")
                timer_stop(d.timer)
            endif
            setqflist([], " ", {
                efm: d.regexp,
                title: d.cmd,
                lines: getbufline(d.bufnr, 1, "$")
            })
            for e in getqflist({ "nr": "$", "all": 0 }).items
                lines = lines + 1
                warnings += e.type ==? "w" ? 1 : 0
                errors += e.type ==? "e" ? 1 : 0
            endfor
            SetNewPosition()
            popup_create(
                printf("DONE | %d lines | %d warnings | %d errors",
                    lines,
                    warnings,
                    errors),
                g:WinoptsDone())
            if has_key(d, "winid")
                popup_close(d.winid)
            endif
            execute "silent bwipe" d.bufnr
            RemoveChannelFromDict(d.channel)
            silent doautocmd QuickFixCmdPost make
            break
        endif
    endfor
enddef

export def BackgroundErrorCb(ch: channel,  msg: string)
    var ch_nr = split(string(ch), " ")[1]
    for d in g:run_dict
        if d.channel == ch_nr
            timer_stop(d.timer)
            if has_key(d, "winid")
                popup_close(d.winid)
            endif
            echohl ErrorMsg
            echo "error reported by channel" ch_info(ch)["id"] "-->" msg
            echohl None
            RemoveChannelFromDict(ch_nr)
            break
        endif
    endfor
enddef

def ConditionalWriteAll(dict: dict<any>)
    if has_key(dict, "no_write") && (dict.no_write == true)
        return
    endif
    try
        silent wall
    catch /.*/
        echomsg "No autowrite. Not all modified buffers written"
        ls +
    finally
    endtry
enddef

def RunJobMonitoringCb(tid: number)
    var job_status: string

    for d in g:run_dict
        if d.winid > 0
            job_status = job_status(d.job)
            if job_status == "run"
                popup_setoptions(d.winid, g:Winopts())
                if has_key(d, "timer") && d.timer == tid
                    popup_settext(d.winid,
                        printf("%s | %d lines | %d sec",
                            toupper(job_status),
                            getbufinfo(d.bufnr)[0].linecount,
                            localtime() - d.started))
                    break
                endif
            else
                popup_close(d.winid)
                timer_stop(d.timer)
                SetNewPosition()
                popup_create("Error: job failed", g:WinoptsError())
            endif
        endif
    endfor
enddef

export def Run(dict: dict<any>): job
    var v_job: job

    if !has_key(dict, 'cmd') && (dict.cmd != "")
        echoerr "run.vim: key 'cmd' required"
        return null_job
    endif

    ConditionalWriteAll(dict)

    silent doautocmd QuickFixCmdPre make

    if has_key(dict, "background") && (dict.background == true)
        v_job = StartBackground(dict)
    else
        v_job = StartBuffered(dict)
    endif

    return v_job
enddef


def StartBackground(dict: dict<any>): job
    var v_job: job
    var job_opts = {}

    job_opts.cwd = has_key(dict, "cwd") ? dict.cwd : getcwd()
    job_opts.noblock = 1
    job_opts.err_cb = function("run#BackgroundErrorCb")
    v_job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)

    return v_job
enddef

def StartBuffered(dict: dict<any>): job
    var v_job: job
    var v_bufnr: number
    var v_winid: number
    var v_regexp: string
    var job_opts = {}

    v_regexp = has_key(dict, "regexp") ? dict.regexp : &errorformat

    v_bufnr = bufadd(dict.cmd)
    setbufvar(v_bufnr, "&buftype", "nofile")

    job_opts.cwd = has_key(dict, "cwd") ? dict.cwd : getcwd()
    job_opts.noblock = 1
    job_opts.err_buf = v_bufnr
    job_opts.out_buf = v_bufnr
    job_opts.err_io = "buffer"
    job_opts.out_io = "buffer"
    job_opts.close_cb = function("run#CloseCb")
    if has_key(dict, "show_err") && dict.show_err == true
        job_opts.err_cb = function("run#ErrorCb")
    endif
    v_job = job_start(escape(dict.cmd, ''), job_opts)

    var v_channel = split(string(job_getchannel(v_job)), " ")[1]

    if has_key(dict, "no_popup") && (dict.no_popup == true)
        v_winid = 0
    else
        SetNewPosition()
        v_winid = popup_create(
            printf("STARTING '%s'",
                split(dict.cmd, " ")[0]),
            g:Winopts())
    endif
    add(g:run_dict, {
        winid: v_winid,
        timer: timer_start(1000, RunJobMonitoringCb, {repeat: -1}),
        job: v_job,
        channel: v_channel,
        cmd: dict.cmd,
        regexp: v_regexp,
        bufnr: v_bufnr,
        started: localtime()
    })
    return v_job
enddef

# Uncomment when testing
defcompile
