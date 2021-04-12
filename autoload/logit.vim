call prop_type_delete('LogItDate')
call prop_type_add('LogItDate', {'highlight': 'Comment'})

function! logit#HighlightDates()
  let l:savedView = winsaveview()
  normal gg
  while v:true
    let l = search('^\w\+,\s\d\+-\d\+-\d\+', 'Wce')
    if l == 0
      break
    endif
    call prop_add(l, 1, {'end_col': len(getline(l))+1, 'type': 'LogItDate'})
    normal j
  endwhile
  call winrestview(l:savedView)
endfunction

function! logit#AddNewEntry()
  let hit = search(strftime("%Y-%m-%d"), "bec")
  if hit > 0
    call feedkeys('o    ')
    "normal o    -
  else
    call append(0, strftime("%A, %Y-%m-%d"))
    normal gg
    call feedkeys('o    ')
  endif
endfunction
