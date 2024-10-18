vim9script

import autoload 'run.vim' as run
import autoload 'popnews.vim' as pop

var popup_duration = 6000

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

def GetCompleteCandidates(kind: string): list<string>
  var candidates: list<string>
  if kind == 'base'
    candidates = [ "restore", "status", "add", "commit", "diff --no-color", "branch", "remote" ]
  elseif kind == 'branch'
    var sub: string
    for f in systemlist("git branch")
      sub = substitute(f, '[ \*]\+\(\w\+\)', '\1', '')
      candidates = add(candidates, sub)
    endfor
  elseif kind == 'commit'
      || kind == 'diff'
      || kind == 'add'
      || kind == 'restore'
    for f in systemlist("git ls-files --modified")
      candidates = add(candidates, f)
    endfor
  endif
  return candidates
enddef

def CompleteGit(arg_lead: string, cmd_line: string, cur_pos: number): list<string>
  var candidates: list<string>
  var words = split(cmd_line, ' ')
  var num = len(words)
  if num == 1 || len(arg_lead) > 0
    candidates = filter(GetCompleteCandidates('base'), (idx, val) => val =~ arg_lead)
  else
    candidates = filter(GetCompleteCandidates(words[1]), (idx, val) => val =~ arg_lead)
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
    job_start('git status -s', {
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

augroup GroupGit
    autocmd!
    autocmd BufWinEnter GIT-Output setf vcs_output
    autocmd BufWinEnter GIT-Output nnoremap <buffer> <CR> :Git<Space>
    autocmd BufWinEnter GIT-Output nnoremap <buffer> - <Cmd>call search('modified:', 'bWz')<CR>W
    autocmd BufWinEnter GIT-Output nnoremap <buffer> + <Cmd>call search('modified:', 'Wz')<CR>W
    autocmd BufWinEnter GIT-Output nnoremap <buffer> A h"gyE
    autocmd BufWinEnter GIT-Output nnoremap <buffer> a h"GyE
    autocmd BufWinEnter GIT-Output nnoremap <buffer> s <Cmd>call VcsGitDirStatus('.')<CR>
    autocmd DirChanged  *          call VcsGitBranchInfo('.')
augroup END

command! -nargs=* -complete=customlist,CompleteGit Git g:VcsGitRun(<q-args>)
command! -nargs=0 ShowGitBranch pop.Open(GetBranchText())

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'
nnoremap <A-g>s <Cmd>call VcsGitDirStatus('.')<CR>
nnoremap <A-g>b <Cmd>call VcsGitBranchInfo('.')<CR>

# Uncomment when testing
defcompile

