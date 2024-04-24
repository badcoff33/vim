vim9script

import autoload 'run.vim' as run

augroup GroupGit
    autocmd!
    autocmd BufWinEnter GIT-Output setf git
augroup END

def g:CompleteGit(arg_lead: string, cmd_line: string, cur_pos: number): string
  var matching_keys: string
  var candidates = [ "status", "commit", "diff", "branch" ]
  var filename: string
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

# Use single-quotes (') instead of double-quotes ("). They are treated as comments in Vim's command line.
# Most common use case is the 'git commit -m ...' command
command! -bar -complete=custom,g:CompleteGit -nargs=* Git run.RunStart({cmd: escape("git <args>", '\'), name: "GIT-Output"})

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'

# Uncomment when testing
defcompile
