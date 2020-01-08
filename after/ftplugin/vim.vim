" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=0
setlocal shiftwidth=2
setlocal nocindent

nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>
nnoremap <buffer> <localleader>h :verbose highlight <C-r><C-w><CR>

" Execute current visual region -- use register @v
vnoremap <special> <buffer> <CR> "vyQexecute @v<CR>visual<CR>

if bufname() != "[Command Line]" && empty(&buftype)
  if empty(matchstr(expand("%:p"), "color")) 
    " Execute whole Vim file
    nnoremap <special> <buffer> <CR> :w<bar>source%<CR>
  else
    " Execute Vim color theme
    nnoremap <special> <buffer> <CR> :w<bar>colorscheme <C-r>=expand("%:t:r")<CR><CR>
  endif
endif

let b:did_ftplugin_after = 1
