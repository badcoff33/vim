vim9script

import autoload "popnews.vim"

g:run_dict = []
g:run_be_verbose = false
var run_hl_normal = 'PopupNotification'
var run_hl_error  = 'ErrorMsg'

def RemoveChannelFromDict(ch: string)
  var r: list<any>
  for e in g:run_dict
    if e.channel != ch
      add(r, e)
    endif
  endfor
  g:run_dict = r
enddef

export def ErrorCb(ch: channel,  msg: string)
  var ch_nr = split(string(ch), " ")[1]
  for dict_entry in g:run_dict
    if dict_entry.channel == ch_nr
      if has_key(dict_entry, "winid")
        popnews.Close(dict_entry.winid)
      endif
      if has_key(dict_entry, "timer")
        timer_stop(dict_entry.timer)
      endif
      popnews.Open("Error:" .. msg, {t: 4000, hl: run_hl_error})
    endif
  endfor
enddef

export def CloseCb(ch: channel)
  var Callback: func
  var ch_nr = split(string(ch), " ")[1]
  var lines = 0
  var num_errors = 0
  var num_warnings = 0
  var buflines: list<string>
  for dict_entry in g:run_dict
    if dict_entry.channel == ch_nr
      if has_key(dict_entry, "timer")
        timer_stop(dict_entry.timer)
      endif
      if has_key(dict_entry, "winid")
        popnews.Close(dict_entry.winid)
      endif
      if dict_entry.name == "quickfix"
        buflines = getbufline(dict_entry.bufnr, 1, "$")
        if buflines != [""] # is it empty?
          setqflist([], " ", {
            efm: dict_entry.regexp,
            title: dict_entry.full_cmd,
            lines: filter(buflines, 'v:val !~ "^\s*$"')
          })
          for e in getqflist({ "nr": "$", "all": 0 }).items
            lines = lines + 1
            num_warnings += e.type ==? "w" ? 1 : 0
            num_errors += e.type ==? "e" ? 1 : 0
          endfor
        endif
        var done_str = printf("%s took %d sec | %d lines",
          dict_entry.short_cmd,
          localtime() - dict_entry.started,
          lines)
        if (num_warnings + num_errors) > 0
          cfirst
          if num_warnings == 1
            done_str ..= printf(" | %d warning", num_warnings)
          elseif num_warnings > 1
            done_str ..= printf(" | %d warnings", num_warnings)
          endif
          if num_errors == 1
            done_str ..= printf(" | %d error", num_errors)
          elseif num_errors > 1
            done_str ..= printf(" | %d errors", num_errors)
          endif
        endif
        popnews.Open(done_str, {t: 4000, hl: run_hl_normal})
      else
        var cut_here = ['--------------------------------------------------------------------------------']
        var b = bufadd(dict_entry.name)
        lines = getbufinfo(b)[0].linecount
        execute "drop" dict_entry.name
        setlocal noreadonly modifiable
        setline(lines + 1,
          cut_here
          + ['(' .. strftime("%T") .. ') ' .. dict_entry.full_cmd .. ' in "' .. dict_entry.cwd .. '"']
          + getbufline(dict_entry.bufnr, 1, "$")
        )
        setlocal buftype=nofile nomodified readonly nomodifiable
        setpos(".", [b, lines + 1, 0, 0])
        normal Gzb
      endif
      execute "silent bwipe" dict_entry.bufnr
      try
        Callback = function(dict_entry.callback)
        Callback()
      catch /.*/
      endtry
      RemoveChannelFromDict(dict_entry.channel)
      break
    endif
  endfor
  # act like :make
  # silent doautocmd QuickFixCmdPost make
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

