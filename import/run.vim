vim9script

import "popnews.vim"

g:run_dict = {}
g:run_be_verbose = false

var run_hl_normal = 'PopupNotification'
var run_hl_error  = 'ErrorMsg'

#var animations = ["----", "BUSY"]
var animations = [ "BUSY", "_USY", "B_SY", "BU_Y", "BUS_" ]
#var animations = [ '*', '-' ]
var animation_index = 0

def GetAnimationStr(): string
  animation_index += 1
  if animation_index == len(animations)
    animation_index = 0
  endif
  return animations[animation_index]
enddef

def RunJobMonitoringCb(tid: number)
  var job_status: string

  for ch in keys(g:run_dict)
    if g:run_dict[ch].winid > 0
      job_status = job_status(g:run_dict[ch].job)
      if job_status == "run"
        if has_key(g:run_dict[ch], "timer") && g:run_dict[ch].timer == tid
          popup_settext(g:run_dict[ch].winid,
            ##printf("%s %s %d lines",
            printf("%s %s",
              g:run_dict[ch].short_cmd,
              GetAnimationStr(),
            ))
          break
        endif
      else
        popnews.Close(g:run_dict[ch].winid)
        timer_stop(g:run_dict[ch].timer)
        if job_status == "fail"
          popnews.Open("job failed", {
            t: 4000,
            hl: run_hl_normal
          })
        endif
      endif
    endif
  endfor
enddef

def GetJobChannel(j: job): string
  return split(string(job_getchannel(j)), "")[1]
enddef

def OnError(ch: channel,  msg: string)
  var ch_nr = split(string(ch), " ")[1]
  var ch_desc = g:run_dict[ch]

  if has_key(ch_desc, "winid")
    popnews.Close(ch_desc.winid)
  endif
  if has_key(ch_desc, "timer")
    timer_stop(ch_desc.timer)
  endif
  popnews.Open("Error:" .. msg, {t: 4000, hl: run_hl_error})
enddef

export def OnCloseQf(ch: channel)
  var Callback: func
  var ch_nr = split(string(ch), " ")[1]
  var lines = 0
  var num_errors = 0
  var num_warnings = 0

  if has_key(g:run_dict[ch_nr], "timer")
    timer_stop(g:run_dict[ch_nr].timer)
  endif
  if has_key(g:run_dict[ch_nr], "winid")
    popnews.Close(g:run_dict[ch_nr].winid)
  endif

  var tim = localtime() - g:run_dict[ch_nr].started
  var done_str = $"{g:run_dict[ch_nr].short_cmd} took {tim} sec"
  for e in getqflist({ "nr": g:run_dict[ch_nr].qfnr, "all": 0 }).items
    lines = lines + 1
    num_warnings += (e.type ==? "w") ? 1 : 0
    num_errors += (e.type ==? "e") ? 1 : 0
  endfor
  if (num_warnings + num_errors) > 0
    done_str ..= $" | {num_warnings} warning{(num_warnings > 1) ? 's' : ''}"
    done_str ..= $" | {num_errors} error{(num_errors > 1) ? 's' : ''}"
  endif
  popnews.Open(done_str, {t: 4000, hl: run_hl_normal})
  try
    Callback = function(g:run_dict[ch_nr].callback)
    Callback()
  catch /.*/
  endtry
  remove(g:run_dict, ch_nr)
  # act like :make
  # silent doautocmd QuickFixCmdPost make
enddef

export def CbCloseBuf(ch: channel)
  var Callback: func
  var ch_nr = split(string(ch), " ")[1]
  var lines: number

  if has_key(g:run_dict[ch_nr], "timer")
    timer_stop(g:run_dict[ch_nr].timer)
  endif
  if has_key(g:run_dict[ch_nr], "winid")
    popnews.Close(g:run_dict[ch_nr].winid)
  endif

  execute $"buffer {g:run_dict[ch_nr].bufnr}"
  setlocal buftype=nofile nomodified readonly nomodifiable
  normal G
  search('\^^^^', 'b')
  normal zt
  try
    Callback = function(g:run_dict[ch_nr].callback)
    Callback()
  catch /.*/
  endtry
  remove(g:run_dict, ch_nr)
enddef

export def OnChannelData(ch: channel, dat: any)
  var ch_nr = split(string(ch), " ")[1]
  var dat_nolf = substitute(dat, '\r', '', 'g')

  setqflist([], "a", {
    nr: g:run_dict[ch_nr].qfnr,
    efm: g:run_dict[ch_nr].regexp,
    lines: [dat_nolf]
  })
enddef

def ConditionalWriteAll(dict: dict<any>)
  if has_key(dict, "no_write") && (dict.no_write == true)
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

export def RunStart(jdesc: dict<any>): job
  var j: job
  if !has_key(jdesc, 'cmd') && (jdesc.cmd != "")
    echoerr expand("<sfile>") .. ": key 'cmd' required"
    return null_job
  endif
  if g:run_be_verbose == true
    for k in keys(jdesc)
      echo "run jdesc:" k "=" jdesc[k]
    endfor
  endif
  ConditionalWriteAll(jdesc)
  # act like :make
  # silent doautocmd QuickFixCmdPre make
  if has_key(jdesc, "background") && (jdesc.background == true)
    j = StartBackground(jdesc)
  elseif has_key(jdesc, "name")
    j = StartNamedBuffer(jdesc)
  else
    j = StartQuickfix(jdesc)
  endif
  return j
enddef


