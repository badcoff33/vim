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
let b:rst_css_file = g:vim_home .. "\\templates\\simple.css"
if !filereadable(b:rst_css_file)
  let b:rst_css_file =  ""
else
  let b:rst_css_file = " --css=" .. b:rst_css_file
endif

let b:rst_template_file = g:vim_home .. "\\templates\\template.html"
if !filereadable(b:rst_template_file)
 let b:rst_template_file = ""
else
  let b:rst_template_file = " --template=" .. b:rst_template_file
endif

let b:rst_command = "pandoc -f rst -t html5 --toc --toc-depth=3"
      \ .. b:rst_css_file
      \ .. b:rst_template_file
      \ .." --metadata title=\""..expand("%:t:r").."\""
      \ .." -o "..getenv("TEMP")..g:slash..expand("%:t")..".html"
      \ .." "..getenv("TEMP")..g:slash.."_"..expand("%:t")

command! -buffer OpenRstPreview call <SID>OpenHTML()
command! -buffer UpdateRsPreview call <SID>MakeHTML()

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
  if exists("b:rst_command")
    call run#Run(#{
          \ cmd: b:rst_command,
          \ hidden: v:true,
          \ nowrite: v:true
    })
  endif
endfunction
