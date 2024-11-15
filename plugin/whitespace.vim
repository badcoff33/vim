" Vim plugin file
"
" Description: very basic functions called from init.vim as autoload functions
" to save startup time.

" <Plug> Interface
noremap <unique> <script> <Plug>WhitespaceMelt <SID>WhitespaceMelt

" Translate SID to Vim command
noremap <SID>WhitespaceMelt :call whitespace#WhitespaceMelt()<CR>

" Defaults: Key mappings
if !hasmapto('<Plug>WhitespaceMelt')
  nmap <C-A-BS> <Plug>WhitespaceMelt
  imap <C-A-BS> <Esc><C-A-BS>i
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

