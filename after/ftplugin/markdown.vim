" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=80
setlocal shiftwidth=4
setlocal nocindent
setlocal nonumber relativenumber

nnoremap <buffer> <F7> :silent !pandoc -f mardown -t html -o <C-r>%<C-w>html <C-r>%<CR>

let b:did_ftplugin_after = 1
