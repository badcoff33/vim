" reStructuredText filetype plugin file
" A nice one: Learn RST her http://rst.ninjs.org/

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=78
setlocal shiftwidth=4
setlocal nocindent

" Make heading underlined
nnoremap <buffer> <LocalLeader>h1 yyppkkVr=jjVr=}
nnoremap <buffer> <LocalLeader>h2 yyppkkVr-jjVr-}
nnoremap <buffer> <LocalLeader>h3 0v$beyo<Esc>PVr~}
nnoremap <buffer> <LocalLeader>h4 0v$beyo<Esc>PVr^}

" Toggle between TODO and DONE
nnoremap <buffer> <LocalLeader>x :call <SID>ToggleTodo()<CR>

" be up to date
iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> xtodo *TODO*
iabbrev <buffer> xlink `NAME <>`_<Esc>2bea

function! s:ToggleTodo()
  let stop_at_line = search('^\s*$','nbW')
  if stop_at_line == 0 " find upper bound of paragraph
    let stop_at_line = 1
  endif

  let save_pos = winsaveview()
  if search('TODO','bsc', stop_at_line) > 0 " set mark ' before search starts
      normal cedone
  elseif search('done','bsc', stop_at_line) > 0 " set mark ' before search starts
      normal ceTODO
  endif
  call winrestview(save_pos)
endfunction

let b:did_ftplugin_after = 1
