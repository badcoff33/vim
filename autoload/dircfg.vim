" Vim auoload file

function! dircfg#Read(key)
  if !exists("g:dircfg")
    return
  endif
  if g:dircfg->has_key(a:key)
    let w = 0
    for e in g:dircfg[a:key]
      let w = max([w, e])
    endfor
    let winid = popup_create(g:dircfg[a:key], #{
          \ line: &lines,
          \ col: &columns - w,
          \ time: 2500,
          \ tabpage: -1,
          \ highlight: 'PmenuSel',
          \ padding: [1,1,1,1],
          \ })
    call setwinvar(winid, "&wrap", 0)
    for v in g:dircfg[a:key]
      execute v
    endfor
  else
    echomsg "no commands for '".a:key."'"
  endif
endfunction

