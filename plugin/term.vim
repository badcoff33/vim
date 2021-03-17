" Vim plugin file

command! -nargs=* -complete=file_in_path RunAuto :term ++rows=5 ++close ++shell <args>
command! -nargs=* -complete=file_in_path Run     :call term#Start(<q-args>)
command! -nargs=0 CloseTerm                      :call lib#windows#CloseTermWindows()
command! -nargs=0 ShowOutput                     :call term#ToFrontBuffer()
command! -nargs=0 HideOutput                     :call term#HideBuffer()
command! -nargs=0 JobAsQuickfix                  :call term#UseAsQuickfix()

if !hasmapto(mapleader .. 'j')
  nnoremap <Leader>js :ShowOutput<CR>
  nnoremap <Leader>jh :HideOutput<CR>
  nnoremap <Leader>jj :Run<Up>
  nnoremap <Leader>jq :JobAsQuickfix<CR>
endif
