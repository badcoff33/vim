vim9script

import autoload 'run.vim' as run
import autoload 'popnews.vim' as pop

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

def g:VcsGitBranchInfo(directory: string)
  var output: list<string>
  if isdirectory(directory)
  pop.Open('In ' .. getcwd(), {t: popup_duration, hl: 'PopupNotification'})
  job_start('git status -b', {
      callback: (_, data) => add(output, data),
      exit_cb: (_, data) => CbPopupBranchInfo(output),
    })
  endif
enddef

def GetChangedFiles(): list<string>
  if g:vcs_git_changed_files == []
      g:vcs_git_changed_files = systemlist("git ls-files --modified")
  endif
  return g:vcs_git_changed_files
enddef

def CompleteGit(arg_lead: string, cmd_line: string, cur_pos: number): list<string>
  var candidates = [ "restore", "status", "add", "commit", "diff --no-color", "branch", "remote", "push", "pull", "fetch" ]
  var git_sub_cmd = matchstr(substitute(cmd_line, 'Git\s\+', '', ''), '\w\+')
  if index(candidates, git_sub_cmd) == -1
    filter(candidates, (idx, val) => val =~ git_sub_cmd)
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

def g:VcsGitDirStatus(directory: string)
  var output: list<string>
  if isdirectory(directory)
    job_start('git status -s -b', {
      callback: (_, data) => add(output, data),
      exit_cb: (_, data) => CbPopList(output),
    })
  endif
enddef

def g:VcsGitRun(git_command: string)
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
  autocmd BufWinEnter GIT-Output nnoremap <buffer> s <Cmd>call VcsGitDirStatus('.')<CR>
  autocmd CmdlineEnter : g:vcs_git_changed_files = []
  # autocmd DirChanged * call VcsGitBranchInfo('.')
augroup END

command! -nargs=* -complete=customlist,CompleteGit Git g:VcsGitRun(<q-args>)
command! -nargs=0 ShowGitBranch call g:VcsGitBranchInfo(".")

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'

# Uncomment when testing
defcompile

