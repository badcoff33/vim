vim9script

# TODO: Only one job at a time

import autoload "lib/popup.vim"

var run_animation_string = '-\|/'
var run_job_dict: dict<any>
var run_tid: number
var run_animation_winid: number
var run_animation_index: number

export def Append(ch: channel, msg: string)
  call add(run_job_dict['lines'], msg)
enddef

export def Close(ch: channel)
  var errors = 0
  var warnings = 0
  timer_stop(run_tid)
  if run_animation_winid > 0
    popup_close(run_animation_winid)
    run_animation_winid = 0
  endif
  call setqflist([], "r", run_job_dict)
  for entry in run_job_dict
    if has_key(entry, "type")
      errors = errors + (entry["type"] == e)?1:0
      warnings = warnings + (entry["type"] == w)?1:0
    endif
  endfor
  var text = "[" .. len(run_job_dict) .. " lines | " .. warnings .. " warnings | " .. errors .. " errors]"
  if has_key(run_job_dict, "popup") && run_job_dict["popup"] == 1
    var winid = popup.over_statusline(text)
    setwinvar(winid, "&wrap", 0)
  endif
  doautocmd QuickFixCmdPost make
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

  run_job_dict = {title: dict["cmd"], lines: [], efm: regexp, popup: close_popup}

  var j = job_start('cmd /C ' .. dict['cmd'], job_opts)
  if ( job_status(j) == "run" ) && ( !exists('dict.hidden') || (dict.hidden == "0") )
    run_tid = timer_start(200, function("run#Alive"), {repeat: -1})
    run_animation_index = 0
    #run_animation_winid = popup_create(run_animation_string[0], {
    run_animation_winid = popup_create("[0]", {
      line: &lines - 1,
      col: 1,
      tabpage: -1,
      highlight: 'PmenuSel',
      padding: [0, 0, 0, 0]
    })
  else
    run_animation_winid = 0
  endif
enddef

export def Alive(tid: number)
  # if run_animation_index >= ( len(run_animation_string) - 1 )
  #   run_animation_index = 0
  # else
  #   run_animation_index += 1
  # endif
  setbufline(winbufnr(run_animation_winid), 1, len(run_job_dict))
  #run_animation_string[run_animation_index])
enddef

export def PopupTerminal()
  buf = term_start(['cmd'], {hidden: 1, term_finish: 'close'})
  winopts = {minwidth: &columns - 10 , minheight: 10, maxheight: &lines - 10, border:[1,1,1,1], padding:[1,1,1,1]}
  g:popup_terminal_winid = popup_create(buf, winopts)
  set wincolor=Terminal
  autocmd VimResized <buffer> popup_move(g:popup_terminal_winid, winopts)
enddef
