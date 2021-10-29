let $PATH=$PATH..';C:\Users\prepensm\AppData\Local\Programs\Git\usr\bin'
" Use Umlaut keys in normal mode
scriptencoding utf-8

set langmap=ü/,Ü?,ö[,ä],Ö{,Ä}

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

nnoremap <F2> <cmd>Files<CR>
nnoremap <F3> <cmd>Buffers<CR>
nnoremap <F4> <cmd>BTags<CR>
nnoremap <C-p> <cmd>Buffers<CR>

if has('gui')
  colorscheme breeze
  set guifont=Courier\ Prime:h11
endif

" - Window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
