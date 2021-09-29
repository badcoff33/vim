
" Use Umlaut keys in normal mode
scriptencoding utf-8

set langmap=ü/,Ü?,ö[,ä],Ö{,Ä}

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

nnoremap <F2> <cmd>FZF<CR>

colorscheme breeze
set guifont=Courier\ New:h11

" - Window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
