" Vim autoload file

let s:LookCursor = {col -> getline(".")[col - 1]}
let s:LookForward = {col -> getline(".")[col]}
let s:LookBackward = {col -> (col == 1) ? "" : getline(".")[col - 2]}

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
function! s:OneSpace(col)
  let Col = {-> getcurpos()[2]}
  if s:LookCursor(Col()) == " "
    while s:LookBackward(Col()) == " "
      normal h"_x
    endwhile
    while s:LookForward(Col()) == " "
      normal "_x
    endwhile
  endif
endfunction

" Description: Shrink number of blank lines or whitespaces around current
" cursor postion to one empty line or one whitespace.
function! whitespace#WhitespaceMelt()
  let col = getcurpos()[2]
  if col > 1
    call s:OneSpace(col)
  else
    call s:OneBlankLine()
  endif
endfunction

" Description: Remove trailing spaces, replace existing tabs with spaces and
" remove trailing Ctrl-M on each line. The amount of spaces is set by
" 'tabstop'. This is done by :retab and option 'expandtab'.
function! whitespace#WhitespaceCleanup()
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

