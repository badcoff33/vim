" Vim autoload file
" Description: Open welcome page

if !exists("g:welcome_text_file")
  for wfile in ['~/Documents/welcome.txt', 
        \ '~/../../Documents/welcome.txt',
        \ '~/vimfiles/welcome.txt']
    if filereadable(wfile)
      let g:welcome_text_file = wfile
      break
    endif
  endfor
  if !exists("g:welcome_text_file")
    let g:welcome_text_file = '~/vimfiles/welcome.txt'
  endif
endif

autocmd BufRead welcome.txt nmap <buffer> <CR> 0y$:<C-r>"<CR>

" Description: My splash screen (with one-liner Vim script in it)
function! welcome#open()
  execute 'edit ' . g:welcome_text_file
endfunction

" vim:sw=2:tw=0:nocindent