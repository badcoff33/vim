" Vim ftplugin file

setlocal formatoptions=q
setlocal textwidth=80
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
nnoremap <buffer> g== o<C-r>="= "..luaeval(getline(line(".") - 1))<CR>

" Preview in HTML
if filereadable(expand('<sfile>:p:h').."\\CSS\\simple.css")
  command! -buffer OpenHTML call OpenHTML()
  command! -buffer MakeHTML call MakeHTML()
  nnoremap <buffer> <C-F7> <cmd>MakeHTML<CR>
  nnoremap <buffer> <F7> <cmd>OpenHTML<CR>
  autocmd InsertLeave <buffer> call UpdateShadowFile()
  autocmd TextChanged <buffer> call UpdateShadowFile()
  autocmd InsertLeave <buffer> call timer_start(2000, "MakeHTML")
  autocmd TextChanged <buffer> call timer_start(2000, "MakeHTML")
  let b:md_to_html_cmd = "pandoc -f gfm -t html5 --toc --toc-depth=3"
        \ .." --css="..expand('<sfile>:p:h').."\\CSS\\simple.css"
        \ .." --template="..expand('<sfile>:p:h').."\\CSS\\template.html"
        \ .." --metadata title=\""..expand("%:t:r").."\""
        \ .." -o "..getenv("TEMP")..g:path_sep..expand("%:t")..".html"
        \ .." "..getenv("TEMP")..g:path_sep.."_"..expand("%:t")..".html"
endif

function! UpdateShadowFile()
  silent exe "write!" getenv("TEMP")..g:path_sep.."_"..expand("%:t")..".html"
endfunction

function! OpenHTML()
    exe "terminal ++close ++hidden cmd /C start" getenv("TEMP")..g:path_sep..expand("%:t")..".html"
endfunction

function! MakeHTML(...)
  if exists("b:md_to_html_cmd")
    call run#run({
          \ 'cmd': b:md_to_html_cmd,
          \ 'hidden': 1,
          \ 'nowrite': 1
          \ })
  endif
endfunction

" Plugin EasyAlign tables
if exists(":EasyAlign")
  vnoremap <buffer> <Tab> :EasyAlign *\|<CR>`.
endif

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

