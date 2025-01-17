" A general purpose text file config

setlocal textwidth=78 shiftwidth=4 nocindent formatoptions-=atc

" be up to date
iabbrev <buffer> _date <C-r>=strftime("%Y-%m-%d")<CR>

let b:undo_ftplugin = "setlocal textwidth< shiftwidth< nocindent< formatoptions<"
