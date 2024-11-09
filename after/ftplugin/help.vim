" Vim ftplugin file
"
" Description: Add-on some features for Help files.

setlocal nonumber norelativenumber

" Jump to links with enter
nmap <silent> <buffer> <CR> <C-]>
" make use of K
nnoremap <buffer> K :help <C-r><C-w><CR>

" Show value of 'option' under cursor
nnoremap <buffer> <LocalLeader>o :verbose set <C-r>=substitute(expand("<cword>"), "[^a-z]", "", "g")<CR>?<CR>

" navigate to 'option'
nnoremap <buffer> <silent> o :call search("'\\w\\+'", 'W')<CR>
nnoremap <buffer> <silent> O :call search("'\\w\\+'", 'bW')<CR>

" navigate to |topic|
nnoremap <buffer> <silent> t :call search('\|[^\ ]\+\|', 'W')<CR>
nnoremap <buffer> <silent> T :call search('\|[^\ ]\+\|', 'bW')<CR>
