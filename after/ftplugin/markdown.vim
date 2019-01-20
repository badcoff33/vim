" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=78
setlocal shiftwidth=4
setlocal nocindent
setlocal nonumber relativenumber

" Toggle automatic code formatting
nnoremap <buffer> <LocalLeader>a :if match(&fo, 'a') < 0 <bar> setlocal fo+=a <bar> else <bar> setlocal fo-=a <bar> endif <CR>

nmap <buffer> ]]  :call search('^#\{1,\}\s',"W")<CR>
nmap <buffer> [[  :call search('^#\{1,\}\s',"bW")<CR>

" iabbrev did not work when 'cpoptions' has '>'
if match(&cpoptions, '>') >= 0
  finish
endif

iabbrev <buffer> xlink []()<Esc>3hi

let b:did_ftplugin_after = 1
