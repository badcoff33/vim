" Vim autoload file -- Manage open/close windows

function! lib#windows#CloseTermWindows()
  for b in term_list()
    if term_getstatus(b) == 'finished'
      execute 'bdelete' b
    endif
  endfor
endfunction

function! lib#windows#PopupBuffer(buf)
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

function! lib#windows#GotoBuffer(buf)
  if bufexists(a:buf)
    let buf_winid = bufwinid(a:buf)
    if buf_winid >= 0
      call win_gotoid(buf_winid)
    else
      execute "buffer" a:buf
    endif
  endif
endfunction

function! lib#windows#HideBuffer(buf)
  let save_winr = winnr()
  if bufexists(a:buf)
    let buf_winid = bufwinid(a:buf)
    if buf_winid >= 0
      call win_gotoid(buf_winid)
      buffer #
    endif
  endif
  execute save_winr .. "wincmd w"
endfunction

