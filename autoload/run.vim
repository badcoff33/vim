vim9script

# Uncomment when testing
defcompile

import autoload "lib/popup.vim" as popup

var run_tid: number
var run_update_winid: number
var run_update_bufnr: number
var run_qflist_nr: number
var FnRef: func

export def AppendCb(ch: channel, msg: string)
    setqflist([], "a", {
        nr: run_qflist_nr,
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
    setbufline(run_update_bufnr, 1, text)
enddef

export def CloseCb(ch: channel)
    timer_stop(run_tid)
    setwinvar(run_update_winid, "&wincolor", "PmenuSel")
    UpdateBufCb()
    timer_start(5000, (_) => {
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
    # default: do nothing
    elseif (&autowrite || &autowriteall)
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
    var job: job
    var regexp: string
    var run_hidden = has_key(dict, "hidden") && (dict.hidden == "0") ? true : false
    var winopts = {
        pos: "botright",
        line: &lines - 2,
        col: &columns,
        tabpage: -1,
        highlight: 'Pmenu',
        padding: [0, 1, 0, 1],
        maxwidth: (&columns * 2) / 3,
    }

    if !has_key(dict, 'cmd')
        echoerr "no command"
        return
    endif

    ConditionalWriteAll(dict)

    job_opts.cwd = getcwd()
    if has_key(dict, "cwd")
        job_opts.cwd = dict.cwd
    endif

    if run_hidden == false
        job_opts.err_cb = function("run#HiddenErrorCb")
    else
        job_opts.out_cb = function("run#AppendCb")
        job_opts.err_cb = function("run#AppendCb")
        job_opts.close_cb = function("run#CloseCb")
    endif

    job = job_start('cmd /C ' .. escape(dict.cmd, '\'), job_opts)

    if ( job_status(job) == "run" ) && ( run_hidden == false )
        run_update_winid = popup_create("Waiting", winopts)
        run_update_bufnr = winbufnr(run_update_winid)
        run_tid = timer_start(100, (_) => {
            UpdateBufCb()
        }, {repeat: -1})

        setqflist([], " ", {
            nr: "$",
            title:  dict.cmd,
            efm: has_key(dict, "regexp") ? dict.regexp : &errorformat
        })
        run_qflist_nr = getqflist({nr: "$"}).nr
    else
        run_update_winid = 0
    endif
enddef

