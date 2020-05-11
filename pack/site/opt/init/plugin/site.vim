
" Use Umlaut keys in normal mode
scriptencoding utf-8

set langmap=ü/,Ü?,ö[,ä],Ö{,Ä}

set grepprg=rg\ --vimgrep\ --follow\ -tc\ -tvim\ -tpy
set grepformat=%f:%l:%c:%m

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

if exists('g:GuiLoaded')
  if g:GuiLoaded == 1
    nnoremap <leader>2 :GuiFont! Consolas:h13<CR>
    nnoremap <leader>1 :GuiFont! Consolas:h11<CR>
    nnoremap <leader>0 :GuiFont! Consolas:h10<CR>
    GuiLinespace 6
    call feedkeys(' 1') " default font
    colorscheme apollo
  endif
else
  if has('gui')
    set guifont=Consolas:h11 linespace=4
    nnoremap <leader>2 :set guifont=Consolas:h12 linespace=4<CR>
    nnoremap <leader>1 :set guifont=Consolas:h11 linespace=4<CR>
    nnoremap <leader>0 :set guifont=Consolas:h10 linespace=3<CR>
    colorscheme frost
  endif
endif

" vim:ft=vim:fenc=latin1
