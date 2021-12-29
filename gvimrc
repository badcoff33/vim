syntax on

let F = {font -> escape(matchstr(font,'^[A-Za-z_\ ]\+'), ' ')}
nnoremap <expr> <leader>4 ':set guifont='..F(g:GuiFont)..':h14 <CR>'
nnoremap <expr> <leader>3 ':set guifont='..F(g:GuiFont)..':h12 <CR>'
nnoremap <expr> <leader>2 ':set guifont='..F(g:GuiFont)..':h10 <CR>'
nnoremap <expr> <leader>1 ':set guifont='..F(g:GuiFont)..':h9  <CR>'

colorscheme little_monster

set guifont=fira_code:h12
set guioptions=!a
set guicursor+=a:blinkon0
set renderoptions=
set mousemodel=popup
set nomousefocus
set signcolumn=yes

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
