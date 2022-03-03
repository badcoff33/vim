syntax on

let FontFamily = {-> split(&gfn, ":")[0]}
nnoremap <expr> <leader>h13 ':set guifont='..FontFamily()..':h13<CR>'
nnoremap <expr> <leader>h12 ':set guifont='..FontFamily()..':h12<CR>'
nnoremap <expr> <leader>h11 ':set guifont='..FontFamily()..':h11<CR>'
nnoremap <expr> <leader>h10 ':set guifont='..FontFamily()..':h10<CR>'
nnoremap <expr> <leader>h9  ':set guifont='..FontFamily()..':h9<CR>'

set guifont=Cascadia_Code:h11
set guioptions=!a
set guicursor+=a:blinkon0
set renderoptions=
set mousemodel=popup
set nomousefocus
set signcolumn=yes
set columns=120

tnoremap <LeftMouse> <C-w>N
tmap <RightMouse> <C-w>N<RightMouse>

nnoremenu 1.300 PopUp.-SEP3- <NOP>
if has('win32') || has('win64')
  nnoremenu 1.310 PopUp.Explore :silent !explorer <C-r>=expand('%:p:h')<CR><CR>
else
  nnoremenu 1.310 PopUp.Explore :silent Lexplore <C-r>=expand('%:p:h')<CR><CR>
endif
nnoremenu 1.320 PopUp.-SEP4- <NOP>
nnoremenu 1.321 PopUp.Set\ font  :set guifont=*<CR>

" vim:ft=vim
