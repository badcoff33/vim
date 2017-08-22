" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=80
setlocal shiftwidth=4
setlocal nocindent
setlocal formatoptions+=a
setlocal nonumber relativenumber

let b:did_ftplugin_after = 1
