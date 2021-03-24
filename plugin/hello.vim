
noremap <unique> <script> <Plug>SayHello <SID>SayHello
noremap <SID>SayHello :silent call hello#SayHello()<CR>

if !hasmapto('<Plug>SayHello')
  nmap <Leader>h <Plug>SayHello
endif

augroup hello
  autocmd!
  autocmd ColorScheme * :call hello#SetProps()
augroup END

