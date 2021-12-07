
command! -nargs=0 CloseFinishedTerm :call term#CloseFinishedTerm()

if !hasmapto(mapleader .. 'T')
  nnoremap <Leader>T :call term#OpenTerm()<CR>
endif

if !hasmapto('<F7>')
  nnoremap <S-F7> :ToggleJobOutput<CR>
  nnoremap <F7> :<C-u>Job<Up>
endif
