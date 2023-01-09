vim9script

var run_update_winid: number
var run_update_bufnr: number

def g:Winopts(): dict<any>
    return { pos: "botright",
        line: &lines,
        col: &columns,
        tabpage: -1,
        highlight: 'Pmenu',
        padding: [0, 1, 0, 1],
        maxwidth: (&columns * 2) / 3
    }
enddef


export def CloseCb(ch: channel)
    if g:run_to_buffer == false
        var save_errorformat = &errorformat
        execute "set errorformat=" .. g:run_efm
        execute "cgetbuffer" g:run_bufnr
        execute "set errorformat=" .. save_errorformat
        w:quickfix_title = g:run_cmd
    else
        setbufvar(g:run_bufnr, "&readonly", 1)
        setbufvar(g:run_bufnr, "&modified", 0)
        setbufvar(g:run_bufnr, "&modifiable", 0)
    endif
    silent doautocmd QuickFixCmdPost make
    setwinvar(run_update_winid, "&wincolor", "PmenuSel")
    g:run_2_tid = timer_start(3000, (_) => {
        popup_close(run_update_winid)
    }, {repeat: 1})
enddef

export def HiddenErrorCb(ch: channel,  msg: string)
    echohl ErrorMsg
    echo "error reported by channel" ch_info(ch)["id"] "-->" msg
    echohl None
enddef

def ConditionalWriteAll(dict: dict<any>)
    if has_key(dict, "nowrite") && (dict.nowrite == 1)
        return
    endif
    if (&autowrite || &autowriteall)
        try
            silent wall
        catch /.*/
            echoerr "run#run: not all modified buffers written"
        finally
        endtry
    endif
enddef

export def Run(dict: dict<any>)
    var job: job
    var job_opts = {}

    if !has_key(dict, 'cmd')
        echoerr "no command"
        return
    endif

    ConditionalWriteAll(dict)

    g:run_to_buffer = has_key(dict, "as_buffer") && (dict.as_buffer == true) ? true : false
    g:run_efm = has_key(dict, "regexp") ? dict.regexp : &errorformat
    g:run_cmd = dict.cmd

    job_opts.cwd = getcwd()
    if has_key(dict, "cwd")
        job_opts.cwd = dict.cwd
    endif

    if has_key(dict, "hidden") && (dict.hidden == true)
        job_opts.err_cb = function("run#HiddenErrorCb")
        job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)
    else
        g:run_bufnr = bufadd(dict.cmd)
        job_opts.out_buf = g:run_bufnr
        job_opts.out_io = "buffer"
        job_opts.close_cb = function("run#CloseCb")
        if g:run_to_buffer == true
            execute "buffer" g:run_bufnr
        endif

        job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)

        run_update_winid = popup_create("Run " .. g:run_cmd, g:Winopts())
        run_update_bufnr = winbufnr(run_update_winid)
        execute "autocmd VimResized" run_update_bufnr "call popup_setoptions(run_update_winid, g:Winopts())"
    endif
enddef

# Uncomment when testing
defcompile
