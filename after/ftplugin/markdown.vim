" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=80
setlocal shiftwidth=4
setlocal nocindent
setlocal nonumber relativenumber

function! EvalStringPandocExportMarkdown(format)
  if a:format == 1
    let l:pandoc_call = 'pandoc -f markdown -t docx -o ' . expand ('%:r') . '.docx ' . expand('%')
  elseif a:format == 2
    let l:pandoc_call = 'pandoc -f markdown -t html -o ' . expand ('%:r') . '.html ' . expand('%')
  endif
  return l:pandoc_call
endfunction
nnoremap <buffer> <F7> :make<CR>

execute 'setlocal makeprg=' . escape(EvalStringPandocExportMarkdown(1), ' ')

let b:did_ftplugin_after = 1
