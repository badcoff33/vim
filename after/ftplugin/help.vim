" Vim ftplugin file
"
" Description: Add-on some features for Help files.

if exists("b:did_ftplugin_after")
  finish
endif

" Jump to links with enter
nmap <silent> <buffer> <CR> <C-]>

" Close help again
nmap <silent> <buffer> <Esc> :bd<CR>

" open help file in the left window (if there is enough room)
autocmd BufEnter <buffer> if (winnr('$') == 2) && (&columns > 164) | wincmd H | endif

" Show value of 'option' under cursor
nnoremap <buffer> <LocalLeader>o :set <C-r>=substitute(expand("<cword>"), "[^a-z]", "", "g")<CR>?<CR>

nnoremap <buffer> <silent> . :call search('\|\w\+\|' , 'W')<CR>
nnoremap <buffer> <silent> , :call search('\|\w\+\|' , 'bW')<CR>

let b:did_ftplugin_after = 1
