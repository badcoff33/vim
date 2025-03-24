vim9script
# autoload file

# Toggle the quickfix window
export def ToggleQuickfix()
  var winid = 0
  for m in getbufinfo()
    if getbufvar(m.bufnr, "&buftype") == "quickfix" && len(m.windows) > 0
      winid = m.windows[0]
      break
    endif
  endfor
  if winid == 0
    var num_qf_lines = len(getqflist())
    if num_qf_lines > 0
      execute "botright" "copen" min([ &lines / 2, num_qf_lines + 1])
      # wincmd p
    else
      echomsg "- Quickfix empty -"
    endif
  else
    var save_winid = win_getid()
    winid = win_gotoid(winid)
    cclose
    win_gotoid(save_winid)
  endif
enddef

#defcompile
