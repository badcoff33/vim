" Living with QWERTZ keyboards
set langmap=ö[,ä],Ö{,Ä},ü/,Ü?
" set wildoptions+=fuzzy

" """"""""""""""""
" Filetype rst
let g:rst_style = 0
augroup RstGroup
  au!
  " plugin table-mode, prepared for rst style tables
  au FileType rst :let b:table_mode_corner = '+'
  au FileType rst :let b:table_mode_corner_corner = '+'
  au FileType rst :let b:table_mode_header_fillchar = '='
augroup END

" """"""""""""""""
" TAGBAR
hi! link TagbarHighlight Pmenu
let g:tagbar_sort = 0
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
nnoremap <F1> <Cmd>TagbarOpen<CR>
packadd tagbar

" """"""""""""""""
" plugin dirvish
call dirvish#add_icon_fn({p -> isdirectory(p)?'📂':'📄'})

augroup GroupDirvish
  autocmd!
  " Map `t` to open in new tab.
  autocmd FileType dirvish nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  autocmd FileType dirvish xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  " Map `gr` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish<CR>
  " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
  autocmd FileType dirvish nnoremap <silent><buffer> gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>
augroup END

" """"""""""""""""
" Visual stuff
" set guifont=Cascadia\ Code:h11 linespace=2
" set guifont=JuliaMono:h11 linespace=3
" set guifont=Courier\ Prime:h12 linespace=2
" set guifont=Fantasque\ Sans\ Mono:h12 linespace=4
set guifont=Rec_Mono_Duotone:h12:cANSI:qDRAFT linespace=2
set columns=110

BlinkyStick
"BlinkyOn

augroup GroupUser
  autocmd!
  autocmd GuiEnter * set renderoptions=
  autocmd VimEnter * execute "colorscheme" ( (&term == "builtin_gui") ? "4x4" : "two_tone_dark" )
augroup END
nnoremap <Leader>n <Cmd>drop $OneDriveCommercial/Dokumente/Notes/notes.rst<CR>

" """"""""""""""""
" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" """"""""""""""""
" NETRW variables
let g:netrw_use_errorwindow = 0
let g:netrw_wiw = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_cursor = 3
let g:netrw_list_hide = '.*\.swp$'
