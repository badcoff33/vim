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

" Make heading overlined/underlined following the Sphinx recommenadation, "Section"
" https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html
"  1   # with overline, for parts
"  2   * with overline, for chapters
"  3   = for sections
"  4   - for subsections
"  5   ^ for subsubsections
nnoremap <buffer> <LocalLeader>1 yyppkkVr#jjVr#k
nnoremap <buffer> <LocalLeader>2 yyppkkVr*jjVr*k
nnoremap <buffer> <LocalLeader>3 0v$beyo<Esc>PVr=k
nnoremap <buffer> <LocalLeader>4 0v$beyo<Esc>PVr-k
nnoremap <buffer> <LocalLeader>5 0v$beyo<Esc>PVr^k
" delete surrounding heading lines
nnoremap <buffer> <LocalLeader>0 <Cmd>call SaveLastSearch()<CR>:.-1,.+1s/^[#=\-*\^]\+$\n//<CR>k:call RestoreLastSearch()<CR>

" be up to date
iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> xtodo *TODO*
iabbrev <buffer> xlink `NAME <>`_<Esc>2bea

