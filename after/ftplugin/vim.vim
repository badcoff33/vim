" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=0
setlocal shiftwidth=2
setlocal nocindent

" statusline with cursors scope info
setlocal statusline=%1*%t%m%r%y%w\ %2*\ %{scope#ScopeParserVim()}\ %0*%=%l,%c%V\ %P

nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>
nnoremap <buffer> <localleader>h :verbose highlight <C-r><C-w><CR>

" Execute whole Vim file
nnoremap <special> <buffer> <LocalLeader>e :w<bar>source%<CR>

" Execute current line (and clear annoying ^M)
nnoremap <special> <buffer> <LocalLeader>E yy:<C-r>0<BS><CR>

" Execute visual region
vnoremap <special> <buffer> <LocalLeader>E :write! $TEMP\sourced_lines.vim<CR> :source $TEMP\sourced_lines.vim<CR>
vnoremap <special> <buffer> <LocalLeader>e :write! $TEMP\sourced_lines.vim<CR> :source $TEMP\sourced_lines.vim<CR>

let b:did_ftplugin_after = 1
