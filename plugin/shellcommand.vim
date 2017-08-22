" Vim plugin file
"
" Description:  Execute a shell commands and cature the output stream in a
" buffer. Uses plugin 'fileset' to operate on a set of files.

if !has("win32") && !has("win64")
  finish
endif

" New commands for plugin shellcommand
command! -complete=file -nargs=+ SCRun call shellcommand#Run([<f-args>])
command! -nargs=0 SCBuffer      call shellcommand#ShowBuffer()

if empty(mapcheck("<Leader>x"))
  nnoremap <Leader>x :silent execute "!start explorer " . expand ("%:p:h")<CR>
endif

if empty(mapcheck("<Leader>X"))
  nnoremap <Leader>X :silent !start powershell -ExecutionPolicy Bypass<CR>
endif
