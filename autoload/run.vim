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

def RemoveChannelFromDict(ch: string)
    var r: list<any>

    for e in g:run_dict
        if e.channel != ch
           add(r, e)
        endif
    endfor

    g:run_dict = r
enddef

export def CloseCb(ch: channel)
    var ch_nr = split(string(ch), " ")[1]
    var lines = 0
    var errors = 0
    var warnings = 0

    for d in g:run_dict
        if d.channel == ch_nr

            timer_stop(d.timer)
            g:run_2_tid = timer_start(500, (_) => {
                popup_close(d.winid)
                RemoveChannelFromDict(d.channel)
            }, {repeat: 1})

            if d.bufname == ""
                var save_errorformat = &errorformat
                try
                    execute "set errorformat=" .. escape(d.regexp, ' \')
                    execute "cgetbuffer" d.bufnr
                    execute "set errorformat=" .. escape(save_errorformat, ' \')
                catch /.*/
                    echoerr ">>failed " &errorformat
                endtry
                w:quickfix_title = d.cmd
                execute "silent bwipe" d.bufnr
                for e in getqflist({ "nr": "$", "all": 0 }).items
                    lines = lines + 1
                    errors += e.type ==? "e" ? 1 : 0
                    warnings += e.type ==? "w" ? 1 : 0
                endfor
                popup_create("Done"
                    .. " (" .. lines
                    .. ", " .. warnings
                    .. ", " .. errors .. ") ",
                    g:WinoptsDone())
            else
                setbufvar(d.bufnr, "&modified", 0)
                setbufvar(d.bufnr, "&modifiable", 0)
            endif
            silent doautocmd QuickFixCmdPost make
            break
        endif
    endfor
enddef

export def HiddenErrorCb(ch: channel,  msg: string)
    var ch_nr = split(string(ch), " ")[1]
    for d in g:run_dict
        if d.channel == ch_nr
            timer_stop(d.timer)
            popup_close(d.winid)
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
    var max_width = 30
    var popup_text: string

    for d in g:run_dict
        if d.timer == tid
            if len(d.cmd) > max_width
                popup_text = "Running " .. d.cmd[0 : max_width]
                    .. "..."
                    .. (localtime() - d.started)
                    .. "sec"
            else
                popup_text = "Running " .. d.cmd
                    .. " "
                    .. (localtime() - d.started)
                    .. "sec"
            endif
            popup_settext(d.winid, popup_text)
            break
        endif
    endfor
enddef

export def Run(dict: dict<any>): job
    var job: job
    var v_bufnr: number
    var v_winid: number
    var v_bufname: string
    var v_regexp: string

    var job_opts = {}

    if !has_key(dict, 'cmd') && (dict.cmd != "")
        echoerr "run.vim: key 'cmd' required"
        return null_job
    endif

    ConditionalWriteAll(dict)

    v_bufname = has_key(dict, "name") ? dict.name : ""
    v_regexp = has_key(dict, "regexp") ? dict.regexp : &errorformat

    silent doautocmd QuickFixCmdPre make

    if has_key(dict, "hidden") && (dict.hidden == true)
        job_opts.cwd = has_key(dict, "cwd") ? dict.cwd : getcwd()
        job_opts.err_cb = function("run#HiddenErrorCb")
        job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)
    else
        if v_bufname == ""
            v_bufnr = bufadd(dict.cmd)
            setbufvar(v_bufnr, "&buftype", "nofile")
        else
            if bufexists(v_bufname)
                v_bufnr = bufnr(v_bufname)
                setbufvar(v_bufnr, "&buftype", "nofile")
                setbufvar(v_bufnr, "&modified", 0)
                setbufvar(v_bufnr, "&modifiable", 1)
            else
                v_bufnr = bufadd(v_bufname)
                setbufvar(v_bufnr, "&buftype", "nofile")
            endif
            execute "buffer" v_bufnr
            nnoremap <buffer> <Esc> <Cmd>bw!<CR>
            appendbufline(v_bufnr, "$", "-----" .. strftime("%X") .. "------" .. dict.cmd .. "-----")
            normal G
        endif

        job_opts.cwd = has_key(dict, "cwd") ? dict.cwd : getcwd()
        job_opts.err_buf = v_bufnr
        job_opts.out_buf = v_bufnr
        job_opts.err_io = "buffer"
        job_opts.out_io = "buffer"
        job_opts.close_cb = function("run#CloseCb")

        job = job_start('cmd /C ' .. escape(dict.cmd, ''), job_opts)
        var v_channel = split(string(job_getchannel(job)), " ")[1]
        var popup_text: string

        if len(dict.cmd) > 40
            popup_text = dict.cmd[0 : 40] .. "..."
        else
            popup_text = dict.cmd
        endif
        v_winid = popup_create("Started " .. popup_text, g:Winopts())

        add(g:run_dict, {
            channel: v_channel,
            winid: v_winid,
            cmd: dict.cmd,
            regexp: v_regexp,
            bufname: v_bufname,
            bufnr: v_bufnr,
            timer: timer_start(1000, RunTimerCb, {repeat: -1}),
            started: localtime()
        })
    endif

    return job
enddef

augroup GroupRun
    autocmd!
    # autocmd VimResized * call popup_setoptions(g:run_dict.winid, g:Winopts())
augroup END

# Uncomment when testing
defcompile
