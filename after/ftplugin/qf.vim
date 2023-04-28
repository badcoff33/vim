" Vim ftplugin file

setlocal nowrap
setlocal nonumber
setlocal norelativenumber
setlocal scrolloff=0

"prepare cleanup
setlocal modifiable
let b:save_search = @/

" get rid of Ctrl-M
:silent %s/\r//e

" cleanup
setlocal nomodified nomodifiable
let @/ =b:save_search
unlet b:save_search
call histdel("search", -1)

let b:undo_ftplugin = "setlocal number< relativenumber< wrap< scrolloff<"

nnoremap <buffer> <Esc> :cclose<CR>
nnoremap <buffer> . <cmd>cnext<CR><C-w>p
nnoremap <buffer> , <cmd>cprev<CR><C-w>p
nnoremap <buffer> <CR> <CR><C-w>p
