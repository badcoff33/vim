" Vim autoload file
"
" Description: Plugin provides functions to delete unwanted whitespaces.


" Interface: command, plugin mapping, auto command

command! -nargs=0 WhitespaceCleanup :sil call <SID>WhitespaceCleanup()

noremap <unique> <script> <Plug>WhitespaceMelt <SID>WhitespaceMelt
noremap <SID>WhitespaceMelt :call <SID>WhitespaceMelt()<CR>

if !hasmapto('<Plug>WhitespaceMelt')
  nmap <Leader>w <Plug>WhitespaceMelt
endif

augroup whitespace
  autocmd!
  autocmd BufWritePre *.cc,*.hh :WhitespaceCleanup
  autocmd BufWritePre *.c,*.h   :WhitespaceCleanup
  autocmd BufWritePre *.py      :WhitespaceCleanup
  autocmd BufWritePre *.vim     :WhitespaceCleanup
  autocmd BufWritePre vimrc     :WhitespaceCleanup
  autocmd BufWritePre gvimrc     :WhitespaceCleanup
augroup END

" Description: Support function. It returns previous character with parameter
" "prev" or the next one with parameter "next". Any other string given as
" parameter, returns the character under cursor. If the cursor is at the very
" beginning/end of the line "prev" and "next" can not find a character. A empty
" string is returned.
function! s:CharUnderCursor(which)
  if a:which == "next"
    return getline(".")[getcurpos()[2]]
  elseif a:which == "prev"
    if getcurpos()[2] >= 2
      return getline(".")[getcurpos()[2] - 2]
    endif
  else
    return getline(".")[getcurpos()[2] - 1]
  endif
  return ""
endfunction

" Description: Delete empty lines around cursor.
function! s:OneBlankLine()
  while line('.') > 1 && empty(getline(line('.') - 1))
    normal k"_dd
  endwhile
  while line('.') < line('$') && empty(getline(line('.'))) && empty(getline(line('.') + 1))
    normal "_dd
  endwhile
  " Top and last lines needs special treatment.
  if line('.') == 1 || line('.') == line('$')
    if empty(getline('.'))
      normal "_dd
    endif
  endif
endfunction

" Description: Delete spaces at cursor positon.
function! s:OneSpace()
  if s:CharUnderCursor("curr") == " "
    while s:CharUnderCursor("prev") == " " && getcurpos()[2] > 1
      normal h"_x
    endwhile
    while s:CharUnderCursor("next") == " "
      normal "_x
    endwhile
  endif
endfunction

" Description: Autoloaded wrapper function.
function! s:WhitespaceMelt()
  if getcurpos()[2] > 1
    call s:OneSpace()
  else
    call s:OneBlankLine()
  endif
endfunction

" Description: Autoloaded wrapper function.
" Remove trailing spaces, replace existing tabs with spaces and
" remove trailing Ctrl-M on each line. The amount of spaces is set by
" 'tabstop'. This is done by :retab and option 'expandtab'.
function! s:WhitespaceCleanup()
  if &modifiable
    let l:savedView = winsaveview()
    setlocal expandtab
    retab
    %s/\s\+$//e
    %s/\r//e
    call histdel("search", -2)
    call winrestview(l:savedView)
  endif
endfunction

