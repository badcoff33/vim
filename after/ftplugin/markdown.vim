" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=80
setlocal shiftwidth=4
setlocal nocindent
setlocal nonumber relativenumber

nmap <buffer> ]]  :call search('^#\{1,\}\s',"W")<CR>
nmap <buffer> [[  :call search('^#\{1,\}\s',"bW")<CR>

let b:did_ftplugin_after = 1
