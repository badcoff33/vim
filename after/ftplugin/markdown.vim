" Vim ftplugin file

setlocal formatoptions=tacqw
setlocal textwidth=78
setlocal shiftwidth=4
setlocal autoindent
setlocal nocindent
setlocal foldexpr=MarkdownFold()
setlocal foldmethod=expr

if has("conceal")
  setlocal conceallevel=0 concealcursor=nc
endif

vnoremap <LocalLeader>x "xy:luado print("<C-r>x = "..<C-r>x)<CR>

" Toggle automatic code formatting
nnoremap <buffer> <LocalLeader>a :if !(&fo =~# 'a') <bar> setlocal fo+=a <bar> else <bar> setlocal fo-=a <bar> endif <CR>

" Toggle between  `- [ ]` and `- [x]`
nnoremap <buffer> <LocalLeader>x :call <SID>ToggleTodo()<CR>

" some math calculation
nnoremap g== o<C-r>="= "..luaeval(getline(line(".") - 1))<CR>

" Preview in html
let b:css_file = expand('<sfile>:p:h').."\\markdown\\normalized.css"
if filereadable(b:css_file)
  let b:html_template_file = expand('<sfile>:p:h').."\\markdown\\template.html"
  command! -buffer PreviewHTML terminal ++close ++hidden cmd /C start .preview.html
  command! -buffer MakeHTML exe "terminal ++close ++hidden"
        \ .." pandoc -f gfm -t html5"
        \ .." --css="..b:css_file
        \ .." --template="..b:html_template_file
        \ .." --metadata title=\""..expand("%:t").."\""
        \ .." -o .preview.html "
        \ ..expand("%")
endif

" Plugin EasyAlign tables
vnoremap <buffer> <Tab> :EasyAlign *\|<CR>`.

" Make heading underlined
nnoremap <buffer> <localleader>1 yypVr=k
nnoremap <buffer> <localleader>2 yypVr-k
nnoremap <buffer> <localleader>2 yypVr~k

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
if match(&cpoptions, '>') >= 0
  finish
endif

iabbrev <buffer> _link []()<Esc>2hi
iabbrev <buffer> _date <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> _py   ``` python<CR><CR>```<Up>
iabbrev <buffer> _todo - [ ]

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

