vim9script

inoremap <C-Space> <Esc>
inoremap <S-Space> <Esc>

# Living with QWERTZ keyboards
set langmap=ö[,ä],Ö{,Ä},ü/,Ü?

###############################################################################
# Filetype rst
g:rst_style = 1

###############################################################################
# TAGBAR
hi! link TagbarHighlight Pmenu
g:tagbar_sort = 0
g:tagbar_left = 1
g:tagbar_autoclose = 1
g:tagbar_autofocus = 1
nnoremap <F1> <Cmd>TagbarOpen<CR>
packadd tagbar-master

###############################################################################
# plugin dirvish
call dirvish#add_icon_fn((p) => isdirectory(p) ? '📂' : '📄')

augroup GroupDirvish
  autocmd!
  # Map `t` to open in new tab.
  autocmd FileType dirvish nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  autocmd FileType dirvish xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  # Map `gr` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish<CR>
  # Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
  autocmd FileType dirvish nnoremap <silent><buffer> gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>
augroup END

###############################################################################
# Visual stuff
# set guifont=Cascadia\ Code:h11 linespace=2
# set guifont=JuliaMono:h11 linespace=3
# set guifont=Courier\ Prime:h12 linespace=2
# set guifont=Fantasque\ Sans\ Mono:h12 linespace=4
set guifont=Rec_Mono_Duotone:h12:cANSI:qDRAFT linespace=2
set columns=110

BlinkyStick
#BlinkyOn

augroup GroupUser
  autocmd!
  autocmd GuiEnter * set renderoptions=
  autocmd VimEnter * execute "colorscheme" ( (&term == "builtin_gui") ? "two_tone" : "two_tone_dark" )
augroup END
nnoremap <Leader>n <Cmd>drop $OneDriveCommercial/Dokumente/Notes/notes.rst<CR>

###############################################################################
# EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

###############################################################################
# NETRW variables
g:netrw_use_errorwindow = 0
g:netrw_wiw = 1
g:netrw_banner = 0
g:netrw_browse_split = 0
g:netrw_altv = 1
g:netrw_cursor = 3
g:netrw_list_hide = '.*\.swp$'


