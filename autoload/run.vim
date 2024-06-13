vim9script

import autoload "popnews.vim"

g:run_dict = []
g:run_be_verbose = false
g:run_hl_normal = get(g:, 'run_hl_normal', 'PmenuSel')
g:run_hl_error  = get(g:, 'run_hl_error', 'ErrorMsg')

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
  for d in g:run_dict
    if d.channel == ch_nr
      if has_key(d, "winid")
        popnews.Close(d.winid)
      endif
      if has_key(d, "timer")
        timer_stop(d.timer)
      endif
      popnews.Open("Error:" .. msg, 4000, g:run_hl_error)
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
  for d in g:run_dict
    if d.channel == ch_nr
      if has_key(d, "timer")
        timer_stop(d.timer)
      endif
      if has_key(d, "winid")
        popnews.Close(d.winid)
      endif
      if d.name == "quickfix"
        buflines = getbufline(d.bufnr, 1, "$")
        if buflines != [""] # is it empty?
          setqflist([], " ", {
            efm: d.regexp,
            title: d.full_cmd,
            lines: filter(buflines, 'v:val !~ "^\s*$"')
          })
          for e in getqflist({ "nr": "$", "all": 0 }).items
            lines = lines + 1
            num_warnings += e.type ==? "w" ? 1 : 0
            num_errors += e.type ==? "e" ? 1 : 0
          endfor
        endif
        var done_str = printf("%s took %d sec | %d lines",
          d.short_cmd,
          localtime() - d.started,
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
        popnews.Open(done_str, 4000, g:run_hl_normal)
      else
        var cut_here = ['--------------------------------------------------------------------------------']
        var b = bufadd(d.name)
        lines = getbufinfo(b)[0].linecount
        execute "drop" d.name
        setlocal noreadonly modifiable
        setline(lines + 1, cut_here + ['(' .. strftime("%T") .. ') ' .. d.full_cmd] + getbufline(d.bufnr, 1, "$"))
        # setline(lines + 1, ['(' .. strftime("%T") .. ') ' .. d.full_cmd] + getbufline(d.bufnr, 1, "$"))
        setlocal buftype=nofile nomodified readonly nomodifiable
        setpos(".", [b, lines + 1, 0, 0])
        normal Gzb
      endif
      execute "silent bwipe" d.bufnr
      try
        Callback = function(d.callback)
        Callback()
      catch /.*/
      endtry
      RemoveChannelFromDict(d.channel)
      break
    endif
  endfor
  # act like :make
  # silent doautocmd QuickFixCmdPost make
enddef

export def BackgroundErrorCb(ch: channel,  msg: string)
  var ch_nr = split(string(ch), " ")[1]
  for d in g:run_dict
    if d.channel == ch_nr
      timer_stop(d.timer)
      if has_key(d, "winid")
        popnews.Close(d.winid)
      endif
      echohl ErrorMsg
      echo "error reported by channel" ch_info(ch)["id"] "-->" msg
      echohl None
      RemoveChannelFromDict(ch_nr)
      break
    endif
  endfor
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

  for d in g:run_dict
    if d.winid > 0
      job_status = job_status(d.job)
      if job_status == "run"
        if has_key(d, "timer") && d.timer == tid
          popup_settext(d.winid,
            printf("%s %s %d lines",
              d.short_cmd,
              GetAnimationStr(),
              getbufinfo(d.bufnr)[0].linecount
            ))
          break
        endif
      else
        popnews.Close(d.winid)
        timer_stop(d.timer)
        if job_status == "fail"
          popnews.Open("XXXX job failed", 4000, g:run_hl_normal)
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
  job_opts.cwd = has_key(dict, "cwd") ? dict.cwd : getcwd()
  job_opts.err_cb = function("run#BackgroundErrorCb")
  v_job = job_start("cmd /C " .. dict.cmd, job_opts)
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
  if has_key(dict, "no_popup") && (dict.no_popup == true)
    run_dict_entry.winid = 0
  else
    run_dict_entry.winid = popnews.Open(
      printf(
        "%s %s %d lines",
        run_dict_entry.short_cmd,
        animations[0],
        0),
      0, # permanent
      g:run_hl_normal
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

export def KillAll(signal: string)
  for j in job_info()
    job_stop(j, signal)
  endfor
enddef

command! -bar -complete=custom,CompleteKillAll -nargs=1 KillAll call KillAll("<args>")

# Uncomment when testing
defcompile
