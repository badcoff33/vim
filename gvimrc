" GUI startup script

syntax on
set title

" Save when Vim is losing or gaining focus
augroup ginit
  " clear group in case file sourced several times
  autocmd!
  " write all buffers when loosing focus
  autocmd FocusLost * :silent! wall
  " Reload changed buffers. Command rely on option 'autoread'
  autocmd FocusGained * :checktime
  " Option 'title' needs to be set for this
  autocmd BufEnter * :set titlestring=%t\ %{expand('%:h')}\ %{strftime('%c',getftime(expand('%')))}
augroup END

if has('gui')
  set guioptions=!ca
  set renderoptions=
  set mousemodel=popup
  set nomousefocus
  nnoremenu 1.300 PopUp.-SEP3- <NOP>
  nnoremenu 1.310 PopUp.Explore :silent Lexplore <C-r>=expand('%:p:h')<CR><CR>
  nnoremenu 1.320 PopUp.-SEP4- <NOP>
  nnoremenu 1.321 PopUp.Set\ font  :set guifont=*<CR>
  nnoremap <leader>3 :set guifont=Courier\ New:h12 linespace=2<CR>
  nnoremap <leader>2 :set guifont=Courier\ New:h11 linespace=2<CR>
  nnoremap <leader>1 :set guifont=Courier\ New:h10 linespace=2<CR>
  call feedkeys(mapleader.'3') " default font
  colorscheme breeze
  set guicursor+=a:blinkon0
elseif has("nvim")
  set mousemodel=popup
  if exists('g:GuiLoaded')
    GuiLinespace 3
    GuiTabline 0
    GuiPopupmenu 0
    nnoremap <leader>3 :GuiFont! Consolas:h13<CR>
    nnoremap <leader>2 :GuiFont! Consolas:h11<CR>
    nnoremap <leader>1 :GuiFont! Consolas:h10<CR>
    GuiLinespace 6
    call feedkeys(mapleader.'1') " default font
    colorscheme breeze
    set mouse=a
  endif
endif

" vim:ft=vim
