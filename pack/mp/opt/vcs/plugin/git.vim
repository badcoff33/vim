vim9script

import autoload 'run.vim' as run

augroup GroupGit
    autocmd!
    autocmd BufWinEnter GIT-Output setf git
augroup END

command! -bar -complete=file_in_path -nargs=+ Git run.RunStart({cmd: "git <args>", name: "GIT-Output"})

# Uncomment when testing
defcompile
