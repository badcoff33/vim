" reStructuredText filetype plugin file
" A nice one: Learn RST her http://rst.ninjs.org/

setlocal textwidth=78
setlocal shiftwidth=4
setlocal nocindent
setlocal formatoptions=
setlocal tabstop=4
setlocal shiftwidth=0 " carry over from 'tabstop'

" More molecular undo of text
inoremap <buffer> , ,<C-g>u
inoremap <buffer> . .<C-g>u
inoremap <buffer> ! !<C-g>u
inoremap <buffer> ? ?<C-g>u
inoremap <buffer> ; ;<C-g>u
inoremap <buffer> : :<C-g>u

" Make heading overlined/underlined
" following the Sphinx recommenadation, "Section"
" https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html
"  1   # with overline, for parts
"  2   * with overline, for chapters
"  3   = for sections
"  4   - for subsections
"  5   ^ for subsubsections
"  6   " for paragraphs
nnoremap <buffer> <LocalLeader>1 yyppkkVr#jjVr#}
nnoremap <buffer> <LocalLeader>2 yyppkkVr*jjVr*}
nnoremap <buffer> <LocalLeader>3 0v$beyo<Esc>PVr=}
nnoremap <buffer> <LocalLeader>4 0v$beyo<Esc>PVr-}
nnoremap <buffer> <LocalLeader>5 0v$beyo<Esc>PVr^}
nnoremap <buffer> <LocalLeader>6 0v$beyo<Esc>PVr"}

" Toggle between TODO and DONE
nnoremap <buffer> <LocalLeader>x :call gtd#ToggleTodo()<CR>

" be up to date
iabbrev <buffer> _date <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> _todo *TODO*
iabbrev <buffer> _link `NAME <>`_<Esc>2bea

