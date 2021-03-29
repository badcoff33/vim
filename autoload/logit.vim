
function logit#AddNewEntry()
  let hit = search(strftime("%Y-%m-%d"), "bec")
  if hit > 0
    call append(hit, '  - ')
  else
    call append(hit, strftime("%A, %Y-%m-%d"))
    call append(hit+1, '  - ')
  endif
  execute 'normal' hit..'Gj$'
endfunction
