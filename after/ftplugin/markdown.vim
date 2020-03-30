" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=78
setlocal shiftwidth=4
setlocal nocindent
setlocal foldexpr=MarkdownFold()
setlocal foldmethod=expr
if has("conceal")
  setlocal conceallevel=0 concealcursor=nc
endif

" Toggle automatic code formatting
nnoremap <buffer> <LocalLeader>a :if !(&fo =~# 'a') <bar> setlocal fo+=a <bar> else <bar> setlocal fo-=a <bar> endif <CR>

nnoremap <buffer> <LocalLeader>x :sil call <SID>ToggleTodo()<CR>

nmap <buffer> <C-f>  :call search('^#\{1,\}\s',"W")<CR>
nmap <buffer> <C-b>  :call search('^#\{1,\}\s',"bW")<CR>

nmap <buffer> <LocalLeader>d i<C-r>=strftime("%Y-%m-%d")<CR><Esc>

" iabbrev did not work when 'cpoptions' has '>'
if match(&cpoptions, '>') >= 0
  finish
endif

iabbrev <buffer> xlink []()<Esc>2hi
iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> xx    [ ]
iabbrev <buffer> xpy   ``` python<CR><CR>```<Up>

function! s:ToggleTodo()
  if search('\[[ Xx]\]','b') > 0
    if strcharpart(getline('.')[col('.'):], 0, 1) == ' '
      normal lrX
    else
      exe "normal lr "
    endif
  endif
endfunction

let b:did_ftplugin_after = 1
