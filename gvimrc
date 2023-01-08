set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~
set guioptions=!a
set guicursor+=a:blinkon0
set renderoptions=
set mousemodel=popup
set nomousefocus
set signcolumn=yes
set laststatus=2

augroup gvimrc
    autocmd!
    autocmd FocusLost * try | wall | catch /.*/ | endtry
augroup END

let FontFamily = {-> escape(split(&gfn, ":")[0], ' ')}
let IncFontHeight = {-> string(str2nr(split(&gfn, ":h")[1]) + 1)}
let DecFontHeight = {-> string(str2nr(split(&gfn, ":h")[1]) - 1)}

nnoremap <expr> <C-ScrollWheelUp> "<cmd>set guifont=" .. FontFamily() .. ":h" .. IncFontHeight() .. "<CR>"
nnoremap <expr> <C-ScrollWheelDown> "<cmd>set guifont=" .. FontFamily() .. ":h" .. DecFontHeight() .. "<CR>"

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

" Vim9: (gvim.exe) since C-] is no longer mapped on German keyboards, use this
nmap <C-+> g<C-]>
imap <C-+> <C-]>
imap <C-Char-252> <C-[>
cmap <C-Char-252> <C-[>

" vim:ft=vim
