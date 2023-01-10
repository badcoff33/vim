vim9script

g:run_dict = {}

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
    var ch_nr = split(string(ch), " ")[1]
    var d = g:run_dict[ch_nr]
    g:run_dict = remove(g:run_dict, ch_nr)
    if d.out_buf == false
        var save_errorformat = &errorformat
        execute "set errorformat=" .. escape(d.regexp, ' \')
        execute "cgetbuffer" d.bufnr
        execute "set errorformat=" .. escape(save_errorformat, ' \')
        w:quickfix_title = d.cmd
    else
        setbufvar(d.bufnr, "&readonly", 1)
        setbufvar(d.bufnr, "&modified", 0)
        setbufvar(d.bufnr, "&modifiable", 0)
    endif
    silent doautocmd QuickFixCmdPost make
    setwinvar(d.winid, "&wincolor", "PmenuSel")
    g:run_2_tid = timer_start(3000, (_) => {
        popup_close(d.winid)
        augroup GroupRun
            autocmd!
        augroup END
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
    var job_opts = {}

    if !has_key(dict, 'cmd')
        echoerr "no command"
        return
    endif

    ConditionalWriteAll(dict)

    var to_buffer = has_key(dict, "as_buffer") && (dict.as_buffer == true) ? true : false
    var regexp = has_key(dict, "regexp") ? dict.regexp : &errorformat
    var cmd = dict.cmd

    job_opts.cwd = getcwd()
    if has_key(dict, "cwd")
        job_opts.cwd = dict.cwd
    endif

    if has_key(dict, "hidden") && (dict.hidden == true)
        job_opts.err_cb = function("run#HiddenErrorCb")
        var job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)
    else
        var bufnr: number
        var bufname = substitute(dict.cmd, '\', '', 'g')
        if bufexists(bufname)
            bufnr = bufnr(bufname)
            setbufvar(bufnr, "&readonly", 0)
            setbufvar(bufnr, "&modified", 0)
            setbufvar(bufnr, "&modifiable", 1)
            setbufline(bufnr, "$", "")
            setbufline(bufnr, "$", "-----------< " .. strftime("%X") .. " >-----------")
        else
            bufnr = bufadd(bufname)
        endif
        if to_buffer == true
            execute "buffer" bufnr
            nnoremap <buffer> <Esc> <Cmd>bw!<CR>
        endif
        job_opts.err_buf = bufnr
        job_opts.out_buf = bufnr
        job_opts.err_io = "buffer"
        job_opts.out_io = "buffer"
        job_opts.close_cb = function("run#CloseCb")

        var job = job_start('cmd /C ' .. escape(dict.cmd, ''), job_opts)
        var channel = split(string(job_getchannel(job)), " ")[1]

        var winid = popup_create("Run " .. dict.cmd, g:Winopts())
        g:run_dict[channel] = { winid: winid, cmd: dict.cmd, regexp: regexp, out_buf: to_buffer, bufnr: bufnr }
        augroup GroupRun
            autocmd!
            autocmd VimResized * call popup_setoptions(g:run_winid, g:Winopts())
        augroup END
    endif
enddef

# Uncomment when testing
defcompile
