vim9script

var do_auto_popup = true
g:scope_once = false

augroup GroupScope
  au!
  if do_auto_popup == true
    # add supported filetypes
    au CursorHold *.vim call scope#PopupScope()
    au CursorHold *.c,*.h call scope#PopupScope()
    au CursorHold *.py call scope#PopupScope()
    au CursorHold *.markdown,*.md,*.txt call scope#PopupScope()
  else
    # add supported filetypes
    au BufEnter *.vim      nnoremap <buffer> <LocalLeader>s <Cmd>call scope#PopupScope()<CR>
    au BufEnter *.c,*.h    nnoremap <buffer> <LocalLeader>s <Cmd>call scope#PopupScope()<CR>
    au BufEnter *.py       nnoremap <buffer> <LocalLeader>s <Cmd>call scope#PopupScope()<CR>
    au BufEnter *.markdown nnoremap <buffer> <LocalLeader>s <Cmd>call scope#PopupScope()<CR>
    au BufEnter *.md,*.txt nnoremap <buffer> <LocalLeader>s <Cmd>call scope#PopupScope()<CR>
  endif
augroup END
