vim9script

import "popnews.vim"

g:run_dict = {}
g:run_be_verbose = false

var run_hl_normal = 'PopupNotification'
var run_hl_error  = 'ErrorMsg'
var animation_index = 0

def GetJobChannel(j: job): string
  return split(string(job_getchannel(j)), "")[1]
enddef

def OnError(ch: channel,  msg: string)
  var ch_nr = split(string(ch), " ")[1]
  var desc = g:run_dict[ch_nr]

  if !has_key(g:run_dict[ch_nr], "winid_error")
    g:run_dict[ch_nr].winid_error = popnews.Open("Error: " .. desc.short_cmd, {
      t: 4000,
      hl: run_hl_error
    })
  endif
  # remove(g:run_dict, ch_nr)

enddef

export def OnCloseQf(ch: channel)
  var Callback: func
  var ch_nr = split(string(ch), " ")[1]
  var desc = g:run_dict[ch_nr]
  var num = 0
  var tim: number

  execute "cbuffer" g:run_dict[ch_nr].bufnr

  tim = localtime() - desc.started
  num = getqflist({'nr': '$', 'size': 0}).size

  try
    Callback = function(desc.callback)
    Callback()
  catch /.*/
  endtry

  popnews.Open(
    $"{desc.short_cmd} | {num} {num == 1 ? 'hit' : 'hits'}| {tim} sec",
    {t: 4000, hl: run_hl_normal}
  )

  if has_key(g:run_dict[ch_nr], "winid")
    timer_start(4000, (timer) => {
      popnews.Close(g:run_dict[ch_nr].winid)
      remove(g:run_dict, ch_nr)
    })
  else
    remove(g:run_dict, ch_nr)
  endif

  # act like :make
  # silent doautocmd QuickFixCmdPost make

enddef

export def OnCloseBuf(ch: channel)
  var Callback: func
  var ch_nr = split(string(ch), " ")[1]

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
  var out_buffer_nr: number
  var name: string

  name = 'RUN-' .. toupper(split(in_desc.cmd, " ")[0])
  out_buffer_nr = bufadd(name)
  bufloaded(out_buffer_nr)
  setbufvar(out_buffer_nr, "&buftype", "nofile")
  setbufvar(out_buffer_nr, "&readonly", false)
  setbufvar(out_buffer_nr, "&modifiable", true)

  deletebufline(out_buffer_nr, 1, '$')

  desc = {
    name: name,
    bufnr: out_buffer_nr,
    full_cmd: in_desc.cmd,
    short_cmd: split(in_desc.cmd, " ")[0],
    callback: get(in_desc, "callback", ""),
    started: localtime(),
    cwd: get(in_desc, "cwd", getcwd()),
  }

  job_opt = {
    err_io: "buffer",
    out_io: "buffer",
    err_buf: out_buffer_nr,
    out_buf: out_buffer_nr,
    cwd: desc.cwd,
    close_cb: function("OnCloseQf"),
    err_cb: function("OnError")
  }

  if !((has_key(in_desc, "no_popup") && (in_desc.no_popup == true)))
    desc.winid = popnews.Open(
      printf($"{desc.short_cmd} :b{out_buffer_nr}"), {
        no_timeout: true,
        hl: run_hl_normal
      })
  endif

  desc.job = job_start("cmd /C " .. in_desc.cmd, job_opt)

  g:run_dict[GetJobChannel(desc.job)] = desc

  return desc.job
enddef

def StartNamedBuffer(in_desc: dict<any>): job
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
    cwd: get(in_desc, "cwd", getcwd()),
  }

  job_opt = {
    err_io: "buffer",
    out_io: "buffer",
    err_buf: out_buffer_nr,
    out_buf: out_buffer_nr,
    cwd: desc.cwd,
    close_cb: function("OnCloseBuf"),
    err_cb: function("OnError")
  }

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
