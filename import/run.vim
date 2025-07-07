vim9script

# IDEAS: What about run a make with :terminal and :cbuffer. Much simpler?

import "popnews.vim"

g:run_dict = {}
g:run_be_verbose = false

var run_hl_normal = 'PopupNotification'
var run_hl_error  = 'ErrorMsg'
var animation_index = 0

def OnTimerRunJob(tid: number)
  var job_status: string
  var ch_desc: dict<any>
  var ch: string
  var desc: dict<any>

  def GetAnimationStr(): string
    #const animations = [ "BUSY", "_USY", "B_SY", "BU_Y", "BUS_" ]
    const animations = [ '|', '/', '-', '\' ]
    animation_index += 1
    if animation_index == len(animations)
      animation_index = 0
    endif
    return animations[animation_index]
  enddef

  def PickChDict(timer_id: number): dict<any>
    return filter(copy(g:run_dict), (k, v) =>
      (g:run_dict[k].timer == timer_id) ? true : false
    )
  enddef

  ch_desc = PickChDict(tid)
  if len(ch_desc) != 1
    return
  endif

  ch = keys(ch_desc)[0]
  desc = values(ch_desc)[0]

  job_status = job_status(desc.job)
  if job_status == "run"
    popup_settext(desc.winid,
      printf("%s %s",
        desc.short_cmd,
        GetAnimationStr(),
      ))
  else
    if has_key(desc, "winid")
      popnews.Close(desc.winid)
    endif
    timer_stop(desc.timer)
    remove(g:run_dict, ch)
    popnews.Open($"job terminated with '{job_status}'", {
      t: 4000,
      hl: run_hl_normal
    })
  endif
enddef

def GetJobChannel(j: job): string
  return split(string(job_getchannel(j)), "")[1]
enddef

def OnError(ch: channel,  msg: string)
  var ch_nr = split(string(ch), " ")[1]
  var desc = g:run_dict[ch_nr]

  if has_key(desc, "winid")
    popnews.Close(desc.winid)
  endif
  if has_key(desc, "timer")
    timer_stop(desc.timer)
  endif
  popnews.Open("Error:" .. msg, {
    t: 4000,
    hl: run_hl_error
  })
  remove(g:run_dict, ch_nr)
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

export def OnCloseBuf(ch: channel)
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
  normal Gzb
  # search('\^^^^', 'b')
  # normal zt
  try
    Callback = function(g:run_dict[ch_nr].callback)
    Callback()
  catch /.*/
  endtry
  remove(g:run_dict, ch_nr)
enddef

export def OnChannelData(ch: channel, dat: any)
  var ch_nr = split(string(ch), " ")[1]
  var desc = g:run_dict[ch_nr]
  var dat_nolf = substitute(dat, '\r', '', 'g')

  desc.count += 1
  setqflist([], "a", {
    nr: desc.qfnr,
    efm: desc.regexp,
    lines: [dat_nolf]
  })
  popup_settext(g:run_dict[ch_nr].winid,
    printf($"running {desc.short_cmd} | {desc.count} lines"
    ))
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
  var desc = {}

  job_opt = {
    cwd: get(in_desc, "cwd", getcwd()),
    callback: function("OnChannelData"),
    close_cb: function("OnCloseQf"),
  }
  if has_key(in_desc, "show_err") && in_desc.show_err == true
    job_opt.err_cb = function("OnError")
  endif

  desc = {
      full_cmd: in_desc.cmd,
      short_cmd: split(in_desc.cmd, " ")[0],
      regexp: has_key(in_desc, "regexp") ? in_desc.regexp : &errorformat,
      name: "quickfix",
      callback: get(in_desc, "callback", ""),
      started: localtime(),
      # timer: timer_start(300, OnTimerRunJob, {repeat: -1}),
      cwd: job_opt.cwd,
      winid: 0,
      count: 0
  }
  if !(has_key(in_desc, "no_popup") && (in_desc.no_popup == true))
    desc.winid = popnews.Open(
      printf($"running {desc.short_cmd} | {desc.count} lines"), {
        no_timeout: true,
        hl: run_hl_normal
      })
  endif

  desc.job = job_start("cmd /C " .. in_desc.cmd, job_opt)

  setqflist([], " ", {
    nr: "$",
    efm: desc.regexp,
    title: desc.full_cmd
  })
  desc.qfnr = getqflist({nr: "$"}).nr
  PushChistoryStack(desc.qfnr)

  g:run_dict[GetJobChannel(desc.job)] = desc

  return desc.job
enddef

def StartNamedBuffer(in_desc: dict<any>): job
  var lines: number
  var job_opt = {}
  var desc = {}

  var out_buffer_nr: number

  out_buffer_nr = bufadd(in_desc.name)
  bufloaded(out_buffer_nr)
  setbufvar(out_buffer_nr, "&buftype", "nofile")
  setbufvar(out_buffer_nr, "&readonly", false)
  setbufvar(out_buffer_nr, "&modifiable", true)

  desc = {
    name: in_desc.name,
    bufnr: out_buffer_nr,
    full_cmd: in_desc.cmd,
    short_cmd: split(in_desc.cmd, " ")[0],
    callback: get(in_desc, "callback", ""),
    started: localtime(),
    # timer: timer_start(500, OnTimerRunJob, {repeat: -1}),
    cwd: get(in_desc, "cwd", getcwd()),
  }

  job_opt = {
    err_io: "buffer",
    out_io: "buffer",
    err_buf: out_buffer_nr,
    out_buf: out_buffer_nr,
    cwd: desc.cwd,
    close_cb: function("OnCloseBuf"),
  }
  if has_key(in_desc, "show_err") && in_desc.show_err == true
    job_opt.err_cb = function("OnError")
  endif
  if !(has_key(in_desc, "no_popup") && (in_desc.no_popup == true))
    desc.winid = popnews.Open(
      printf($"{desc.short_cmd}"), {
        no_timeout: true,
        hl: run_hl_normal
      })
  endif

  desc.job = job_start("cmd /C " .. in_desc.cmd, job_opt)

  g:run_dict[GetJobChannel(desc.job)] = desc
  setbufline(
    out_buffer_nr,
    "$",
    ["", $"^^^^ {strftime('%T')} / {desc.full_cmd} / in '{desc.cwd}'", ""]
  )

  return desc.job
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
