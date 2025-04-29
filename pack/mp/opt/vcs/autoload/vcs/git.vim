vim9script

import 'run.vim' as run
import 'popnews.vim' as pop

var capture_file_status: dict<dict<any>>
var popup_duration = 6000

g:vcs_git_changed_files = []

export def GetRootDir(dir: string): string
  var main_dir: string
  var module_dir: string

  if !isdirectory(dir)
    return ""
  endif

  module_dir = findfile(".git", dir .. ";", 1)
  if module_dir == ""
    main_dir = finddir(".git", dir .. ";", 1)
    if main_dir == ""
      return ""
    else
      return fnamemodify(main_dir, ":h")
    endif
  else
    return simplify(module_dir .. "/..")
  endif
enddef

def OnLogDone(raw_list: list<string>)
  pop.Open($"{(len(raw_list) > 0) ? raw_list[0] : 'untracked file'}", {
    t: popup_duration,
    hl: 'PopupNotification'
  })
enddef

def OnFileStatus(raw_list: list<string>)
  pop.Open($"Status: {(len(raw_list) == 0) ? 'unchanged' : raw_list[0]}", {
    t: popup_duration,
    hl: 'PopupNotification'
  })
enddef

export def FileInfo(ifile = "")
  var file: string
  var filepath: string
  var output1: list<string>
  var output2: list<string>
  var root: string

  if ifile == ""
    file = fnamemodify(bufname("%"), ":p")
    filepath = fnamemodify(bufname("%"), ":p:h")
  else
    file = fnamemodify(ifile, ":p")
    filepath = fnamemodify(ifile, ":p:h")
  endif

  root = GetRootDir(filepath)
  pop.Open($"Repository: \"{root}\"", {
    t: popup_duration,
    hl: 'PopupNotification'
  })

  job_start($"git log --pretty=oneline --abbrev-commit -n 1 {file}", {
    cwd: root,
    callback: (_, data) => add(output2, data),
    exit_cb: (_, data) => OnLogDone(output2),
  })

  job_start($"git status -s {file}", {
    cwd: root,
    callback: (_, data) => add(output1, data),
    exit_cb: (_, data) => OnFileStatus(output1),
  })
enddef

# Description: called by auto-command
export def SetLocalVar()

  var key: string
  var j_new: job

  def OnCapture(c: channel, d: string)
    var k = split(string(c), " ")[1]
    if d =~ '^##\s[a-zA-Z0-9]'
      capture_file_status[k].branch = split(d, '\( \|\.\{3\}\)')[1]
    elseif d =~# '^.M'
      capture_file_status[k].status = "~"
    elseif d =~# '^.A'
      capture_file_status[k].status = "+"
    elseif d =~# '^.R'
      capture_file_status[k].status = "-"
    endif
  enddef

  def OnExitBranchVar(j: job, s: number)
    var k = split(string(job_info(j).channel), " ")[1]
    if s == 0
      setbufvar(capture_file_status[k].buf, "vcs_branch_name", capture_file_status[k].branch)
      setbufvar(capture_file_status[k].buf, "vcs_status", capture_file_status[k].status)
    else
      setbufvar(capture_file_status[k].buf, "vcs_branch_name", "")
      setbufvar(capture_file_status[k].buf, "vcs_status", "")
    endif
    remove(capture_file_status, k)
  enddef

  if (&buftype != "") || !filereadable(bufname("%"))
    return # when nofile, quickfix, help, terminal, ...
  endif
  j_new = job_start($"git status -b -s {fnamemodify(bufname('%'), ':t')}", {
    cwd: expand("%:p:h"),
    callback: OnCapture,
    exit_cb: OnExitBranchVar
  })

  key = split(string(job_info(j_new).channel), " ")[1]
  capture_file_status[key] = {
    buf: bufnr('%'),
    branch: "",
    status: ""
  }

enddef

export def CompleteGit(arg_lead: string, cmd_line: string, cur_pos: number): list<string>

  def GetBranche(): list<string>
    var names: list<string>
    var branches = systemlist("git branch")
    for e in branches
      add(names, substitute(e, "[* ] ", "", ""))
    endfor
    return names
  enddef

  def GetChangedFiles(): list<string>
    if g:vcs_git_changed_files == []
      g:vcs_git_changed_files = systemlist("git ls-files --modified")
    endif
    return g:vcs_git_changed_files
  enddef

  var candidates = [
    "restore", "switch", "status", "add", "commit", "diff",
    "branch", "remote", "push", "pull", "fetch"
  ]
  var git_sub_cmd = matchstr(substitute(cmd_line, 'Git\s\+', '', ''), '\w\+')

  if index(candidates, git_sub_cmd) == -1
    filter(candidates, (idx, val) => val =~ '^' .. git_sub_cmd)
  elseif git_sub_cmd == "switch" || git_sub_cmd == "branch"
    candidates  = GetBranche()
    filter(candidates, (idx, val) => val =~ arg_lead)
  else
    candidates = GetChangedFiles()
    filter(candidates, (idx, val) => val =~ arg_lead)
  endif
  return candidates
enddef

export def Vimdiff(file = "")
  var rev: string
  var bname: string
  var head: string
  var tail: string
  var save_dir: string

  if file == ""
    bname = bufname("%")
    head = fnamemodify(bufname("%"), ":p:h")
    tail = fnamemodify(bufname("%"), ":t")
  else
    bname = file
    head = fnamemodify(file, ":p:h")
    tail = fnamemodify(file, ":t")
  endif

  save_dir = getcwd()

  inputsave()
  rev = input("revision (HEAD~[1...]): ", "HEAD~1")
  inputrestore()
  if rev == ""
    return
  endif

  execute $"silent tabedit {bname}"
  setlocal nocursorline
  diffthis

  vert new
  setlocal buftype=nofile nobuflisted nocursorline
  try
    execute $"silent noautocmd cd {head}"
    silent execute $"read ++edit !git show {rev}:./{tail}"
  catch
    echo $"error in git show {rev}:./{tail}"
  finally
    execute $"silent noautocmd cd {save_dir}"
  endtry

  silent normal gg0d_
  diffthis

  nnoremap <buffer> c :bwipeout<CR>:tabclose<CR>
enddef

# Description: Run Git asynchronous and redirect output to buffer
export def Execute(git_command: string)
  run.RunStart({
    cmd: 'git ' .. git_command,
    cwd: getcwd(),
    name: "GIT-Output"
  })
enddef

augroup GroupVcsGit
  autocmd!
  autocmd BufWinEnter GIT-Output setf vcs_output
  autocmd BufWinEnter GIT-Output nnoremap <buffer> <CR> :Git<Space>
  autocmd BufWinEnter GIT-Output nnoremap <buffer> a :Git add <C-r><C-f><CR>
  autocmd BufWinEnter GIT-Output nnoremap <buffer> d :Git diff <C-r>yC-f><CR>
  autocmd CmdlineEnter : g:vcs_git_changed_files = []
augroup END

# Uncomment when testing
defcompile
