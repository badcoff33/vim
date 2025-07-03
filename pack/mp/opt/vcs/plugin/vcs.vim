vim9script

import autoload 'vcs/git.vim' as git
import autoload 'vcs/hg.vim' as hg

g:vcs_type = ""

command! -nargs=* -complete=customlist,hg.CompleteHg Hg {
  hg.Execute(<q-args>)
}

command! -nargs=? -complete=file HgDiff {
  hg.ShowDiff(<q-args>)
}

command! -nargs=* -complete=customlist,git.CompleteGit Git {
  git.Execute(<q-args>)
}

command! -nargs=? -complete=file VcsFileInfo {
  if g:vcs_type == "git"
    git.FileInfo(<q-args>)
  else
    echo "-- cd into a Git controlled diretory --"
  endif
}

command! -nargs=? -complete=file VcsVimdiff {
  if g:vcs_type == "git"
    git.Vimdiff('<args>')
  elseif g:vcs_type == "hg"
    hg.Vimdiff('<args>')
  else
    echo "-- cd into a VCS controlled diretory --"
  endif
}

def DetectVcsType()
  if git.GetRootDir(getcwd()) != ""
    g:vcs_type = "git"
  elseif hg.GetRootDir(getcwd()) != ""
    g:vcs_type = "hg"
  else
    g:vcs_type = ""
  endif
enddef

augroup GroupVcsGitP
  autocmd!
  autocmd BufEnter,BufWinEnter *.asm,*.bat,*.c,*.h,CMakeLists.txt,*.cmake git.SetLocalVar()
  autocmd WinEnter *.asm,*.bat,*.c,*.h,CMakeLists.txt,*.cmake git.SetLocalVar()
  autocmd BufReadPost,BufWritePost *.asm,*.bat,*.c,*.h,CMakeLists.txt,*.cmake git.SetLocalVar()
  autocmd FocusGained * git.SetLocalVar()
  autocmd DirChanged * vim9 DetectVcsType()
augroup END

cabbrev <expr> G (getcmdline() =~# "^G$") ? "Git" : "G"
cabbrev <expr> H (getcmdline() =~# "^H$") ? "Hg" : "H"

# Uncomment when testing
defcompile
