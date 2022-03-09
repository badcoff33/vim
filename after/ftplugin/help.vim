" Vim ftplugin file
"
" Description: Add-on some features for Help files.

setlocal nonumber norelativenumber

" Jump to links with enter
nmap <silent> <buffer> <CR> <C-]>
" make use of K
nnoremap <buffer> K :help <C-r><C-w><CR>

" Close help again
nmap <silent> <buffer> <Esc> :bd<CR>

" Show value of 'option' under cursor
nnoremap <buffer> <LocalLeader>o :set <C-r>=substitute(expand("<cword>"), "[^a-z]", "", "g")<CR>?<CR>

nnoremap <buffer> <silent> . :call search('\|[^\ ]\+\|', 'W')<CR>
nnoremap <buffer> <silent> , :call search('\|[^\ ]\+\|', 'bW')<CR>

