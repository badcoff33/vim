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
iabbrev <buffer> _date <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> _todo *TODO*
iabbrev <buffer> _link `NAME <>`_<Esc>2bea

" Preview in HTML
if filereadable(expand('<sfile>:p:h').."\\CSS\\simple.css")
  command! -buffer RstOpenPreview call <SID>OpenHTML()
  command! -buffer RstMakePreview call <SID>MakeHTML()
  autocmd InsertLeave <buffer> call <SID>UpdateShadowFile()
  autocmd TextChanged <buffer> call <SID>UpdateShadowFile()
  autocmd InsertLeave <buffer> call timer_start(2000, expand("<SID>").."MakeHTML")
  autocmd TextChanged <buffer> call timer_start(2000, expand("<SID>").."MakeHTML")
  let b:markdown_to_html_cmd = "pandoc -f rst -t html5 --toc --toc-depth=3"
        \ .." --css="..expand('<sfile>:p:h').."\\CSS\\simple.css"
        \ .." --template="..expand('<sfile>:p:h').."\\CSS\\template.html"
        \ .." --metadata title=\""..expand("%:t:r").."\""
        \ .." -o "..getenv("TEMP")..g:slash..expand("%:t")..".html"
        \ .." "..getenv("TEMP")..g:slash.."_"..expand("%:t")
endif

function! s:UpdateShadowFile()
  silent exe "write!" getenv("TEMP")..g:slash.."_"..expand("%:t")
  silent exe "bwipeout!" getenv("TEMP")..g:slash.."_"..expand("%:t")
endfunction

function! s:OpenHTML()
    exe "terminal ++close ++hidden cmd /C start" getenv("TEMP")..g:slash..expand("%:t")..".html"
endfunction

function! s:MakeHTML(...)
  if exists("b:markdown_to_html_cmd")
    call run#run({
          \ 'cmd': b:markdown_to_html_cmd,
          \ 'hidden': 1,
          \ 'nowrite': 1
          \ })
  endif
endfunction
