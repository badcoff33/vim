
" Use Umlaut keys in normal mode
scriptencoding utf-8

set langmap=ü/,Ü?,ö[,ä],Ö{,Ä}

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

nnoremap <Leader>nn :drop ~\.notes\notes.md<cr>
nnoremap <Leader>nd :drop ~\.notes\diary.md<cr>

nnoremap <F5> :Start <Up>
nnoremap <S-F5> :Jobs<cr>
imap <f5> <Esc><F5>
imap <S-f5> <Esc><S-F5>

nnoremap <F12> :tj /\c
imap <f12> <esc><f12>

" Switching between panels
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

let g:guiWindowFullScreen = 0
nnoremap <F11> :let g:guiWindowFullScreen = !g:guiWindowFullScreen <bar> call GuiWindowFullScreen(g:guiWindowFullScreen)<CR>
imap <f11> <esc><f11>

if has('nvim')
  vnoremap <S-Del>    "+x
  vnoremap <C-Insert> "+y
  map <S-Insert>      "+gP
  imap <S-Insert>     <C-R>+
  cmap <S-Insert>     <C-R>+
endif

if exists('g:GuiLoaded')
  if g:GuiLoaded == 1
    nnoremap <leader>2 :GuiFont! Consolas:h13<CR>
    nnoremap <leader>1 :GuiFont! Consolas:h11<CR>
    nnoremap <leader>0 :GuiFont! Consolas:h10<CR>
    GuiLinespace 6
    call feedkeys(mapleader.'1') " default font
    colorscheme breeze
    set mouse=a
  endif
else
  if has('gui')
    call feedkeys(mapleader.'1') " default font
    nnoremap <leader>2 :set guifont=Courier\ New:h11 linespace=3<CR>
    nnoremap <leader>1 :set guifont=Courier\ New:h10 linespace=3<CR>
    nnoremap <leader>0 :set guifont=Courier\ New:h9  linespace=3<CR>
    colorscheme breeze
    set guicursor+=a:blinkon0
  endif
endif

