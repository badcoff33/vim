" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=80
setlocal shiftwidth=4
setlocal nocindent
setlocal nonumber relativenumber

command! -buffer PandocHtml :execute 'sil !pandoc -f markdown -t html -o ' . expand('%:r') . '.html ' . expand('%')
command! -buffer PandocDocx :execute 'sil !pandoc -f markdown -t docx -o ' . expand('%:r') . '.docx ' . expand('%')

nnoremap <buffer> <C-F7> :silent !start <C-r>%<C-w>html<CR>

let b:did_ftplugin_after = 1
