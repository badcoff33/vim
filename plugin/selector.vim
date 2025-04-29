vim9script

import autoload "selector.vim"

nnoremap <Leader>b <Cmd>call selector#Buffers()<CR>
nnoremap <Leader>f <Cmd>call selector#Files()<CR>
