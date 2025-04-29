vim9script

#    ____     ___ __    __      _____  ____  _        ___
#   |    \   /  _]  |__|  |    |     ||    || |      /  _]
#   |  _  | /  [_|  |  |  |    |   __| |  | | |     /  [_
#   |  |  ||    _]  |  |  |    |  |_   |  | | |___ |    _]
#   |  |  ||   [_|  `  '  |    |   _]  |  | |     ||   [_
#   |  |  ||     |\      /     |  |    |  | |     ||     |
#   |__|__||_____| \_/\_/      |__|   |____||_____||_____|

# reposition cursor
inoremap {} {}<left>
inoremap "" ""<left>
inoremap () ()<left>
inoremap `` ``<Left>

inoremap <C-Space> <Esc>
inoremap <S-Tab> <Esc>
inoremap <C-Tab> <Esc>
inoremap jj <Esc>
inoremap <C-End> <Esc>
nnoremap <C-]> g<C-]>
nnoremap + g<C-]>

nnoremap ö :cprevious<CR>
nnoremap ä :cnext<CR>
cabbrev lex Lexplore <C-r>=expand("%:p:h")<CR><CR>

#set timeout ttimeout timeoutlen=900 ttimeoutlen=900
set notimeout nottimeout
#set guifont=Space\ Mono:h11 linespace=-2
set guifont=Fantasque\ Sans\ Mono:h12 linespace=3
#set guifont=Rec\ Mono\ Duotone:h11 linespace=0
set winaltkeys=no
set norelativenumber
set foldcolumn=1

augroup GroupUser
  au!
  au BufEnter,BufCreate *.rst,*.md inoremap <buffer> <C-z>q <Esc>gw(i
  au BufEnter,BufCreate *.rst,*.md inoremap <buffer> <C-z>p <C-r>*
  au BufEnter,BufCreate *.rst,*.md vnoremap <buffer> <C-z>y "*y
  au BufEnter,BufCreate *.c,*.h setlocal fo-=cr
augroup END

g:notes_home = "C:\\Users\\prepensm\\OneDrive\\ -\\ Webasto\\ Group\\Dokumente\\Notes"
nnoremap <Leader>n :<C-u>Notes<Space>
packadd notes

nnoremap <A-g> :<C-u>Git<Space>
packadd vcs

packadd easy-align
# Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
# Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

# for Signify
set signcolumn=yes
packadd signify

#Blinky stay
Blinky flash
#Blinky off

if &term == "builtin_gui"
  colorscheme blaubeere
else
  colorscheme apollo
endif

g:rst_style = 0
g:rst_fold_enabled = 1

g:netrw_use_errorwindow = 1
g:netrw_wiw = 1
g:netrw_banner = 1
g:netrw_browse_split = 0
g:netrw_altv = 1
g:netrw_cursor = 0
g:netrw_list_hide = '.*\.swp$'
g:netrw_liststyle = 0


g:netrw_decompress = { ".7z": "7z x", ".zip": "unzip"}
g:netrw_compress = "zip"

augroup GroupNetrwAdd
  autocmd!
  # autocmd WinLeave * let g:netrw_chgwin=winnr()
augroup END
