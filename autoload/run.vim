vim9script

g:run_dict = {}

def g:Winopts(): dict<any>
    return { pos: "botright",
        line: &lines - 2,
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
        execute "bwipe" d.bufnr
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

    var v_out_buf = has_key(dict, "out_buf") && (dict.out_buf == true) ? true : false
    var v_regexp = has_key(dict, "regexp") ? dict.regexp : &errorformat
    var cmd = dict.cmd

    job_opts.cwd = getcwd()
    if has_key(dict, "cwd")
        job_opts.cwd = dict.cwd
    endif

    if has_key(dict, "hidden") && (dict.hidden == true)
        job_opts.err_cb = function("run#HiddenErrorCb")
        var job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)
    else
        var v_bufnr: number
        var bufname = substitute(dict.cmd, '\', '', 'g')
        if v_out_buf == true
            if bufexists(bufname)
                v_bufnr = bufnr(bufname)
                setbufvar(v_bufnr, "&readonly", 0)
                setbufvar(v_bufnr, "&modified", 0)
                setbufvar(v_bufnr, "&modifiable", 1)
            else
                v_bufnr = bufadd(bufname)
            endif
            execute "buffer" v_bufnr
            nnoremap <buffer> <Esc> <Cmd>bw!<CR>
            setbufline(v_bufnr, "$", "____ " .. strftime("%X") .. " ____ " .. dict.cmd .. " ____")
        else
            v_bufnr = bufadd(bufname)
        endif

        job_opts.err_buf = v_bufnr
        job_opts.out_buf = v_bufnr
        job_opts.err_io = "buffer"
        job_opts.out_io = "buffer"
        job_opts.close_cb = function("run#CloseCb")

        var job = job_start('cmd /C ' .. escape(dict.cmd, ''), job_opts)
        var channel = split(string(job_getchannel(job)), " ")[1]

        var v_winid = popup_create("Run " .. dict.cmd, g:Winopts())
        g:run_dict[channel] = { winid: v_winid, cmd: dict.cmd, regexp: v_regexp, out_buf: v_out_buf, bufnr: v_bufnr }
        augroup GroupRun
            autocmd!
            autocmd VimResized * call popup_setoptions(v_winid, g:Winopts())
        augroup END
    endif
enddef

# Uncomment when testing
defcompile
