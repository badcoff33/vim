" Vim autoload file -- Manage open/close windows

function! lib#windows#CloseTermWindows()
  for b in term_list()
    if term_getstatus(b) == 'finished'
      execute 'bdelete' b
    endif
  endfor
endfunction

function! lib#windows#PopupBuffer(buf)
  if bufexists(a:buf)
    let visible_win = bufwinnr(a:buf) 
    if visible_win >= 0
      call win_gotoid(visible_win)
    else
      execute "buffer" a:buf
    endif 
  endif
endfunction 

function! lib#windows#HideBuffer(buf)
  if bufexists(a:buf)
    let visible_win = bufwinnr(a:buf)
    if visible_win >= 0
      call win_gotoid(visible_win)
      buffer #
    endif
  endif
endfunction

