vim9script

import autoload 'git.vim' as git

command! -nargs=* -complete=customlist,git.CompleteGit Git git.Execute(<q-args>)
command! -nargs=0 ShowGitBranch call git.BranchInfo(".")

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'

# Uncomment when testing
defcompile
