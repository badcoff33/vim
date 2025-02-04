vim9script

import autoload 'vcs_git.vim' as git

command! -nargs=* -complete=customlist,hg.CompleteHg Hg hg.Execute(<q-args>)
command! -nargs=* -complete=customlist,git.CompleteGit Git git.Execute(<q-args>)
command! -nargs=0 ShowGitBranch call git.BranchInfo(".")

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'
cnoreabbrev <expr> GG  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? '!start git-gui'  : 'G'

# Uncomment when testing
defcompile
