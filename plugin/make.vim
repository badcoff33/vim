vim9script

import autoload "make.vim"

command! -nargs=* -complete=file Make make.MakeStart(<q-args>)

nnoremap <Leader>m :<C-u>Make <Up>

defcompile
