" A general pupose text file config

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=78
setlocal shiftwidth=4
setlocal nocindent
setlocal formatoptions-=atc

" Toggle between TODO and DONE
nnoremap <buffer> <LocalLeader>x :call lib#gtd#ToggleTodo()<CR>

" be up to date
iabbrev <buffer> xdate <C-r>=strftime("%Y-%m-%d")<CR>
iabbrev <buffer> xtodo *TODO*

let b:did_ftplugin_after = 1
