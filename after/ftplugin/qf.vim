" Vim ftplugin file

if !exists("*s:QuickfixCleanup")
  function! s:QuickfixCleanup ()
    "prepare cleanup
    setlocal modifiable
    let b:save_search = @/

    " get rid of Ctrl-M
    :silent %s/\r//e

    " cleanup
    setlocal nomodified nomodifiable
    let @/ =b:save_search
    unlet b:save_search
    call histdel("search", -1)

    " shorten the Quickfix title.
    if exists("w:quickfix_title")
      if len(w:quickfix_title) > 50
        let w:quickfix_title = w:quickfix_title[:60] . "..."
      endif
    endif
  endfunction
endif

call s:QuickfixCleanup()

if exists("b:did_ftplugin_after")
  finish
endif

let b:undo_ftplugin = b:undo_ftplugin
      \ . " | setlocal foldenable< number< relativenumber<"

" save window space
setlocal nofoldenable
setlocal nonumber
setlocal norelativenumber

nnoremap <buffer> j :cnext<CR>zz<C-w>p
nnoremap <buffer> k :cprev<CR>zz<C-w>p

let b:did_ftplugin_after = 1
