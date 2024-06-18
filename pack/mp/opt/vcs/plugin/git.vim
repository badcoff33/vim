vim9script

import autoload 'run.vim' as run

augroup GroupGit
    autocmd!
    autocmd BufWinEnter GIT-Output setf git
    autocmd BufWinEnter GIT-Output nnoremap <buffer> <CR> :Git<Space>
    autocmd BufWinEnter GIT-Output nnoremap <buffer> d :Git diff<Space>
    autocmd BufWinEnter GIT-Output nnoremap <buffer> a :Git add <C-r><C-a>
    autocmd BufWinEnter GIT-Output nnoremap <buffer> s :Git status<CR>
    autocmd BufWinEnter GIT-Output nnoremap <buffer> b :Git branch<CR>
    autocmd BufWinEnter GIT-Output nnoremap <buffer> L :Git log -n 4 --pretty=short<CR>
    autocmd BufWinEnter GIT-Output nnoremap <buffer> l :Git log -n 9 --pretty=oneline<CR>
augroup END

def GetCompleteCandidates(): list<string>
  var candidates = [ "status", "commit", "diff", "branch", "remote" ]
  var sub: string
  for f in systemlist("git branch")
    sub = substitute(f, '[ \*]\+\(\w\+\)', '\1', '')
    candidates = add(candidates, sub)
  endfor
  for f in systemlist("git ls-files --modified")
    candidates = add(candidates, f)
  endfor
  return candidates
enddef

def CompleteGit(arg_lead: string, cmd_line: string, cur_pos: number): list<string>
  var matching_keys: string
  var candidates: list<string>
  candidates = GetCompleteCandidates()
  return filter(candidates, (idx, val) => val =~? arg_lead)
enddef

def g:VcsGitExecute(git_command: string)
  run.RunStart({
    cmd: 'git ' .. git_command,
    name: "GIT-Output"
  })
enddef

command! -nargs=* -complete=customlist,CompleteGit Git g:VcsGitExecute(<q-args>)

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'

# Uncomment when testing
defcompile
