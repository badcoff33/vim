" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=78
setlocal shiftwidth=4
setlocal nocindent
setlocal nonumber relativenumber
setlocal foldexpr=MarkdownFold()  
setlocal foldmethod=expr

" Toggle automatic code formatting
nnoremap <buffer> <LocalLeader>a :if match(&fo, 'a') < 0 <bar> setlocal fo+=a <bar> else <bar> setlocal fo-=a <bar> endif <CR>

nnoremap <buffer> <f9> :sil call filetype#markdown#ToggleTodo()<CR>

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

let b:did_ftplugin_after = 1
