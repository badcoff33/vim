vim9script

import autoload 'vcs_git.vim' as git

command! -nargs=* -complete=customlist,hg.CompleteHg Hg hg.Execute(<q-args>)
command! -nargs=* -complete=customlist,git.CompleteGit Git git.Execute(<q-args>)
command! -nargs=0 GitShowBranch call git.BranchInfo(".")
command! -nargs=1 -complete=dir GitGui job_start("git-gui", {cwd: <q-args>})

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'

# Uncomment when testing
defcompile
