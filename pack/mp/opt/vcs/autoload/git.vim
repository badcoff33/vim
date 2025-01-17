vim9script

import 'run.vim' as run
import 'popnews.vim' as pop

var popup_duration = 6000

g:vcs_git_changed_files = []

def CbPopupBranchInfo(raw_list: list<string>)
  var branch_name: string
  if raw_list[0] =~? 'On branch '
    branch_name = "--> On branch " .. substitute(raw_list[0], 'On branch ', '', '')
  else
    branch_name = '--> No Git branch'
  endif
  pop.Open(branch_name, {t: popup_duration, hl: 'PopupNotification'})
enddef

export def BranchInfo(directory: string)
  var output: list<string>
  if isdirectory(directory)
  pop.Open('In ' .. getcwd(), {t: popup_duration, hl: 'PopupNotification'})
  job_start('git status -b', {
      callback: (_, data) => add(output, data),
      exit_cb: (_, data) => CbPopupBranchInfo(output),
    })
  endif
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
  var candidates = [ "restore", "switch", "status", "add", "commit", "diff --no-color", "branch", "remote", "push", "pull", "fetch" ]
  var git_sub_cmd = matchstr(substitute(cmd_line, 'Git\s\+', '', ''), '\w\+')
  if index(candidates, git_sub_cmd) == -1
    filter(candidates, (idx, val) => val =~ git_sub_cmd)
  elseif git_sub_cmd == "switch" || git_sub_cmd == "branch"
    candidates  = GetBranches()
    filter(candidates, (idx, val) => val =~ arg_lead)
  else
    candidates = GetChangedFiles()
    filter(candidates, (idx, val) => val =~ arg_lead)
  endif
  return candidates
enddef

def CbPopList(out_list: list<string>)
  for e in out_list
    pop.Open('--> ' .. e, {t: popup_duration, hl: 'PopupNotification'})
  endfor
enddef

export def DirStatus(directory: string)
  var output: list<string>
  if isdirectory(directory)
    job_start('git status -s -b', {
      callback: (_, data) => add(output, data),
      exit_cb: (_, data) => CbPopList(output),
    })
  endif
enddef

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
  autocmd BufWinEnter GIT-Output nnoremap <buffer> s <Cmd>call git.DirStatus('.')<CR>
  autocmd CmdlineEnter : g:vcs_git_changed_files = []
  # autocmd DirChanged * call VcsGitBranchInfo('.')
augroup END

# Uncomment when testing
defcompile
