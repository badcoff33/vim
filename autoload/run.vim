vim9script
# TODO: Only one job at a time

import autoload "lib/popup.vim" as popup

var run_tid: number
var run_live_update_winid: number
var run_live_update_bufnr: number
var run_qflist_nr: number
var FnRef: func

export def Append(ch: channel, msg: string)
  setqflist([], "a", {nr: run_qflist_nr, lines: [msg] })
enddef

def UpdateBuf()
  var errors = 0
  var warnings = 0
  var items = getqflist({nr: run_qflist_nr, items: 0}).items
  for entry in items
    errors = errors + ((entry.type == "e") ? 1 : 0)
    warnings = warnings + ((entry.type == "w") ? 1 : 0)
  endfor
  var text = "[ " .. len(items)
  if warnings > 0
    text = text .. " | " .. warnings
  endif
  if errors > 0
    text = text .. " | " .. errors
  endif
  text = text ..    " ]"
  setbufline(run_live_update_bufnr, 1, text)
enddef

export def Close(ch: channel)
  timer_stop(run_tid)
  UpdateBuf()
  timer_start(2000, (_) => {
    popup_close(run_live_update_winid)
  }, {repeat: 1})
  silent doautocmd QuickFixCmdPost make
enddef

export def HiddenError(ch: channel,  msg: string)
  echohl ErrorMsg
  echo "error reported by channel" ch_info(ch)["id"] "-->" msg
  echohl None
enddef

export def Run(dict: dict<any>)
  var job_opts = {}
  var regexp: string
  var close_popup: number

  if !has_key(dict, 'cmd')
    echoerr "no command"
    return
  endif

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

  if has_key(dict, "cwd")
    job_opts.cwd = dict.cwd
  else
    job_opts.cwd = getcwd()
  endif

  if has_key(dict, "hidden") || (dict.hidden == 0)
    job_opts.out_cb = function("run#Append")
    job_opts.err_cb = function("run#Append")
    job_opts.close_cb = function("run#Close")
  else
    job_opts.err_cb = function("run#HiddenError")
  endif

  if has_key(dict, "cwd")
    job_opts.cwd = dict.cwd
  endif

  if has_key(dict, "regexp")
    regexp = dict.regexp
  else
    regexp = &errorformat
  endif
  if has_key(dict, "notify") && (dict.notify != 0)
    close_popup = 1
  else
    close_popup = 0
  endif

  var j = job_start('cmd /C ' .. dict.cmd, job_opts)
  if ( job_status(j) == "run" ) && ( !exists('dict.hidden') || (dict.hidden == "0") )
    run_live_update_winid = popup_create("Waiting", {
        pos: "botright",
        line: &lines - 2,
        col: &columns,
        tabpage: -1,
        highlight: 'PmenuSel',
        padding: [0, 1, 0, 1],
        maxwidth: (&columns * 2) / 3,
        })
    run_live_update_bufnr = winbufnr(run_live_update_winid)
    run_tid = timer_start(100, (_) => {
      UpdateBuf()
    }, {repeat: -1})
    setqflist([], " ", { nr: "$", title:  dict.cmd, efm: regexp })
    run_qflist_nr = getqflist({nr: "$"}).nr
  else
    run_live_update_winid = 0
  endif
enddef

export def PopupTerminal()
  var buf = term_start(['cmd'], {hidden: 1, term_finish: 'close'})
  var winopts = {
    minwidth: &columns - 10,
    minheight: 10,
    maxheight: &lines - 10,
    border: [1, 1, 1, 1],
    padding: [1, 1, 1, 1]
  }
  g:popup_terminal_winid = popup_create(buf, winopts)
  set wincolor=Terminal
  autocmd VimResized <buffer> popup_move(g:popup_terminal_winid, winopts)
enddef

defcompile
