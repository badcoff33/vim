vim9script

import autoload 'vcs_git.vim' as git

g:git_working_dir = get(g:, "git_working_dir", ".")

command! -nargs=* -complete=customlist,hg.CompleteHg Hg hg.Execute(<q-args>)
command! -nargs=* -complete=customlist,git.CompleteGit Git git.Execute(<q-args>)
command! -nargs=0 GitShowBranch git.BranchInfo()
command! -nargs=0 GitShowStatus git.DirInfo()
command! -nargs=0 GitCd git.ChangeDir()
command! -nargs=0 GitGui git.RunGui()

cnoreabbrev <expr> G  (getcmdtype() ==# ':' && getcmdline() =~# '^G')  ? 'Git'  : 'G'

# Uncomment when testing
defcompile
