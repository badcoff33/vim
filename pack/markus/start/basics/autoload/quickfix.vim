
function! quickfix#ToggleQuickfix()
  let save_win = win_getid()
  let qfIsOpen = 0
  windo if &buftype == 'quickfix' | let qfIsOpen = 1 | endif
  if qfIsOpen == 0
    let max_lines = (40 * getwininfo(bufwinid('%'))['variables']['height'] ) / 100
    if len(getqflist()) == 0
      echomsg "quickfix list empty"
      cclose
    elseif len(getqflist()) <= max_lines
      execute "botright copen"  len(getqflist())
      normal G
    else
      execute "botright copen"  max_lines
      normal G
    endif
  else
    cclose
  endif
  if win_gotoid(save_win) == 0
    wincmd p
  endif
endfunction

