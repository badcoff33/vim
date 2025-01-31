vim9script

import autoload "selector.vim"

nnoremap <Leader>r <Cmd>call selector#RecentBuffers()<CR>
nnoremap <Leader>b <Cmd>call selector#Buffers()<CR>
nnoremap <Leader>f <Cmd>call selector#Files()<CR>
