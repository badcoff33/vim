" Vim plugin file -- put buffer in the drawer and pull it out
"
" Description: A simple frontend to add/remove buffers to/from the drawer-list.
" The list of buffers can be used in the terminal as cmd line parameters.

" Defaults: variables
let g:drawer_buffer_list = get(g:, 'drawer_buffer_list', [])

" Populate Interfaces:
noremap <script> <Plug>DrawerShowIt <SID>DrawerShowIt()
noremap <SID>DrawerShowIt :call <SID>DrawerShowIt(g:drawer_buffer_list)<CR>

noremap <script> <Plug>DrawerDropBuffer DrawerDropBuffer()
noremap <SID>DrawerDropBuffer :call DrawerDropBuffer(bufnr('%'))<CR>

noremap <script> <Plug>DrawerRemoveBuffer <SID>DrawerRemoveBuffer()
noremap <SID>DrawerRemoveBuffer :call <SID>DrawerRemoveBuffer(bufnr('%'))<CR>

noremap <script> <Plug>DrawerClear <SID>DrawerClear()
noremap <SID>DrawerClear :let g:drawer_buffer_list= []<CR>

" Defaults: Unique key mappings
if !hasmapto('<Plug>DrawerShowIt')
  nmap <unique> <Leader>as <Plug>DrawerShowIt
endif

if !hasmapto('<Plug>DrawerDropBuffer')
  nmap <unique> <Leader>aa <Plug>DrawerDropBuffer
endif

if !hasmapto('<Plug>DrawerRemoveBuffer')
  nmap <unique> <Leader>ar <Plug>DrawerRemoveBuffer
endif

if !hasmapto('<Plug>DrawerClear')
  nmap <unique> <leader>ac <Plug>DrawerClear
endif

augroup drawer
  autocmd!
  autocmd TextChanged  * :call DrawerDropBuffer(bufnr('%'))
  autocmd TextChangedI * :call DrawerDropBuffer(bufnr('%'))
augroup END

nnoremap <C-CR> :call DrawerSelectBuffer()<CR>
inoremap <C-CR> <C-r>=g:drawer_selected_buffername<CR>
cnoremap <C-CR> <C-r>=g:drawer_selected_buffername<CR>
tnoremap <C-CR> <C-w>"=g:drawer_selected_buffername<CR>

function! DrawerDropBuffer(b)
  let is_in_list = index(g:drawer_buffer_list, a:b) >= 0  ? 1 : 0
  if (is_in_list == 0) && getbufvar(a:b, '&buftype') == ''
    let g:drawer_buffer_list=uniq(sort(add(g:drawer_buffer_list, a:b)))
    call s:DrawerShowIt(g:drawer_buffer_list)
  endif
endfunction

function! s:DrawerRemoveBuffer(b)
  if len(g:drawer_buffer_list) > 1
    call remove(g:drawer_buffer_list, index(g:drawer_buffer_list, a:b)))
  else
    let g:drawer_buffer_list = []
  endif
  call s:DrawerShowIt(g:drawer_buffer_list)
endfunction

function! s:DrawerGetReadableList(blist)
  let d = []
  for e in a:blist
    call add(d, fnamemodify(bufname(e), ':t') .. '  (' .. fnamemodify(bufname(e), ':p:h') .. ')')
  endfor
  return d
endfunction

function! s:DrawerShowIt(blist)
  call lib#popup#TopRight(s:DrawerGetReadableList(a:blist))
endfunction

function! DrawerSelectBuffer()
  let bufnames = s:DrawerGetReadableList(g:drawer_buffer_list)
  call popup_menu(bufnames, #{
        \ filter: 'MyMenuFilter',
        \ callback: 'MyMenuHandler',
        \ padding: [0,2,0,2],
        \ border: [],
        \ })
endfunction

func! MyMenuHandler(id, index)
  if a:index > 0
    let g:drawer_selected_buffername = bufname(g:drawer_buffer_list[a:index - 1])
  else
    let g:drawer_selected_buffername = ''
  endif
endfunc

func! MyMenuFilter(id, key)
  call popup_list()
  " Handle shortcuts
  if a:key == 'S'
    call popup_close(a:id)
    return 1
  elseif a:key == 'C'
    call popup_close(a:id)
    return 1
  elseif a:key == 'D'
    call popup_close(a:id)
    return 1
  endif

  " No shortcut, pass to generic filter
  return popup_filter_menu(a:id, a:key)
endfunc
