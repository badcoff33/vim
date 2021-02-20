
function! s:PickColor(winid)
  if hlID("PopupNotification")
    call setwinvar(a:winid, '&wincolor', 'PopupNotification')
  else
    call setwinvar(a:winid, '&wincolor', 'PmenuSel')
  endif
endfunction

function! lib#popup#TopLeft(list_of_strings)
  if exists('g:winid_tiny') && match(popup_list(), g:winid_tiny) != -1
    call popup_settext(a:list_of_strings)
  else
    let g:winid_tiny = popup_create(a:list_of_strings, {
          \ 'line': len(gettabinfo()) > 1 ? 2 : 1,
          \ 'col': 1,
          \ 'minwidth': &columns/3,
          \ 'maxheight': 10,
          \ 'minheight': argc() + 2,
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
    call popup_settext(a:list_of_strings)
  else
    let g:winid_tiny = popup_create(a:list_of_strings, {
          \ 'line': len(gettabinfo()) > 1 ? 2 : 1,
          \ 'col': (2 * &columns)/3 - 1,
          \ 'minwidth': &columns/3,
          \ 'maxheight': 10,
          \ 'minheight': argc() + 2,
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
    call popup_settext(a:list_of_strings)
  else
    let g:winid_head = popup_create(a:list_of_strings, {
          \ 'line': 1,
          \ 'col': 1,
          \ 'minwidth': &columns,
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
    call popup_settext(a:list_of_strings)
  else
    let g:winid_bot = popup_create(a:list_of_strings, {
          \ 'line': &lines - 2 - argc(),
          \ 'col': 1,
          \ 'minwidth': &columns,
          \ 'maxheight': 10,
          \ 'minheight': argc() + 1,
          \ 'time': 3000,
          \ 'tabpage': -1,
          \ 'zindex': 300,
          \ 'drag': 1,
          \ 'close': 'click',
          \ 'padding': [0,1,0,1],
          \ 'title': "",
          \ })
    call s:PickColor(g:winid_bot)
  endif
endfunction

function! lib#popup#OpenFloatingWin(text_list)
  if !has('nvim')
    call popup_create(split(a:text, '\n'), #{ pos: 'topleft',
          \ line: 'cursor+1', col: 'cursor', moved: 'WORD' })
    return
  endif
  let l:opts = {
        \ 'relative': 'editor',
        \ 'row': 0,
        \ 'col': 0,
        \ 'anchor': 'NW',
        \ 'height': 10,
        \ 'width': &columns,
        \ 'style': 'minimal'
        \ }
  if !exists('w:popup_win')
    let buf = nvim_create_buf(v:false, v:true)
    let w:popup_win = nvim_open_win(buf, v:true, l:opts)
    call nvim_win_set_option(w:popup_win, 'winhl', 'Normal:NormalFloat')
    call nvim_win_set_option(w:popup_win, 'winblend', 10)
    call nvim_win_set_option(w:popup_win, 'signcolumn', 'no')
    call nvim_buf_set_option(buf, 'buftype', 'nofile')
    call nvim_buf_set_option(buf, 'buflisted', v:true)
    call nvim_buf_set_option(buf, 'bufhidden', 'hide')
    autocmd BufLeave <buffer> bwipeout!
    nmap <silent> <buffer> <Esc> :bwipeout!<CR>
    nmap <silent> <buffer> <CR>  :bwipeout!<CR>
  endif
  call append(0, a:text_list)
  normal gg
endfunction

function! lib#popup#OpenFloatingHelp(help_arg)
  if !has('nvim')
    echo "sorry, nvim only."
  endif
  let width = min([&columns - 4, max([80, &columns - 20])])
  let height = min([&lines - 4, max([20, &lines - 10])])
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor',
        \'row': top,
        \'col': left,
        \'width': width,
        \'height': height,
        \'style': 'minimal'}
  let s:buf = nvim_create_buf(v:false, v:true)
  let l:win = nvim_open_win(s:buf, v:true, opts)
  call nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
  setlocal nonumber norelativenumber buftype=help
  exe "help " . a:help_arg
endfunction

