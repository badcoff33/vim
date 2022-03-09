" Vim ftplugin file

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

setlocal nonumber norelativenumber nowrap scrolloff=0

nnoremap <buffer> <Esc> :cclose<CR>

