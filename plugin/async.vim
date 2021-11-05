" Vim plugin file -- make access on async processes or terminal easier

command! -nargs=* -complete=file_in_path Job :call async#StartJob(<q-args>)
command! -nargs=0 ToggleJobOutput :call async#ToggleJobOutput()
command! -nargs=0 PopupTerm :call async#PopupTerm()
command! -nargs=0 CloseFinishedTerm :call async#CloseFinishedTerm()

command! -nargs=* -complete=file_in_path Term :call async#SendTermCmd(<q-args>)

if !hasmapto(mapleader .. 'T')
  nnoremap <Leader>T :call async#OpenTerm()<CR>
endif

if !hasmapto('<F7')
  nnoremap <S-F7> :ToggleJobOutput<CR>
  nnoremap <F7> :<C-u>Job<Up>
endif
