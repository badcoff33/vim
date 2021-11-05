" Vim autload file - display lists of text as popups

augroup popup
 au!
 autocmd ColorScheme * highlight! link PopupNotification StatusLine
augroup END

doautocmd ColorScheme %

function! s:max_len_in_list(list)
  let max = 1
  for e in a:list
    let max = (max < len(e)) ? len(e) : max
  endfor
  return max
endfunction

" Description: Show a popup with the arguments as a list in the upper right
" corner.
function! lib#popup#Head(list_of_strings)
  let g:winid_head = popup_create(a:list_of_strings, {
        \ 'title': "",
        \ 'padding': [1,0,1,0],
        \ 'line': 2 + ( tabpagenr('$') == 1 ? 0:1 ) ,
        \ 'col': 4,
        \ 'minwidth': &columns-6,
        \ 'time': 3000,
        \ 'tabpage': -1,
        \ 'zindex': 300,
        \ 'drag': 1,
        \ 'close': 'click',
        \ })
  call setwinvar(g:winid_head, '&wincolor', 'PopupNotification')
endfunction

"
" Description: Show a popup with the arguments as a list in the lower right
" corner.
function! lib#popup#Bottom(list_of_strings)
  let g:winid_bot = popup_create(a:list_of_strings, {
        \ 'title': "",
        \ 'padding': [1,0,1,0],
        \ 'line': &lines - len(a:list_of_strings),
        \ 'col': 4,
        \ 'minwidth': &columns-6,
        \ 'time': 3000,
        \ 'tabpage': -1,
        \ 'close': 'click'
        \ })
  call setwinvar(g:winid_bot, '&wincolor', 'PopupNotification')
endfunction

function! lib#popup#OpenFloatingWin(buffer)
    call popup_create(split(buffer, #{ pos: 'topleft',
          \ line: 'cursor+1', col: 'cursor', moved: 'WORD' })
    return
endfunction

