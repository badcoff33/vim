" Vim ftplugin file
"
" Description: Add-on some features for Help files.

if exists("b:did_ftplugin_after")
  finish
endif

" Show value of 'option' under cursor
nnoremap <buffer> <LocalLeader>o :set <C-r>=substitute(expand("<cword>"), "'", "", "g")<CR>?<CR>

let b:did_ftplugin_after = 1
