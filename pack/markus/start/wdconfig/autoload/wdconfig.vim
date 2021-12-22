" Vim auoload file

function! wdconfig#Read(key)
  if !exists("g:rc")
    return
  endif
  if g:rc->has_key(a:key)
    for v in g:rc[a:key]
      echo ":execute" v
      execute v
    endfor
  else
    echomsg "no commands for '".a:key."'"
  endif
endfunction

