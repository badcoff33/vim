vim9script

g:run_dict = []

def g:Winopts(): dict<any>
    return { pos: "botright",
        line: &showtabline ? 2 : 1,
        col: &columns,
        tabpage: -1,
        highlight: 'Pmenu',
        padding: [0, 1, 0, 1],
    }
enddef

def g:WinoptsDone(): dict<any>
    return { pos: "botright",
        line: &showtabline ? 3 : 2,
        col: &columns,
        tabpage: -1,
        highlight: 'PmenuSel',
        padding: [0, 1, 0, 1],
        time: 3500,
    }
enddef

def g:WinoptsError(): dict<any>
    return { pos: "botright",
        line: &showtabline ? 4 : 3,
        col: &columns,
        tabpage: -1,
        highlight: 'ErrorMsg',
        padding: [0, 1, 0, 1],
        time: 3500,
    }
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
                errors += e.type ==? "e" ? 1 : 0
                warnings += e.type ==? "w" ? 1 : 0
            endfor
            popup_create(
                printf("DONE | %d lines | %d warnings | %d errors",
                    lines,
                    errors,
                    warnings),
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
    if has_key(dict, "nowrite") && (dict.nowrite == true)
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

def RunTimerCb(tid: number)
    for d in g:run_dict
        if d.winid > 0
            popup_setoptions(d.winid, g:Winopts())
            if has_key(d, "timer") && d.timer == tid
                popup_settext(d.winid,
                    printf("status %s | %d lines | %d sec",
                        job_status(d.job),
                        getbufinfo(d.bufnr)[0].linecount,
                        localtime() - d.started))
                break
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
        v_job = RunBackground(dict)
    else
        v_job = RunBuf(dict)
    endif

    return v_job
enddef


export def RunBackground(dict: dict<any>): job
    var v_job: job
    var job_opts = {}

    job_opts.cwd = has_key(dict, "cwd") ? dict.cwd : getcwd()
    job_opts.noblock = 1
    job_opts.err_cb = function("run#BackgroundErrorCb")
    v_job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)

    return v_job
enddef

export def RunBuf(dict: dict<any>): job
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
        v_winid = popup_create(
            printf("starting %s",
                split(dict.cmd, " ")[0]),
            g:Winopts())
    endif
    add(g:run_dict, {
        winid: v_winid,
        timer: timer_start(1000, RunTimerCb, {repeat: -1}),
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
# defcompile
