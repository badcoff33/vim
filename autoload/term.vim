
" Description: Go to first not finished term buffer in buffer list.
function! term#OpenTerm()
  for b in term_list()
    if getbufvar(b, 'home_term', 0) == 1
      call windows#GotoBuffer(b)
      return
    endif
  endfor
  botright terminal
  let b:home_term = 1
endfunction

function! term#CloseFinishedTerm()
  for b in term_list()
    if term_getstatus(b) == 'finished'
      execute 'bdelete' b
    endif
  endfor
endfunction

