
" fix broken C-[, C-] keys on Vim9
inoremap <C-Char-252> <C-[>
cnoremap <C-Char-252> <C-[>

cnoremap <C-+> <C-]>
cnoremap <C-Space> <C-]>

inoremap <C-+> <C-]>
inoremap <C-Space> <C-]>
inoremap <C-x><C-+> <C-x><C-]>

nnoremap <C-+> g<C-]>zz
