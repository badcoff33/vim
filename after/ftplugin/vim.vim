" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=0
setlocal shiftwidth=2
setlocal nocindent

" statusline with cursors scope info
setlocal statusline=%1*%t%m%r%y%w\ %2*\ %{scope#ScopeParserVim()}\ %3*\ %{runjob#GetStatus()}\ %0*%=%l,%c%V\ %P

nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>
nnoremap <buffer> <localleader>h :verbose highlight <C-r><C-w><CR>

" Execute current visual region -- use register @v
vnoremap <special> <buffer> <LocalLeader>e "vyQexecute @v<CR>visual

if empty(matchstr(expand("%:p"), "color"))
  " Execute whole Vim file
  nnoremap <special> <buffer> <LocalLeader>e :w<bar>source%<CR>
else
  " Execute Vim color theme
  nnoremap <special> <buffer> <LocalLeader>e :w<bar>colorscheme <C-r>=expand("%:t:r")<CR><CR>
endif

let b:did_ftplugin_after = 1
