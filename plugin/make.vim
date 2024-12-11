vim9script

import autoload "make.vim"

command! -nargs=* -complete=file Make make.MakeStart(<q-args>)

nnoremap <Leader>M :<C-u>Make <Up>
nnoremap <Leader>m :<C-u>Make <Up><CR>

defcompile
