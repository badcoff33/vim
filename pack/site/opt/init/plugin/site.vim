
" Use Umlaut keys in normal mode
scriptencoding utf-8

set langmap=ü/,Ü?,ö[,ä],Ö{,Ä}

set grepprg=rg\ --vimgrep\ --follow\ -tc\ -tvim\ -tpy
set grepformat=%f:%l:%c:%m

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)
nnoremap <Leader>O :drop ~/.notes.md<cr>
nnoremap <leader>n :tabedit ~\.notes.md<cr>

if exists('g:GuiLoaded')
  if g:GuiLoaded == 1
    nnoremap <leader>2 :GuiFont! Consolas:h13<CR>
    nnoremap <leader>1 :GuiFont! Consolas:h11<CR>
    nnoremap <leader>0 :GuiFont! Consolas:h10<CR>
    GuiLinespace 6
    call feedkeys(' 0') " default font
    colorscheme apollo
    set mouse=a
  endif
else
  if has('gui')
    call feedkeys(' 1') " default font
    nnoremap <leader>2 :set guifont=Consolas:h12 linespace=4<CR>
    nnoremap <leader>1 :set guifont=Consolas:h11 linespace=4<CR>
    nnoremap <leader>0 :set guifont=Consolas:h10 linespace=3<CR>
    colorscheme apollo
    set guicursor+=a:blinkon0
  endif
endif

" vim:ft=vim:fenc=latin1
