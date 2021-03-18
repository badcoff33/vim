" Vim plugin file

noremap <unique> <script> <Plug>PopupTerminal          <SID>PopupTerminal
noremap <SID>PopupTerminal          :call <SID>PopupTerminal()<CR>

if !hasmapto('<Plug>PopupTerminal')
  nmap <Leader>T <Plug>PopupTerminal
endif

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

autocmd TerminalOpen * setlocal nonumber norelativenumber

" Description: Popup term buffer.
" If no term buffer open, open a new one.
" TODO: handle multiple term buffers.
function! s:PopupTerminal()
  let termBufNr = bufnr("^term:")
  if termBufNr == -1
    let termBufNr = bufnr("^\!")
  endif
  if termBufNr == -1
    terminal
    return
  endif
  let termWinNr = win_findbuf(termBufNr)
  if empty(termWinNr)
    execute termBufNr . "buffer"
  else
    noautocmd call win_gotoid(termWinNr[0])
  endif
endfunction

