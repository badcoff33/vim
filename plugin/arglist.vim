" Vim plugin file
"
" Description: A simple frontend to add/remove buffers to/from the arglist.
" The list of buffers can be used in the terminal as tools parameters (:help
" ##).

" Populate Interfaces:
noremap <unique> <script> <Plug>PopupArgs <SID>PopupArgs
noremap <SID>PopupArgs :call <SID>PopupArgs()<CR>

" Defaults: Unique key mappings
if !hasmapto('<Plug>PopupArgs')
  nmap <leader>? <Plug>PopupArgs
endif

if !hasmapto(mapleader . '+')
  nmap <leader>+ :argadd %<CR>:sil call <SID>PopupArgs()<CR>
endif

if !hasmapto(mapleader . '-')
  nmap <leader>- :argdelete %<CR>:sil call <SID>PopupArgs()<CR>
endif

if !hasmapto(mapleader . '0')
  nmap <leader>0 :%argdelete<CR>
endif

augroup arglist
  autocmd!
  autocmd TerminalOpen * :tmap <buffer> <C-a> <C-w>"=expand('##')<CR>
augroup END

" Description: Show a popup with the arg list in the upper right corner
function! s:PopupArgs()
  let text_list = []
  let best_fit = 20
  for a in range(0, argc()-1)
    call add(text_list, argv(a))
    if len(argv(a)) > best_fit
      let best_fit = len(argv(a))
    endif
  endfor
  let winid = popup_create(text_list, #{
        \ line: 2,
        \ col: &columns - best_fit - 5,
        \ minwidth: 20,
        \ maxheight: 10,
        \ minheight: argc(),
        \ time: 3000,
        \ tabpage: -1,
        \ zindex: 300,
        \ drag: 1,
        \ highlight: 'WarningMsg',
        \ close: 'click',
        \ padding: [0,1,0,1],
        \ title: "Global args:",
        \ })
  call setwinvar(winid, '&wincolor', 'StatusLineNC')
endfunction

