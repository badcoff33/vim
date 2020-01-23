" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=0
setlocal shiftwidth=2
setlocal nocindent

nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>

" source current visual region -- use register @v
vnoremap <special> <buffer> <LocalLeader>s "vyQexecute @v<CR>visual<CR>

if empty(matchstr(expand("%:p"), "color"))
  " source Vim file
  nnoremap <special> <buffer> <LocalLeader>s :w<bar>source%<CR>
else
  " source Vim color theme
  nnoremap <special> <buffer> <LocalLeader>s :w<bar>colorscheme <C-r>=expand("%:t:r")<CR><CR>
endif

let b:did_ftplugin_after = 1
