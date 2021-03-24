" Vim plugin file -- make access on async processes or terminal easier

command! -nargs=* -complete=file_in_path Run :call async#StartJob(<q-args>)
command! -nargs=* -complete=file_in_path RunTerm :call async#PopupTerm('new_cmd', <q-args>)

command! -nargs=0 JobOutput :call async#JobBufferToFront()
command! -nargs=0 HideJob :call async#HideJobBuffer()
command! -nargs=0 JobAsQuickfix :call async#JobBufferAsQuickfix()
command! -nargs=0 PopupTerm :call async#PopupTerm()
command! -nargs=0 CloseFinishedTerm :call async#CloseFinishedTerm()

if !hasmapto(mapleader .. 'T')
  nnoremap <Leader>T :call async#PopupTerm()<CR>
endif
if !hasmapto(mapleader .. 't')
  nnoremap <Leader>t :call async#PopupTerm('last_cmd')<CR>
endif

if !hasmapto(mapleader .. 'j')
  nnoremap <Leader>js :JobOutput<CR>
  nnoremap <Leader>jh :HideJob<CR>
  nnoremap <Leader>jj :Run<Up>
  nnoremap <Leader>jq :JobAsQuickfix<CR>
endif

autocmd TerminalOpen * setlocal nonumber norelativenumber


