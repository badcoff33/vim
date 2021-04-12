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

set guioptions=!ca
set guicursor+=a:blinkon0
set renderoptions=
set mousemodel=popup
set nomousefocus

nnoremenu 1.300 PopUp.-SEP3- <NOP>
nnoremenu 1.310 PopUp.Explore :silent Lexplore <C-r>=expand('%:p:h')<CR><CR>
nnoremenu 1.320 PopUp.-SEP4- <NOP>
nnoremenu 1.321 PopUp.Set\ font  :set guifont=*<CR>

nnoremap <leader>3 :set guifont=<C-r>=matchstr(&gfn,'^\w\+')<CR>:h12 linespace=1<CR>
nnoremap <leader>2 :set guifont=<C-r>=matchstr(&gfn,'^\w\+')<CR>:h10 linespace=1<CR>
nnoremap <leader>1 :set guifont=<C-r>=matchstr(&gfn,'^\w\+')<CR>:h9 linespace=1<CR>

" vim:ft=vim
