vim9script
# autoload file

# Toggle the quickfix window
export def ToggleQuickfix()
  var is_open = false
  for m in getbufinfo()
    if getbufvar(m.bufnr, "&buftype") == "quickfix" && len(m.windows) > 0
      is_open = true
      break
    endif
  endfor
  if is_open == false
    var num_qf_lines = len(getqflist())
    if num_qf_lines > 0
      execute "botright" "copen" min([ &lines / 2, num_qf_lines + 1])
      wincmd p
    else
      echomsg "- Quickfix empty -"
    endif
  else
    if (winnr("$") == 1) && (&buftype == "quickfix")
      buffer #
    else
      cclose
      wincmd p
    endif
  endif
enddef

#defcompile
