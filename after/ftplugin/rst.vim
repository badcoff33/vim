" reStructuredText filetype plugin file
" A nice one: Learn RST her http://rst.ninjs.org/

" let s:keepcpo= &cpo
" set cpo&vim

setlocal textwidth=78
setlocal expandtab tabstop=3 softtabstop=3 shiftwidth=3
setlocal formatoptions=qln
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:\\&^.\\{4\\}
setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=<!--%s-->

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
function s:ExchangeRstHead(char)
  if a:char == 'h'
    call popnews#Open("ReStructuredText Heading-1  #######  ")
    call popnews#Open("ReStructuredText Heading-2  *******  ")
    call popnews#Open("ReStructuredText Heading-3  =======  ")
    call popnews#Open("ReStructuredText Heading-4  -------  ")
    call popnews#Open("ReStructuredText Heading-5  ^^^^^^^  ")
    return
  endif
  call SaveLastSearch()
  if getline(line('.') - 1) =~ '^[#*]\{1,\}$'
    normal kdd
  endif
  if getline(line('.') + 1) =~ '^[#*=\-\^]\{1,\}$'
    normal jddk
  endif
  if a:char == '#'
    normal yyPP
    normal 0Vr#
    normal jj0Vr#k
  elseif a:char == '*'
    normal yyPP
    normal 0Vr*
    normal jj0Vr*k
  elseif a:char == '='
    normal yyP
    normal j0Vr=k
  elseif a:char == '-'
    normal yyP
    normal j0Vr-k
  elseif a:char == '^'
    normal yyP
    normal j0Vr^k
  endif
  call RestoreLastSearch()
endfunction

nnoremap <buffer> <LocalLeader>h <Cmd>call <SID>ExchangeRstHead('h')<CR>
nnoremap <buffer> <LocalLeader># <Cmd>call <SID>ExchangeRstHead('#')<CR>
nnoremap <buffer> <LocalLeader>* <Cmd>call <SID>ExchangeRstHead('*')<CR>
nnoremap <buffer> <LocalLeader>= <Cmd>call <SID>ExchangeRstHead('=')<CR>
nnoremap <buffer> <LocalLeader>- <Cmd>call <SID>ExchangeRstHead('-')<CR>
nnoremap <buffer> <LocalLeader>^ <Cmd>call <SID>ExchangeRstHead('^')<CR>
" delete surrounding heading lines
nnoremap <buffer> <LocalLeader><Del> <Cmd>call SaveLastSearch()<CR>:.-1,.+1s/^[#=\-*\^]\+$\n//<CR>k:call RestoreLastSearch()<CR>

" spell checker
nnoremap <buffer> <LocalLeader>se :setlocal spell spellang=en<CR>
nnoremap <buffer> <LocalLeader>sd :setlocal spell spellang=de<CR>

" be up to date
iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> xtodo *TODO*
iabbrev <buffer> xlink `NAME <>`_<Esc>2bea

" let &cpo = s:keepcpo
" unlet s:keepcpo

