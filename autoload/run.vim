|
vim9script

import autoload "lib/popup.vim" as popup

var run_animation_string = '-\|/'
var run_job_dict: dict<any>
var run_tid: number
var run_animation_winid: number
var run_animation_index: number
var run_live_output: number
var run_popup: number

export def Append(ch: channel, msg: string)
  add(run_job_dict['lines'], msg)
  if run_live_output == 1
    setqflist([], "r", run_job_dict)
  endif
enddef

export def Close(ch: channel)
  timer_stop(run_tid)
  if run_animation_winid > 0
    popup_close(run_animation_winid)
  endif
  if run_live_output == 0
    setqflist([], "r", run_job_dict)
  endif
  if run_popup == 1
    var winid = popup.over_statusline("job done: " .. run_job_dict["title"])
    setwinvar(winid, "&wrap", 0)
  endif
  if exists("QuickFixCmdPost")
    doautocmd QuickFixCmdPost make
  endif
enddef

export def HiddenError(ch: channel,  msg: string)
  echohl ErrorMsg
  echo 'error reported by ch' ch_info(ch)['id'] '-->' msg
  echohl None
enddef

export def Run(args: dict<any>)
  var job_opts = {}
  var regexp: string
  var close_popup: number

  run_live_output = 1

  if !has_key(args, "nowrite") || (args.nowrite == 0)
    if &autowrite || &autowriteall
      try
        silent wall
      catch /.*/
        echoerr "run#run: not all modified buffers written"
      finally
      endtry
    endif
  endif

  if has_key(args, "cwd")
    job_opts.cwd = args.cwd
  else
    job_opts.cwd = getcwd()
  endif

  if has_key(args, "live")

  endif

  if has_key(args, "hidden") && (args.hidden == 1)
    job_opts.err_cb = function("run#HiddenError")
  else
    job_opts.out_cb = function("run#Append")
    job_opts.err_cb = function("run#Append")
    job_opts.close_cb = function("run#Close")
  endif

  if has_key(args, "cwd")
    job_opts.cwd = args.cwd
  endif

  if has_key(args, "regexp")
    regexp = args.regexp
  else
    regexp = &errorformat
  endif

  if has_key(args, "notify") && (args.notify == 1)
    run_popup = 1
  else
    run_popup = 0
  endif

  if has_key(args, "cmd")
    var j = job_start('cmd /C ' .. args['cmd'], job_opts)
    if ( job_status(j) == "run" ) && has_key(args, "hidden") && args.hidden == 1
      run_tid = timer_start(200, function("run#Alive"), {repeat: -1})
      run_animation_index = 0
      run_animation_winid = popup_create(run_animation_string[0], {
        line: &lines - 1,
        col: 1,
        tabpage: -1,
        highlight: 'PmenuSel',
        padding: [0, 0, 0, 0]
      })
    else
      run_animation_winid = 0
    endif
    run_job_dict = {title: args["cmd"], lines: [], efm: regexp}
    if run_live_output == 1
      setqflist([], "r", run_job_dict)
    endif
  else
    echoerr "no command"
  endif
enddef

export def Alive(tid: number)
  if run_animation_index >= ( len(run_animation_string) - 1 )
    run_animation_index = 0
  else
    run_animation_index += 1
  endif
  setbufline(winbufnr(run_animation_winid), 1, run_animation_string[run_animation_index])
enddef

export def PopupTerminal()
  buf = term_start(['cmd'], {hidden: 1, term_finish: 'close'})
  winopts = {minwidth: &columns - 10 , minheight: 10, maxheight: &lines - 10, border:[1,1,1,1], padding:[1,1,1,1]}
  g:popup_terminal_winid = popup_create(buf, winopts)
  set wincolor=Terminal
  autocmd VimResized <buffer> popup_move(g:popup_terminal_winid, winopts)
enddef
