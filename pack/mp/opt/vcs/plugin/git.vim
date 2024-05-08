vim9script

import autoload 'run.vim' as run

augroup GroupGit
    autocmd!
    autocmd BufWinEnter GIT-Output setf git
augroup END

def g:CompleteGit(arg_lead: string, cmd_line: string, cur_pos: number): string
  var matching_keys: string
  var candidates = [ "status", "commit", "diff", "branch", "remote" ]
  var filename: string
  for f in systemlist("git ls-files")
    candidates = add(candidates, f)
  endfor
  for f in systemlist("git ls-files")
    candidates = add(candidates, f)
  endfor
  for k in candidates
    if match(k, arg_lead) >= 0
      matching_keys = matching_keys .. k .. "\n"
    endif
  endfor
  return matching_keys
enddef

def g:VcsGitExecute(git_command: string)
  run.RunStart({
    cmd: 'git ' .. git_command,
    name: "GIT-Output"
  })
enddef

command! -nargs=* -complete=custom,g:CompleteGit Git g:VcsGitExecute(<q-args>)

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'

# Uncomment when testing
defcompile
