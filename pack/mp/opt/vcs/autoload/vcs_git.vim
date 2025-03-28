vim9script

import 'run.vim' as run
import 'popnews.vim' as pop

var local_branch_name: dict<dict<any>>
var popup_duration = 6000
var popup_duration_short = 2000
var working_dir = ""

g:vcs_git_changed_files = []

def PresetWorkingDir()
  if working_dir == ""
    working_dir = getcwd()
  endif
enddef

def OnBranchInfo(raw_list: list<string>)
  var branch_name: string
  if raw_list[0] =~? 'On branch '
    branch_name = substitute(raw_list[0], 'On branch ', '', '')
  elseif raw_list[0] =~? 'HEAD detached'
    branch_name = raw_list[0]
  else
    branch_name = 'NO BRANCH'
  endif
  pop.Open($"In {working_dir} on {branch_name}", {
    t: popup_duration,
    hl: 'PopupNotification'
  })
enddef

export def ChangeDir(new_working_dir = "")
  var entered_working_dir: string

  if isdirectory(new_working_dir)
    working_dir = fnamemodify(new_working_dir, ":p")
  else
    PresetWorkingDir()
    entered_working_dir = input(
      "Git working directory: ",
      fnamemodify(working_dir, ":p"),
      "dir")
    entered_working_dir = fnamemodify(entered_working_dir, ":p")
    if isdirectory(entered_working_dir)
      working_dir = entered_working_dir
    endif
  endif
  BranchInfo()
enddef

export def BranchInfo()
  var output: list<string>
  PresetWorkingDir()
  job_start('git status -b', {
    cwd: working_dir,
    callback: (_, data) => add(output, data),
    exit_cb: (_, data) => OnBranchInfo(output),
  })
enddef

export def SetLocalBranchVar()
  # called by auto-command

  var key: string
  var j_new: job

  def OnCapture(c: channel, d: string)
    var k = split(string(c), " ")[1]
    local_branch_name[k].text = (typename(d) == "string") ? d : ""
  enddef

  def OnExitBranchVar(j: job, s: number)
    var k = split(string(job_info(j).channel), " ")[1]
    if s == 0
      setbufvar(local_branch_name[k].buf, "vcs_branch_name", "Git:" .. local_branch_name[k].text)
    else
      setbufvar(local_branch_name[k].buf, "vcs_branch_name", "")
    endif
    remove(local_branch_name, k)
  enddef

  if (&buftype != "") || !filereadable(bufname("%"))
    return # when nofile, quickfix, help, terminal, ...
  endif
  j_new = job_start('git branch --show-current', {
    cwd: expand("%:p:h"),
    callback: OnCapture,
    exit_cb: OnExitBranchVar
  })

  key = split(string(job_info(j_new).channel), " ")[1]
  local_branch_name[key] = {
    buf: bufnr('%'),
    text: ""
  }

enddef

def GetBranches(): list<string>
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

export def CompleteGit(arg_lead: string, cmd_line: string, cur_pos: number): list<string>
  var candidates = [
    "restore", "switch", "status", "add", "commit", "diff",
    "branch", "remote", "push", "pull", "fetch"
  ]
  var git_sub_cmd = matchstr(substitute(cmd_line, 'Git\s\+', '', ''), '\w\+')

  if index(candidates, git_sub_cmd) == -1
    filter(candidates, (idx, val) => val =~ '^' .. git_sub_cmd)
  elseif git_sub_cmd == "switch" || git_sub_cmd == "branch"
    candidates  = GetBranches()
    filter(candidates, (idx, val) => val =~ arg_lead)
  else
    candidates = GetChangedFiles()
    filter(candidates, (idx, val) => val =~ arg_lead)
  endif
  return candidates
enddef

def OnExitDirInfo(out_list: list<string>)
    pop.Open(out_list, {
      close_on_key: true,
      hl: 'PopupNotification'})
  # for e in out_list
  #   pop.Open('Git: ' .. e, {
  #     close_on_key: true,
  #     hl: 'PopupNotification'})
  # endfor
enddef

export def DirInfo()
  var output: list<string>

  PresetWorkingDir()
  job_start('git status -s', {
    cwd: working_dir,
    callback: (_, data) => add(output, data),
    exit_cb: (_, data) => OnExitDirInfo(output),
  })
enddef

export def Execute(git_command: string)
  PresetWorkingDir()
  run.RunStart({
    cmd: 'git ' .. git_command,
    cwd: working_dir,
    name: "GIT-Output"
  })
enddef

export def RunGui()
  PresetWorkingDir()
  job_start(
    'git-gui',
    {cwd: working_dir}
  )
enddef

export def ShowDiff(file = "")
  # git show HEAD~2:file/with/forward/slashes
  execute "tabedit" (file == "") ? bufname("%") : file
  inputsave()
  var rev = input("revision (HEAD~[1...]): ", "Head~1")
  inputrestore()
  diffthis
  vert new
  setlocal buftype=nofile nobuflisted
  silent execute $"read ++edit !git show {rev}:{substitute(bufname('#'), '\', '/', 'g')}"
  silent normal gg0d_
  diffthis
  nnoremap <buffer> c :bwipeout<CR>:tabclose<CR>
  nnoremap <buffer> <C-j> ]c
  nnoremap <buffer> <C-k> [c
enddef

augroup GroupVcsGit
  autocmd!
  autocmd BufWinEnter GIT-Output setf vcs_output
  autocmd BufWinEnter GIT-Output nnoremap <buffer> <CR> :Git<Space>
  autocmd BufWinEnter GIT-Output nnoremap <buffer> <LocalLeader>o yiW<C-w>p:edit <C-r>0<CR>
  autocmd BufWinEnter GIT-Output nnoremap <buffer> <LocalLeader>d :GitDiff <C-r><C-f><CR>
  autocmd BufWinEnter GIT-Output nnoremap <buffer> <LocalLeader>a :Git add <C-r><C-f>
  autocmd CmdlineEnter : g:vcs_git_changed_files = []
  autocmd DirChanged global call ChangeDir(".")
augroup END

# Uncomment when testing
defcompile
