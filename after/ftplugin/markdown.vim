" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=80
setlocal shiftwidth=4
setlocal nocindent
setlocal nonumber relativenumber

<<<<<<< working copy
command! -buffer PandocHtml :execute 'sil !pandoc -f markdown -t html -o ' . expand('%:r') . '.html ' . expand('%')
command! -buffer PandocDocx :execute 'sil !pandoc -f markdown -t docx -o ' . expand('%:r') . '.docx ' . expand('%')

nnoremap <buffer> <C-F7> :silent !start <C-r>%<C-w>html<CR>
=======
function! PandocExportMarkdown()
  let l:format = inputlist(['1 -- Docx', '2 -- Html'])
  if l:format == 1
    execute '!pandoc -f markdown -t docx -o ' . expand ('%:r') . '.docx ' . expand('%')
  elseif l:format == 2
    execute '!pandoc -f markdown -t html -o ' . expand ('%:r') . '.html ' . expand('%')
  endif
endfunction
nnoremap <buffer> <F7> :call PandocExportMarkdown()<CR>
nnoremap <buffer> <localleader>s :silent !start <C-r>%<C-w>html<CR>
>>>>>>> merge rev

let b:did_ftplugin_after = 1
