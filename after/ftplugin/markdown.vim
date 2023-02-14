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

let b:markdown_css_file = g:vim_home .. "\\templates\\simple.css"
if !filereadable(b:markdown_css_file)
  let b:markdown_css_file =  ""
else
  let b:markdown_css_file = " --css=" .. b:markdown_css_file
endif

let b:markdown_template_file = g:vim_home .. "\\templates\\template.html"
if !filereadable(b:markdown_template_file)
 let b:markdown_template_file = ""
else
  let b:markdown_template_file = " --template=" .. b:markdown_template_file
endif

let b:markdown_command = "pandoc -f gfm -t html5 --toc --toc-depth=3"
      \ .. b:markdown_css_file
      \ .. b:markdown_template_file
      \ .." --metadata title=\""..expand("%:t:r").."\""
      \ .." -o "..getenv("TEMP")..g:slash..expand("%:t")..".html"
      \ .." "..getenv("TEMP")..g:slash.."_"..expand("%:t")

command! -buffer OpenMarkdownPreview call <SID>OpenHTML()
command! -buffer UpdateMarkdownPreview call <SID>MakeHTML()

autocmd InsertLeave <buffer> call <SID>UpdateShadowFile()
autocmd TextChanged <buffer> call <SID>UpdateShadowFile()
autocmd InsertLeave <buffer> call timer_start(2000, expand("<SID>").."MakeHTML")
autocmd TextChanged <buffer> call timer_start(2000, expand("<SID>").."MakeHTML")

function! s:UpdateShadowFile()
  silent exe "write!" getenv("TEMP")..g:slash.."_"..expand("%:t")
  silent exe "bwipeout!" getenv("TEMP")..g:slash.."_"..expand("%:t")
endfunction

function! s:OpenHTML()
    exe "terminal ++close ++hidden cmd /C start" getenv("TEMP")..g:slash..expand("%:t")..".html"
endfunction

function! s:MakeHTML(...)
  if exists("b:markdown_command")
    call run#Run(#{
          \ cmd: b:markdown_command,
          \ hidden: v:true,
          \ nowrite: v:true
          \ })
  endif
endfunction

" Plugin EasyAlign tables
if exists(":EasyAlign")
  nnoremap <buffer> <LocalLeader><Tab> vap:EasyAlign *\|<CR>`.
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

iabbrev <buffer> xlink [TEXT](LINK)<C-o>B<C-o>2w
iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> xpy   ``` python<CR><CR>```<Up>
iabbrev <buffer> xtodo - [ ]

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

