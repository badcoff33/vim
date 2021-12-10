" Vim autoload file -- Manage open/close windows

function! windows#PopupBuffer(buf)
  let save_winr = winnr()
  if bufexists(a:buf)
    let buf_winid = bufwinid(a:buf)
    if buf_winid >= 0
      call win_gotoid(buf_winid)
    else
      execute "buffer" a:buf
    endif
  endif
  execute save_winr .. "wincmd w"
endfunction

function! windows#GotoBuffer(buf)
  if bufexists(a:buf)
    let buf_winid = bufwinid(a:buf)
    if buf_winid >= 0
      call win_gotoid(buf_winid)
    else
      execute "buffer" a:buf
    endif
  endif
endfunction

function! windows#ToggleBuffer(buf)
  let save_winr = winnr()
  if bufexists(a:buf)
    let buf_winid = bufwinid(a:buf)
    if buf_winid >= 0
      call win_gotoid(buf_winid)
      buffer #
    else
      call windows#PopupBuffer(a:buf)
    endif
  endif
  execute save_winr .. "wincmd w"
endfunction

