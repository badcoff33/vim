" Vim ftplugin file
"
" Description: Add-on some features for Help files.

setlocal nonumber norelativenumber

" Jump to links with enter
nmap <silent> <buffer> <CR> <C-]>
" make use of K
nnoremap <buffer> K :help <C-r><C-w><CR>

packadd helptoc
nnoremap <buffer> gO :HelpToc<CR>

" Show value of 'option' under cursor
nnoremap <buffer> <LocalLeader>o :ShowVimOption<CR>

command -buffer ShowVimOption call <SID>ShowVimOption()

function s:ShowVimOption()
  let maybe_option = substitute(expand('<cword>'), "'", "", "g")
  try
    execute "verbose set" maybe_option .. '?'
  endtry
endfunction

" navigate to 'option'
nnoremap <buffer> <silent> o :call search("'\\w\\+'", 'W')<CR>
nnoremap <buffer> <silent> O :call search("'\\w\\+'", 'bW')<CR>

" navigate to |topic|
nnoremap <buffer> <silent> t :call search('[\*\|][a-zA-Z-_:]\+[\*\|]', 'W')<CR>
nnoremap <buffer> <silent> T :call search('[\*\|][a-zA-Z-_:]\+[\*\|]', 'bW')<CR>
