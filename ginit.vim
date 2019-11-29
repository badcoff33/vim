" GUI startup script

syntax on

set title

" Save when Neovim's losing or gaining focus
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
  set guioptions=!gt
  set mousemodel=popup
  set nomousefocus
endif

" vim:ft=vim
