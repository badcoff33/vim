vim9script

import autoload "scope.vim"

augroup GroupScope
  au!
  # add supported filetypes
  au CursorHold *.vim call scope#PopupScope()
  au CursorHold *.c,*.h call scope#PopupScope()
  au CursorHold *.py call scope#PopupScope()
  au CursorHold *.markdown,*.md,*.txt call scope#PopupScope()
  # add supported filetypes
  au BufEnter *.vim nnoremap <buffer> <LocalLeader>? <Cmd>call scope#PopupScope(v:true)<CR>
  au BufEnter *.c,*.h nnoremap <buffer> <LocalLeader>? <Cmd>call scope#PopupScope(v:true)<CR>
  au BufEnter *.py nnoremap <buffer> <LocalLeader>? <Cmd>call scope#PopupScope(v:true)<CR>
  au BufEnter *.bat,*.cmd nnoremap <buffer> <LocalLeader>? <Cmd>call scope#PopupScope(v:true)<CR>
  au BufEnter *.markdown nnoremap <buffer> <LocalLeader>? <Cmd>call scope#PopupScope(v:true)<CR>
  au BufEnter *.md,*.txt nnoremap <buffer> <LocalLeader>? <Cmd>call scope#PopupScope(v:true)<CR>
augroup END
