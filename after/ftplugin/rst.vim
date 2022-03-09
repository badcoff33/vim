" reStructuredText filetype plugin file
" A nice one: Learn RST her http://rst.ninjs.org/

setlocal textwidth=78
setlocal shiftwidth=4
setlocal nocindent
setlocal formatoptions-=a
setlocal tabstop=4
setlocal shiftwidth=0 " carry over from 'tabstop'

" Make heading underlined
nnoremap <buffer> <LocalLeader>h1 yyppkkVr=jjVr=}
nnoremap <buffer> <LocalLeader>h2 yyppkkVr-jjVr-}
nnoremap <buffer> <LocalLeader>h3 0v$beyo<Esc>PVr~}
nnoremap <buffer> <LocalLeader>h4 0v$beyo<Esc>PVr^}

" Toggle between TODO and DONE
nnoremap <buffer> <LocalLeader>x :call gtd#ToggleTodo()<CR>

" be up to date
iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> xtodo *TODO*
iabbrev <buffer> xlink `NAME <>`_<Esc>2bea

