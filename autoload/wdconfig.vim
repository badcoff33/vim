" Vim auoload file

function! wdconfig#Read(key)
  if !exists("g:wdconfig")
    return
  endif
  if g:wdconfig->has_key(a:key)
    for v in g:wdconfig[a:key]
      echo ":execute" v
      execute v
    endfor
  else
    echomsg "no commands for '".a:key."'"
  endif
endfunction

