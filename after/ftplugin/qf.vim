" Vim ftplugin file

setlocal nonumber norelativenumber nowrap scrolloff=0

"prepare cleanup
setlocal modifiable
let b:save_search = @/

" get rid of Ctrl-M
:silent %s/\r//e

" cleanup
setlocal nomodified nomodifiable
let @/ = b:save_search
unlet b:save_search
call histdel("search", -1)

let b:undo_ftplugin = "setlocal number< relativenumber< wrap< scrolloff<"

nnoremap <buffer> <LocalLeader>w <cmd>setlocal invwrap<CR>
nnoremap <buffer> q <cmd>cclose<CR>
nnoremap <buffer> c <cmd>cclose<CR>
