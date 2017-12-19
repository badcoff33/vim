" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=80
setlocal shiftwidth=4
setlocal nocindent
setlocal nonumber relativenumber

nnoremap <buffer> <F7>   :silent !pandoc -f markdown -t html -o <C-r>%<C-w>html <C-r>%<CR>
nnoremap <buffer> <C-F7> :silent !start <C-r>%<C-w>html<CR>

let b:did_ftplugin_after = 1
