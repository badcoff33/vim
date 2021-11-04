
autocmd ColorSchemePre * hilghlight clear PopupNotification
autocmd ColorScheme * call lib#popup#PickColor()

function! lib#popup#PickColor(winid)
  if !hlID("PopupNotification")
    if &background == 'light'
      highlight PopupNotifcation guibg=forestgreen guifg=white
    else
      highlight PopupNotifcation guibg=green guifg=black
    endif
  endif
endfunction

function! s:max_len_in_list(list)
  let max = 1
  for e in a:list
    let max = (max < len(e)) ? len(e) : max
  endfor
  return max
endfunction

function! lib#popup#TopLeft(list_of_strings)
  if exists('g:winid_tiny') && match(popup_list(), g:winid_tiny) != -1
    call popup_settext(g:winid_tiny, a:list_of_strings)
  else
    let width = s:max_len_in_list(a:list_of_strings)
    let g:winid_tiny = popup_create(a:list_of_strings, {
          \ 'line': len(gettabinfo()) > 1 ? 2 : 1,
          \ 'col': 1,
          \ 'maxwidth': &columns,
          \ 'minwidth': width,
          \ 'maxheight': 10,
          \ 'minheight': 2,
          \ 'time': 2000,
          \ 'tabpage': -1,
          \ 'zindex': 300,
          \ 'drag': 1,
          \ 'close': 'click',
          \ 'padding': [0,1,0,1],
          \ 'title': "",
          \ })
    call setwinvar(g:winid_tiny, '&wincolor', 'PopupNotification')
  endif
endfunction

function! lib#popup#TopRight(list_of_strings)
  if exists('g:winid_tiny') && match(popup_list(), g:winid_tiny) != -1
    call popup_settext(g:winid_tiny, a:list_of_strings)
  else
    let width = s:max_len_in_list(a:list_of_strings)
    let g:winid_tiny = popup_create(a:list_of_strings, {
          \ 'title': "",
          \ 'padding': [0,1,0,1],
          \ 'line': len(gettabinfo()) > 1 ? 2 : 1,
          \ 'col': &columns - width,
          \ 'maxwidth': &columns,
          \ 'minwidth': width,
          \ 'maxheight': 10,
          \ 'minheight': 2,
          \ 'time': 2000,
          \ 'tabpage': -1,
          \ 'zindex': 300,
          \ 'drag': 1,
          \ 'close': 'click'
          \ })
    call setwinvar(g:winid_tiny, '&wincolor', 'PopupNotification')
  endif
endfunction

" Description: Show a popup with the arguments as a list in the upper right
" corner.
function! lib#popup#Head(list_of_strings)
  if exists('g:winid_head') && match(popup_list(), g:winid_head) != -1
    call popup_settext(g:winid_head,a:list_of_strings)
  else
    let g:winid_head = popup_create(a:list_of_strings, {
          \ 'title': "",
          \ 'line': 1,
          \ 'col': 1,
          \ 'maxwidth': &columns,
          \ 'minwidth': &columns,
          \ 'maxheight': 10,
          \ 'minheight': argc() + 2,
          \ 'time': 3000,
          \ 'tabpage': -1,
          \ 'zindex': 300,
          \ 'drag': 1,
          \ 'close': 'click',
          \ 'padding': [0,1,0,1]
          \ })
    call setwinvar(g:winid_head, '&wincolor', 'PopupNotification')
  endif
endfunction

"
" Description: Show a popup with the arguments as a list in the lower right
" corner.
function! lib#popup#Bottom(list_of_strings)
  if exists('g:winid_bot') && match(popup_list(), g:winid_bot) != -1
    call popup_settext(g:winid_bot, a:list_of_strings)
  else
    let g:winid_bot = popup_create(a:list_of_strings, {
          \ 'line': &lines - len(a:list_of_strings) - 1,
          \ 'col': 1,
          \ 'maxwidth': &columns-10,
          \ 'minwidth': 40,
          \ 'maxheight': 10,
          \ 'minheight': 2,
          \ 'time': 3000,
          \ 'padding': [0,1,0,1],
          \ 'tabpage': -1,
          \ 'drag': 1,
          \ 'close': 'click',
          \ 'title': ""
          \ })
    call setwinvar(g:winid_bot, '&wincolor', 'PopupNotification')
  endif
endfunction

function! lib#popup#OpenFloatingWin(buffer)
    call popup_create(split(buffer, #{ pos: 'topleft',
          \ line: 'cursor+1', col: 'cursor', moved: 'WORD' })
    return
endfunction