def StartBackground(in_desc: dict<any>): job
  var j: job
  var short_cmd: string
  var buffer_name: string
  var out_buffer_nr: number
  var log_cmd: list<string>

  short_cmd = split(in_desc.cmd, " ")[0]
  buffer_name = 'RUN-LOG-' .. toupper(short_cmd)
  out_buffer_nr = bufadd(buffer_name)
  log_cmd = [
    "[" .. strftime("%T") .. "]" .. in_desc.cmd,
    ""
  ]
  setbufline(out_buffer_nr, "$", log_cmd)
  j = job_start("cmd /C " .. in_desc.cmd, {
      cwd: has_key(in_desc, "cwd") ? in_desc.cwd : getcwd(),
      out_io: 'buffer',
      err_io: 'buffer',
      out_buf: out_buffer_nr,
      err_buf: out_buffer_nr,
  })
  return j
enddef

def StartQuickfix(in_desc: dict<any>): job
  var job_opt = {}
  var ch_desc = {}

  job_opt = {
    cwd: get(in_desc, "cwd", getcwd()),
    callback: function("OnChannelData"),
    close_cb: function("OnCloseQf"),
  }
  if has_key(in_desc, "show_err") && in_desc.show_err == true
    job_opt.err_cb = function("OnError")
  endif

  ch_desc = {
      full_cmd: in_desc.cmd,
      short_cmd: split(in_desc.cmd, " ")[0],
      regexp: has_key(in_desc, "regexp") ? in_desc.regexp : &errorformat,
      name: "quickfix",
      callback: get(in_desc, "callback", ""),
      started: localtime(),
      timer: timer_start(500, RunJobMonitoringCb, {repeat: -1}),
      cwd: job_opt.cwd,
      winid: 0
  }
  if !(has_key(in_desc, "no_popup") && (in_desc.no_popup == true))
    ch_desc.winid = popnews.Open(
      printf($"{ch_desc.short_cmd} {animations[0]}"), {
        no_timeout: true,
        hl: run_hl_normal
      })
  endif

  ch_desc.job = job_start("cmd /C " .. in_desc.cmd, job_opt)

  setqflist([], " ", {
    nr: "$",
    efm: ch_desc.regexp,
    title: ch_desc.full_cmd
  })
  ch_desc.qfnr = getqflist({nr: "$"}).nr
  PushChistoryStack(ch_desc.qfnr)

  g:run_dict[GetJobChannel(ch_desc.job)] = ch_desc

  return ch_desc.job
enddef

def StartNamedBuffer(in_desc: dict<any>): job
  var lines: number
  var job_opt = {}
  var ch_desc = {}

  var out_buffer_nr: number

  out_buffer_nr = bufadd(in_desc.name)
  bufloaded(out_buffer_nr)
  setbufvar(out_buffer_nr, "&buftype", "nofile")
  setbufvar(out_buffer_nr, "&readonly", false)
  setbufvar(out_buffer_nr, "&modifiable", true)

  ch_desc = {
    name: in_desc.name,
    bufnr: out_buffer_nr,
    full_cmd: in_desc.cmd,
    short_cmd: split(in_desc.cmd, " ")[0],
    callback: get(in_desc, "callback", ""),
    started: localtime(),
    timer: timer_start(500, RunJobMonitoringCb, {repeat: -1}),
    cwd: get(in_desc, "cwd", getcwd()),
    winid: 0
  }

  job_opt = {
    err_io: "buffer",
    out_io: "buffer",
    err_buf: out_buffer_nr,
    out_buf: out_buffer_nr,
    cwd: ch_desc.cwd,
    close_cb: function("CbCloseBuf"),
  }
  if has_key(in_desc, "show_err") && in_desc.show_err == true
    job_opt.err_cb = function("CbError")
  endif
  if !(has_key(in_desc, "no_popup") && (in_desc.no_popup == true))
    ch_desc.winid = popnews.Open(
      printf($"{ch_desc.short_cmd} {animations[0]}"), {
        no_timeout: true,
        hl: run_hl_normal
      })
  endif

  ch_desc.job = job_start("cmd /C " .. in_desc.cmd, job_opt)

  g:run_dict[GetJobChannel(ch_desc.job)] = ch_desc
  setbufline(
    out_buffer_nr,
    "$",
    ["", $"^^^^^^ {strftime('%T')} / {ch_desc.full_cmd} / in '{ch_desc.cwd}'"]
  )

  return ch_desc.job
enddef

def PushChistoryStack(chistory_nr: number)
  if chistory_nr == 10  # handle full qf-history
    for key_ch in keys(g:run_dict)
      if (has_key(g:run_dict[key_ch], "qfnr")
          && (g:run_dict[key_ch].qfnr > 1)
          && (g:run_dict[key_ch].qfnr < 10))
          g:run_dict[key_ch].chistory_nr -= 1
      endif
    endfor
  endif
enddef

var complete_candidates = [
  "term",   # terminate process forcedly (default)
  "hup",    # CTRL_BREAK
  "quit",   # CTRL_BREAK
  "int",    # CTRL_C
  "kill",   # terminate process forcedly
  "Others", # CTRL_BREAK
]

def CompleteKillAll(arg_lead: string, cmd_line: string, cur_pos: number): string
    var matching_keys: string
    var candidates: list<string>
    var filename: string
    for k in sort(complete_candidates)
        if match(k, arg_lead) >= 0
            matching_keys = matching_keys .. k .. "\n"
        endif
    endfor
    return matching_keys
enddef

export def ShowJobs()
  echo job_info()
enddef

export def KillJobs(signal: string)
  for j in job_info()
    job_stop(j, signal)
  endfor
  popup_clear()
enddef

command! -bar -complete=custom,CompleteKillAll -nargs=1 KillJobs KillJobs("<args>")
command! -bar -nargs=0 ShowJobs ShowJobs()

# Uncomment when testing
defcompile
