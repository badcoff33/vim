" Vim auoload file

function! dircfg#Read(key)
  if !exists("g:dircfg")
    return
  endif
  if g:dircfg->has_key(a:key)
    let winid = lib#popup#bottom_left(g:dircfg[a:key])
    call setwinvar(winid, "&wrap", 0)
    for v in g:dircfg[a:key]
      execute v
    endfor
  else
    echomsg "no commands for '".a:key."'"
  endif
endfunction

