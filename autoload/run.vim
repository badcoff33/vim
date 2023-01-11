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
    if d.bufname == ""
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
    var v_bufnr: number
    var v_winid: number
    var v_bufname: string
    var v_regexp: string

    var job_opts = {}

    if !has_key(dict, 'cmd')
        echoerr "run.vim: key 'cmd' required"
        return
    endif

    ConditionalWriteAll(dict)

    v_bufname = has_key(dict, "name") ? dict.name : ""
    v_regexp = has_key(dict, "regexp") ? dict.regexp : &errorformat

    if has_key(dict, "hidden") && (dict.hidden == true)
        job_opts.cwd = has_key(dict, "cwd") ? dict.cwd : getcwd()
        job_opts.err_cb = function("run#HiddenErrorCb")
        var job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)
    else
        if v_bufname == ""
            v_bufnr = bufadd(dict.cmd)
        else
            if bufexists(v_bufname)
                v_bufnr = bufnr(v_bufname)
                setbufvar(v_bufnr, "&readonly", 0)
                setbufvar(v_bufnr, "&modified", 0)
                setbufvar(v_bufnr, "&modifiable", 1)
            else
                v_bufnr = bufadd(v_bufname)
            endif
            execute "buffer" v_bufnr
            nnoremap <buffer> <Esc> <Cmd>bw!<CR>
            setbufline(v_bufnr, "$", "____ " .. strftime("%X") .. " ____ " .. dict.cmd .. " ____")
        endif

        job_opts.cwd = has_key(dict, "cwd") ? dict.cwd : getcwd()
        job_opts.err_buf = v_bufnr
        job_opts.out_buf = v_bufnr
        job_opts.err_io = "buffer"
        job_opts.out_io = "buffer"
        job_opts.close_cb = function("run#CloseCb")

        var job = job_start('cmd /C ' .. escape(dict.cmd, ''), job_opts)
        var channel = split(string(job_getchannel(job)), " ")[1]

        v_winid = popup_create("Run " .. dict.cmd, g:Winopts())
        augroup GroupRun
            autocmd!
            autocmd VimResized * call popup_setoptions(v_winid, g:Winopts())
        augroup END

        g:run_dict[channel] = {
            winid: v_winid,
            cmd: dict.cmd,
            regexp: v_regexp,
            bufname: v_bufname,
            bufnr: v_bufnr
        }
    endif
enddef

# Uncomment when testing
defcompile
