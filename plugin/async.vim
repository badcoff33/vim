" Vim plugin file --

command! -nargs=* -complete=file_in_path RunAuto :term ++rows=5 ++close ++shell <args>
command! -nargs=* -complete=file_in_path Run     :call async#StartJob(<q-args>)

command! -nargs=0 JobOutput :call async#JobBufferToFront()
command! -nargs=0 HideJob :call async#HideJobBuffer()
command! -nargs=0 JobAsQuickfix :call async#JobBufferAsQuickfix()
command! -nargs=0 PopupTerm :call async#PopupTerm()
command! -nargs=0 CloseFinishedTerm :call async#CloseFinishedTerm()

if !hasmapto(mapleader .. 'T')
  nnoremap <Leader>T :PopupTerm<CR>
endif

if !hasmapto(mapleader .. 'j')
  nnoremap <Leader>js :JobOutput<CR>
  nnoremap <Leader>jh :HideJob<CR>
  nnoremap <Leader>jj :Run<Up>
  nnoremap <Leader>jq :JobAsQuickfix<CR>
endif

autocmd TerminalOpen * setlocal nonumber norelativenumber

