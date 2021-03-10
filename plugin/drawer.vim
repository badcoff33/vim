" Vim plugin file -- put buffer in the drawer
"
" Description: A simple frontend to add/remove buffers to/from the drawer-list.
" The list of buffers can be used in the terminal as tools parameters.

" Defaults: variables
let g:drawer_buffer_list = get(g:, 'drawer_buffer_list', [])

" Populate Interfaces:
noremap <script> <Plug>DrawerOpenIt <SID>DrawerOpenIt()
noremap <SID>DrawerOpenIt :call <SID>DrawerOpenIt(g:drawer_buffer_list)<CR>

noremap <script> <Plug>DrawerDropBuffer DrawerDropBuffer()
noremap <SID>DrawerDropBuffer :call DrawerDropBuffer(bufnr('%'))<CR>

noremap <script> <Plug>DrawerPullBuffer <SID>DrawerPullBuffer()
noremap <SID>DrawerPullBuffer :call <SID>DrawerPullBuffer(bufnr('%'))<CR>

noremap <script> <Plug>DrawerClear <SID>DrawerClear()
noremap <SID>DrawerClear :let g:drawer_buffer_list= []<CR>

" Defaults: Unique key mappings
if !hasmapto('<Plug>DrawerOpenIt')
  nmap <unique> <Leader>as <Plug>DrawerOpenIt
endif

if !hasmapto('<Plug>DrawerDropBuffer')
  nmap <unique> <Leader>a+ <Plug>DrawerDropBuffer
endif

if !hasmapto('<Plug>DrawerPullBuffer')
  nmap <unique> <Leader>a- <Plug>DrawerPullBuffer
endif

if !hasmapto('<Plug>DrawerClear')
  nmap <unique> <leader>ac <Plug>DrawerClear
endif

augroup drawer
  autocmd!
  autocmd TerminalOpen * :tmap <buffer> <C-a> <C-w>"=DrawerInsertBuffers(g:drawer_buffer_list)<CR>
  autocmd TextChanged  * :call DrawerDropBuffer(bufnr('%'))
  autocmd TextChangedI * :call DrawerDropBuffer(bufnr('%'))
augroup END

cnoremap <A-Space> <C-r>=DrawerInsertBuffers(g:drawer_buffer_list)<CR>

function! DrawerInsertBuffers(bufnrs)
  let bufnames = []
  for e in a:bufnrs
    call add(bufnames, bufname(e))
  endfor
  return join(bufnames)
endfunction

function! DrawerDropBuffer(b)
  let is_in_list = index(g:drawer_buffer_list, a:b) >= 0  ? 1 : 0
  if (is_in_list == 0)
    let g:drawer_buffer_list=uniq(sort((add(g:drawer_buffer_list, a:b)))
    call s:DrawerOpenIt(g:drawer_buffer_list)
  endif
endfunction

function! s:DrawerPullBuffer(b)
  if len(g:drawer_buffer_list) > 1
    call remove(g:drawer_buffer_list, index(g:drawer_buffer_list, a:b)))
  else
    let g:drawer_buffer_list = []
  endif
  call s:DrawerOpenIt(g:drawer_buffer_list)
endfunction

function! s:DrawerOpenIt(blist)
  let d = []
  for e in a:blist
    call add(d, fnamemodify(bufname(e), ':t') .. '  (' .. fnamemodify(bufname(e), ':p:h') .. ')')
  endfor
  call lib#popup#TopRight(d)
endfunction

if 0
  call popup_menu(['Save', 'Cancel', 'Discard'], #{
    \ filter: 'MyMenuFilter',
    \ callback: 'MyMenuHandler',
    \ })

  func MyMenuFilter(id, key)
    " Handle shortcuts
    if a:key == 'S'
      call popup_close(a:id, 1)
      return 1
    elseif a:key == 'C'
      call popup_close(a:id, 2)
      return 1
    elseif a:key == 'D'
      call popup_close(a:id, 3)
      return 1
    endif

    func MyMenuHandler(a1)
    endfunc

    " No shortcut, pass to generic filter
    return popup_filter_menu(a:id, a:key)
  endfunc
endif
