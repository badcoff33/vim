" reStructuredText filetype plugin file
" A nice one: Learn RST her http://rst.ninjs.org/

" let s:keepcpo= &cpo
" set cpo&vim

setlocal textwidth=78
setlocal expandtab tabstop=3 softtabstop=3 shiftwidth=3
setlocal formatoptions=qln
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:\\&^.\\{4\\}
setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=<!--%s-->

if has("conceal")
  setlocal conceallevel=1 listchars+=conceal:$ concealcursor=
endif

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
function s:InsertRstHead()
  let header_deco = ['#', '*' , '=', '-' ,'^']
  let chars = join(map(copy(header_deco), '"chapter-" .. v:key .. ": `" .. v:val .. "`"'), ', ')
  echo $"RST header {chars}"
  let char = nr2char(getchar())
  let deco_index = index(header_deco, char)
  if deco_index >= 0
    call SaveLastSearch()
    if getline(line('.') - 1) =~ '^[#*=\-\^]\{1,\}$'
      normal kdd
    endif
    if getline(line('.') + 1) =~ '^[#*=\-\^]\{1,\}$'
      normal jddk
    endif
    normal yyPP
    execute "normal 0Vr" .. header_deco[deco_index]
    execute "normal jj0Vr" .. header_deco[deco_index] .."k"
    call RestoreLastSearch()
  endif
endfunction

nnoremap <buffer> <LocalLeader>h <Cmd>call <SID>InsertRstHead()<CR>

" delete surrounding heading lines
nnoremap <buffer> <LocalLeader><Del> <Cmd>call SaveLastSearch()<CR>:.-1,.+1s/^[#=\-*\^]\+$\n//<CR>k:call RestoreLastSearch()<CR>

" spell checker
nnoremap <buffer> <LocalLeader>se :setlocal spell spellang=en<CR>
nnoremap <buffer> <LocalLeader>sd :setlocal spell spellang=de<CR>

" auto format paragraph
nnoremap <buffer> <LocalLeader>fA :setlocal formatoptions+=a
nnoremap <buffer> <LocalLeader>fa :setlocal formatoptions-=a

" be up to date
iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> xtodo *TODO*
iabbrev <buffer> xlink `NAME <>`_<Esc>2bea

" let &cpo = s:keepcpo
" unlet s:keepcpo
