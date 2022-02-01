" Vim auoload file

function! dircfg#Read(key)
  if !exists("g:dircfg")
    return
  endif
  if g:dircfg->has_key(a:key)
    for v in g:dircfg[a:key]
      echo ":execute" v
      execute v
    endfor
  else
    echomsg "no commands for '".a:key."'"
  endif
endfunction

