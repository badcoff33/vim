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
  set encoding=latin1
  set renderoptions=
  set mousemodel=popup
  nnoremenu 1.300 PopUp.-SEP3- <NOP>
  nnoremenu 1.310 PopUp.GUI\ Font  :set guifont=*<CR>
elseif has("nvim")
  " Hello Neovim!
  set mousemodel=popup
  if exists('g:GuiLoaded')
    if g:GuiLoaded == 1
      GuiLinespace 3
      GuiTabline 0
      GuiPopupmenu 0
    endif
  endif
endif
" vim:ft=vim
