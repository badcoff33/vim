" Vim plugin file
"
" Description: very basic functions called from init.vim as autoload functions
" to save startup time.

" <Plug> Interface
noremap <unique> <script> <Plug>WhitespaceMelt <SID>WhitespaceMelt

" Translate SID to Vim command
noremap <SID>WhitespaceMelt :call whitespace#Melt()<CR>

" Defaults: Key mappings
if !hasmapto('<Plug>WhitespaceMelt')
  nmap <C-A-BS> <Plug>WhitespaceMelt
  imap <C-A-BS> <Esc>l<C-A-BS>i
endif

command -nargs=0 WhitespaceCleanup call whitespace#Cleanup()

augroup GroupWhitespaceP
  autocmd!
  autocmd BufWritePre *.cc,*.hh :WhitespaceCleanup
  autocmd BufWritePre *.c,*.h   :WhitespaceCleanup
  autocmd BufWritePre *.py      :WhitespaceCleanup
  autocmd BufWritePre *.vim     :WhitespaceCleanup
  autocmd BufWritePre vimrc     :WhitespaceCleanup
  autocmd BufWritePre gvimrc    :WhitespaceCleanup
  autocmd BufWritePre CMakeLists.txt,*.cmake :WhitespaceCleanup
augroup END

