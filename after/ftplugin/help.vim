" Vim ftplugin file
"
" Description: Add-on some features for Help files.

if exists("b:did_ftplugin_after")
  finish
endif
" Jump to links with enter
nmap <silent> <buffer> <CR> <C-]>

" Jump back with backspace
nmap <silent> <buffer> <BS> <C-T>

" q to quit
nmap <silent> <buffer> q :quit<CR>

" open help file in the left window
" alternative: e.g. vert help syntax
autocmd BufWinEnter <buffer> wincmd H

" Show value of 'option' under cursor
nnoremap <buffer> <LocalLeader>o :set <C-r>=substitute(expand("<cword>"), "[^a-z]", "", "g")<CR>?<CR>

nnoremap <buffer> <silent> . :call search('\|\w\+\|' , 'W')<CR>
nnoremap <buffer> <silent> , :call search('\|\w\+\|' , 'bW')<CR>

let b:did_ftplugin_after = 1
