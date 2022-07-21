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
nnoremap <buffer> g== o<C-r>="= "..luaeval(getline(line(".") - 1))<CR>

" Preview in html
let b:md_preview_file = getenv("TEMP")..g:path_sep..expand("%:t")..".html"
let b:md_shadow_file = getenv("TEMP")..g:path_sep..expand("%:t")
let b:md_title = expand("%:t")
let b:md_css_file = expand('<sfile>:p:h').."\\markdown\\simple.css"
let b:html_template_file = expand('<sfile>:p:h').."\\markdown\\template.html"

if filereadable(b:md_css_file)
  command! -buffer OpenHTML call OpenHTML()
  command! -buffer MakeHTML call MakeHTML()
  nnoremap <buffer> <C-F7> <cmd>write<bar>MakeHTML<CR>
  nnoremap <buffer> <F7> <cmd>OpenHTML<CR>
  autocmd InsertLeave <buffer> MakeHTML
else
  echomsg expand("<sfile>")..": No CSS file found"
endif

function! OpenHTML()
    exe "terminal ++close ++hidden cmd /C start" b:md_preview_file
endfunction

function! MakeHTML()
  exe "write!" b:md_shadow_file
  let md_to_html_cmd = "pandoc -f gfm -t html5"
        \ .." --css="..b:md_css_file
        \ .." --template="..b:html_template_file
        \ .." --metadata title=\""..b:md_title."\""
        \ .." -o "..b:md_preview_file
        \ .." "..b:md_shadow_file
  exe "terminal ++close ++hidden cmd /C" md_to_html_cmd
endfunction

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

