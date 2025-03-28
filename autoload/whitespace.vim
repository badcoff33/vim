" Vim autoload file

" Configure g:whitespace_trailing_line_blank
" 0  = no trailing empty line
" 1  = one trailing empty line
" -1 = do not touch trailing empty lines
let g:whitespace_trailing_line_blank = get(g:, 'whitespace_trailing_line_blank', -1)

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
function! whitespace#Melt()
  let col = getcurpos()[2]
  if col > 1
    call s:OneSpace(col)
  else
    call s:OneBlankLine()
  endif
endfunction

" Description: Remove trailing spaces, replace existing tabs with spaces and
" remove trailing Ctrl-M on each line. The amount of spaces is set by
" 'tabstop'. This is done by :retab and option 'expandtab'. Remove blank lines
" on head or bottom of file.
function! whitespace#Cleanup()
  if &modifiable == 0
    return
  endif
  let save_formatoptions = &formatoptions
  setlocal formatoptions=

  let cur_pos = getpos(".")
  let save_line = cur_pos[1]
  let save_col = cur_pos[2]
  setlocal expandtab
  retab
  %s/\s\+$//e
  %s/\r//e
  while getline(1) =~ '^\s*$' && line('$') > 1
    normal 1Gdd
    if save_line > 1 | let save_line -= 1 | endif
  endwhile

  if g:whitespace_trailing_line_blank > -1
    normal G

    while (getline('.') =~ '^\s*$') && (line('$') > 1)
      normal Gdd
    endwhile

    if g:whitespace_trailing_line_blank == 1
      normal Go
    endif
  endif

  call histdel("search", -2)
  let &formatoptions=save_formatoptions
  call setpos(".", cur_pos)
endfunction





