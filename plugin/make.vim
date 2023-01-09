vim9script
# Vim plugin interface

import autoload "run.vim"

command! -complete=file -nargs=* Make run.Run({ cmd: &makeprg .. ' <args>'})

nnoremap <leader>M :<C-u>Make<Space><Up>
nnoremap <leader>m :<C-u>Make<Up><cr>


