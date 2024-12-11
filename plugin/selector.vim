vim9script

import autoload "selector.vim"

nnoremap <Leader>r <Cmd>call selector#function#RecentBuffers()<CR>
nnoremap <Leader>b <Cmd>call selector#function#Buffers()<CR>
nnoremap <Leader>f <Cmd>call selector#function#Files()<CR>
nnoremap <Leader>t <Cmd>call selector#function#Tags()<CR>
