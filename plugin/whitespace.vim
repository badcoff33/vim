" Vim plugin file
"
" Description: Plugin provides functions to delete unwanted whitespaces.  It
" works on keypress (check out mapping to function whitespace#Melt()) and on a
" autocommand (calls whitespace#Cleanup()).

command! -nargs=0 WhitespaceCleanup :call whitespace#Cleanup()
command! -nargs=0 WhitespaceMelt    :call whitespace#Melt()

augroup Whitespace
  autocmd!
  autocmd BufWritePre * :WhitespaceCleanup
augroup END

if empty(mapcheck("<Leader>o"))
  nnoremap <Leader>o o<Esc>k
endif

if empty(mapcheck("<Leader>O"))
  nnoremap <Leader>O O<Esc>j
endif

if empty(mapcheck("<C-Space>"))
  nnoremap <C-Space> :WhitespaceMelt<CR>
endif

