" Vim ftplugin file

setlocal formatoptions=q
setlocal textwidth=80
setlocal shiftwidth=4
setlocal noexpandtab
setlocal autoindent
setlocal nocindent
setlocal foldexpr=MarkdownFold()
setlocal foldmethod=expr

if has("conceal")
  setlocal conceallevel=1 listchars+=conceal:$ concealcursor= 
endif

" Toggle automatic code formatting
nnoremap <buffer> <LocalLeader>a :if !(&fo =~# 'a') <bar> setlocal fo+=a <bar> else <bar> setlocal fo-=a <bar> endif <CR>

" Toggle between  `- [ ]` and `- [x]`
nnoremap <buffer> <LocalLeader>x :call <SID>ToggleTodo()<CR>

" spell checker
nnoremap <buffer> <LocalLeader>se :setlocal spell spellang=en<CR>
nnoremap <buffer> <LocalLeader>sd :setlocal spell spellang=de<CR>

" Make heading underlined
nnoremap <buffer> <localleader>1 yypVr=k
nnoremap <buffer> <localleader>2 yypVr-k
nnoremap <buffer> <localleader>3 yypVr~k

" if 'foldenable' is set, toggle folds
nnoremap <buffer> <CR> za

" More molecular undo of text
inoremap <buffer> , ,<C-g>u
inoremap <buffer> . .<C-g>u
inoremap <buffer> ! !<C-g>u
inoremap <buffer> ? ?<C-g>u
inoremap <buffer> ; ;<C-g>u
inoremap <buffer> : :<C-g>u

" paragraph hopping
nnoremap <buffer> <C-f> :call search('^#\{1,\}\s',"W")<CR>
nnoremap <buffer> <C-b> :call search('^#\{1,\}\s',"bW")<CR>

" insert date in a short form
nnoremap <buffer> <LocalLeader>d i<C-r>=strftime("%Y-%m-%d")<CR><Esc>

" iabbrev did not work when 'cpoptions' has '>'
if match(&cpoptions, '>') < 0
  iabbrev <buffer> xlink [TEXT](LINK)<C-o>B<C-o>2w
  iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
  iabbrev <buffer> xpy   ``` python<CR><CR>```<Up>
  iabbrev <buffer> xbox  - [ ]
  iabbrev <buffer> xsub  <sub><C-o>mc</sub><Esc>`ci
  iabbrev <buffer> xsup  <sup><C-o>mc</sup><Esc>`ci
endif

function! s:ToggleTodo()
  let stop_at_line = search('^\s*$','nbW')
  if stop_at_line == 0
    let stop_at_line = 1
  endif
  if search('- \[\( \|x\)\]','bsc', stop_at_line) > 0 " set mark ' before search starts
    if (strpart(getline('.'), col(".") - 1, 5) == '- [ ]')
      call feedkeys('3lrx', 'x')
    else
      call feedkeys('3lr ', 'x')
    endif
    normal `'
  endif
endfunction
