" GUI startup script
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
  autocmd BufEnter * :set titlestring=Vim\ in\ %{getcwd()}
augroup END

set guioptions=!ca
set guicursor+=a:blinkon0
set renderoptions=
set mousemodel=popup
set nomousefocus
set foldcolumn=1

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

let F = {font -> escape(matchstr(&gfn,'^[A-Za-z_\ ]\+'), ' ')}
nnoremap <expr> <leader>4 ':set guifont='..F(&gfn)..':h12 linespace=1<CR>'
nnoremap <expr> <leader>3 ':set guifont='..F(&gfn)..':h11 linespace=1<CR>'
nnoremap <expr> <leader>2 ':set guifont='..F(&gfn)..':h10 linespace=1<CR>'
nnoremap <expr> <leader>1 ':set guifont='..F(&gfn)..':h9  linespace=1<CR>'

" vim:ft=vim
