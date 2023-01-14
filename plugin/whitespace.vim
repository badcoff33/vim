" Vim plugin file
"
" Description: very basic functions called from init.vim as autoload functions
" to save startup time.

" Interfaces:
noremap <unique> <script> <Plug>WhitespaceMelt <SID>WhitespaceMelt

noremap <SID>WhitespaceMelt <cmd>call whitespace#WhitespaceMelt()<CR>

" Defaults: Key mappings
if !hasmapto('<Plug>WhitespaceMelt')
  nmap <A-Space> <Plug>WhitespaceMelt
endif

command -nargs=0 WhitespaceCleanup call whitespace#WhitespaceCleanup()

augroup whitespace
  autocmd!
  autocmd BufWritePre *.cc,*.hh :WhitespaceCleanup
  autocmd BufWritePre *.c,*.h   :WhitespaceCleanup
  autocmd BufWritePre *.py      :WhitespaceCleanup
  autocmd BufWritePre *.vim     :WhitespaceCleanup
  autocmd BufWritePre vimrc     :WhitespaceCleanup
  autocmd BufWritePre gvimrc    :WhitespaceCleanup
augroup END

