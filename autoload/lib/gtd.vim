" autoload functions to support any get-things-done stuff

function! lib#gtd#ToggleTodo()
  let stop_at_line =  search('\(DONE\|TODO\)','nbW')
  if stop_at_line == 0
    return " nothing found
  endif
  let save_pos = winsaveview()
  if search('TODO','bsc', stop_at_line) > 0
    normal ceDONE
  elseif search('DONE','bsc', stop_at_line) > 0
    normal ceTODO
  endif
  call winrestview(save_pos)
endfunction


