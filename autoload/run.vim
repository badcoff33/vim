vim9script

var run_update_winid: number
var run_update_bufnr: number
var run_qflist_nr: number

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


export def AppendCb(ch: channel, msg: string)
    setqflist([], "a", {
        nr: run_qflist_nr,
        efm: g:run_efm,
        lines: [msg]
    })
enddef

def UpdateBufCb()
    var errors = 0
    var warnings = 0
    var items = getqflist({nr: run_qflist_nr, items: 0}).items

    for entry in items
        errors = errors + ((entry.type == "E") ? 1 : 0)
        warnings = warnings + ((entry.type == "W") ? 1 : 0)
    endfor

    var text = "/" .. len(items)
    if (warnings + errors) > 0
        text = text .. "/" .. warnings .. "/" .. errors
    endif
    text = text .. "/"
    noautocmd setbufline(run_update_bufnr, 1, text)
enddef

export def CloseCb(ch: channel)
    if exists("g:run_tid")
        if !empty(timer_info(g:run_tid))
            timer_stop(g:run_tid)
        endif
    endif
    setwinvar(run_update_winid, "&wincolor", "PmenuSel")
    g:run_2_tid = timer_start(5000, (_) => {
        popup_close(run_update_winid)
    }, {repeat: 1})
    silent doautocmd QuickFixCmdPost make
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
    var run_hidden = has_key(dict, "hidden") && (dict.hidden == "0") ? true : false
    if !has_key(dict, 'cmd')
        echoerr "no command"
        return
    endif

    ConditionalWriteAll(dict)

    if has_key(dict, "regexp")
        g:run_efm = dict.regexp
    else
        g:run_efm = &errorformat
    endif

    job_opts.cwd = getcwd()
    if has_key(dict, "cwd")
        job_opts.cwd = dict.cwd
    endif

    if run_hidden == true
        job_opts.err_cb = function("run#HiddenErrorCb")
    else
        job_opts.out_cb = function("run#AppendCb")
        job_opts.err_cb = function("run#AppendCb")
        job_opts.close_cb = function("run#CloseCb")
    endif

    job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)

    if ( job_status(job) == "run" ) && ( run_hidden == false )
        run_update_winid = popup_create("Waiting", g:Winopts())
        run_update_bufnr = winbufnr(run_update_winid)
        execute "autocmd VimResized" run_update_bufnr "call popup_setoptions(run_update_winid, g:Winopts())"
        g:run_tid = timer_start(300, (_) => {
             UpdateBufCb()
        }, {repeat: -1})

        setqflist([], " ", {
            nr: "$",
            title:  dict.cmd,
        })
        run_qflist_nr = getqflist({nr: "$"}).nr
    else
        run_update_winid = 0
    endif
enddef

# Uncomment when testing
defcompile