# var animations = ["-___", "_-__", "__-_", "___-", "__-_", "_-__"]
# var animations = [ "|*   |", "| *  |", "|  * |", "|   *|", "|  * |", "| *  |" ]
var animations = [ '*', '-' ]
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

  for dict_entry in g:run_dict
    if dict_entry.winid > 0
      job_status = job_status(dict_entry.job)
      if job_status == "run"
        if has_key(dict_entry, "timer") && dict_entry.timer == tid
          popup_settext(dict_entry.winid,
            printf("%s %s %d lines",
              dict_entry.short_cmd,
              GetAnimationStr(),
              getbufinfo(dict_entry.bufnr)[0].linecount
            ))
          break
        endif
      else
        popnews.Close(dict_entry.winid)
        timer_stop(dict_entry.timer)
        if job_status == "fail"
          popnews.Open("XXXX job failed", {t: 4000, hl: run_hl_normal})
        endif
      endif
    endif
  endfor
enddef

export def RunStart(dict: dict<any>): job
  var v_job: job
  if !has_key(dict, 'cmd') && (dict.cmd != "")
    echoerr "run.vim: key 'cmd' required"
    return null_job
  endif
  if g:run_be_verbose == true
    for k in keys(dict)
      echo "run dict:" k "=" dict[k]
    endfor
  endif
  ConditionalWriteAll(dict)
  # act like :make
  # silent doautocmd QuickFixCmdPre make
  if has_key(dict, "background") && (dict.background == true)
    v_job = StartBackground(dict)
  else
    v_job = StartBuffered(dict)
  endif
  return v_job
enddef


def StartBackground(dict: dict<any>): job
  var v_job: job
  var job_opts = {}
  var out_buffer_nr = bufadd('RUN-LOG')
  v_job = job_start("cmd /C " .. dict.cmd, {
      cwd: has_key(dict, "cwd") ? dict.cwd : getcwd(),
      out_io: 'buffer',
      out_buf: out_buffer_nr,
      err_io: 'buffer',
      err_buf: out_buffer_nr,
  })
  return v_job
enddef

def StartBuffered(dict: dict<any>): job
  var job_opts = {}
  var run_dict_entry = {}
  run_dict_entry.regexp = has_key(dict, "regexp") ? dict.regexp : &errorformat
  run_dict_entry.bufnr = bufadd(dict.cmd)
  setbufvar(run_dict_entry.bufnr, "&buftype", "nofile")
  job_opts.cwd = get(dict, "cwd", getcwd())
  job_opts.err_buf = run_dict_entry.bufnr
  job_opts.out_buf = run_dict_entry.bufnr
  job_opts.err_io = "buffer"
  job_opts.out_io = "buffer"
  job_opts.close_cb = function("run#CloseCb")
  if has_key(dict, "show_err") && dict.show_err == true
    job_opts.err_cb = function("run#ErrorCb")
  endif
  run_dict_entry.full_cmd = dict.cmd
  run_dict_entry.short_cmd = split(dict.cmd, " ")[0]
  run_dict_entry.callback = get(dict, "callback", "")
  run_dict_entry.started = localtime()
  run_dict_entry.timer = timer_start(500, RunJobMonitoringCb, {repeat: -1})
  run_dict_entry.name = get(dict, "name", "quickfix")
  run_dict_entry.cwd = job_opts.cwd
  if has_key(dict, "no_popup") && (dict.no_popup == true)
    run_dict_entry.winid = 0
  else
    run_dict_entry.winid = popnews.Open(
      printf(
        "%s %s %d lines",
        run_dict_entry.short_cmd,
        animations[0],
        0), {
          t: 0, # permanent
          hl: run_hl_normal
        }
    )
  endif
  run_dict_entry.job = job_start("cmd /C " .. dict.cmd, job_opts)
  run_dict_entry.channel = split(string(job_getchannel(run_dict_entry.job)), " ")[1]
  add(g:run_dict, run_dict_entry)
  return run_dict_entry.job
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

export def ListJobs()
  echo job_info()
enddef

export def KillJobs(signal: string)
  for j in job_info()
    job_stop(j, signal)
  endfor
enddef

command! -bar -complete=custom,CompleteKillAll -nargs=1 KillJobs KillJobs("<args>")
command! -bar -nargs=0 ListJobs ListJobs()

# Uncomment when testing
defcompile
