" Living with QWERTZ keyboards
" set langmap=ö[,ä],Ö{,Ä},ü/,Ü?
set langmap=ö[,ä],Ö{,Ä}
" set wildoptions+=fuzzy

nnoremap ü aü
inoremap ü <Esc>

inoremap jj <Esc>
inoremap <S-Space> :

inoremap <C-Del> <C-o>de
inoremap <C-BS> <C-o>db

nnoremap <PageUp> :bnext<CR>
nnoremap <PageDown> :bprevious<CR>

nnoremap gj g<C-]>

nnoremap <Leader>n <Cmd>drop $OneDriveCommercial/Dokumente/Notes/notes.markdown<CR>

packadd vcs

" Customs: Visual stuff
" set guifont=Cascadia\ Code:h11 linespace=2
" set guifont=JuliaMono:h11 linespace=3
" set guifont=Courier\ Prime:h12 linespace=2
" set guifont=Fantasque\ Sans\ Mono:h12 linespace=4
set guifont=Rec_Mono_Casual:h11:cANSI:qDRAFT linespace=2

BlinkyOn

augroup GroupUser
  autocmd!
  autocmd GuiEnter * set renderoptions=
  autocmd VimEnter * execute "colorscheme"
        \ (&term == "builtin_gui") ? "two_tone" : "sparks"
  autocmd BufEnter *.c,*.h setlocal scrolloff=10
augroup END

" Plugin: dirvish

augroup GroupDirvish
  autocmd!
  " autocmd SourcePre "dirvish.vim" call dirvish#add_icon_fn({p -> isdirectory(p)?'📂':'📄'})
  " Map `t` to open in new tab.
  autocmd FileType dirvish nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  autocmd FileType dirvish xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  " Map `gr` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish<CR>
  " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
  autocmd FileType dirvish nnoremap <silent><buffer> gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>
augroup END

" Plugin: Signify

nnoremap <Leader>Sd :SignifyHunkDiff<CR>
nnoremap <Leader>SD :SignifyDiff<CR>
nnoremap <Leader>St :SignifyToggle<CR>

" """"""""""""""""
" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" """"""""""""""""
" NETRW variables
let g:netrw_use_errorwindow = 0
let g:netrw_wiw = 1
let g:netrw_banner = 0
let g:netrw_bannerbackslash = 0
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_cursor = 3
let g:netrw_list_hide = '.*\.swp$'
