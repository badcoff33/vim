
function! s:PickColor(winid)
  if hlID("PopupNotification")
    call setwinvar(a:winid, '&wincolor', 'PopupNotification')
  else
    call setwinvar(a:winid, '&wincolor', 'Pmenu')
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
          \ 'minheight': argc(),
          \ 'time': 2000,
          \ 'tabpage': -1,
          \ 'zindex': 300,
          \ 'drag': 1,
          \ 'close': 'click',
          \ 'padding': [0,1,0,1],
          \ 'title': "",
          \ })
    call s:PickColor(g:winid_tiny)
  endif
endfunction

function! lib#popup#TopRight(list_of_strings)
  if exists('g:winid_tiny') && match(popup_list(), g:winid_tiny) != -1
    call popup_settext(g:winid_tiny, a:list_of_strings)
  else
    let width = s:max_len_in_list(a:list_of_strings)
    let g:winid_tiny = popup_create(a:list_of_strings, {
          \ 'line': len(gettabinfo()) > 1 ? 2 : 1,
          \ 'col': &columns - width,
          \ 'maxwidth': &columns,
          \ 'minwidth': width,
          \ 'maxheight': 10,
          \ 'minheight': argc(),
          \ 'time': 2000,
          \ 'tabpage': -1,
          \ 'zindex': 300,
          \ 'drag': 1,
          \ 'close': 'click',
          \ 'padding': [0,1,0,1],
          \ 'title': "",
          \ })
    call s:PickColor(g:winid_tiny)
  endif
endfunction

" Description: Show a popup with the arguments as a list in the upper right
" corner.
function! lib#popup#Head(list_of_strings)
  if exists('g:winid_head') && match(popup_list(), g:winid_head) != -1
    call popup_settext(g:winid_head,a:list_of_strings)
  else
    let g:winid_head = popup_create(a:list_of_strings, {
          \ 'line': 1,
          \ 'col': 1,
          \ 'maxwidth': &columns,
          \ 'minwidth': 10
          \ 'maxheight': 10,
          \ 'minheight': argc() + 2,
          \ 'time': 3000,
          \ 'tabpage': -1,
          \ 'zindex': 300,
          \ 'drag': 1,
          \ 'close': 'click',
          \ 'padding': [0,1,0,1],
          \ 'title': "",
          \ })
    call s:PickColor(g:winid_head)
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
          \ 'line': &lines - len(a:list_of_strings) - 5,
          \ 'col': 3,
          \ 'maxwidth': &columns-10,
          \ 'minwidth': 40,
          \ 'maxheight': 10,
          \ 'minheight': len(a:list_of_strings),
          \ 'time': 3000,
          \ 'padding': [1, 2, 1, 2],
          \ 'tabpage': -1,
          \ 'drag': 1,
          \ 'close': 'click',
          \ 'title': ""
          \ })
    call s:PickColor(g:winid_bot)
  endif
endfunction

function! lib#popup#OpenFloatingWin(buffer)
    call popup_create(split(buffer, #{ pos: 'topleft',
          \ line: 'cursor+1', col: 'cursor', moved: 'WORD' })
    return
endfunction

