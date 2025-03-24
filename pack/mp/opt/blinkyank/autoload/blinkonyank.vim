function! blinkonyank#On(dict)
  let duration = (type(a:dict) == v:t_dict) && (has_key(a:dict, "duration")) ? a:dict["duration"] : 1000
  let a = getpos("'[")
  let b = getpos("']")
  if v:event['visual'] == v:true
    return
  endif
  if v:event['operator'] == 'y'
    " we want this only for yank operations
    if b[2] == 0x7fffffff
      let sp = len(getline(b[1]))
    else
      let sp = b[2]
    endif
    let s:save_hlsearch = &hlsearch
    let s:save_cursorline = &cursorline
    set nohlsearch
    setlocal nocursorline
    call prop_add_list(#{bufnr: bufnr("%"), id: 1, type: 'text_prop_yank'}, [[a[1], a[2], b[1], sp + 1]])
    call timer_start(duration, "blinkonyank#Off", {'repeat': 1})
  endif
endfunction

function! blinkonyank#Off(tid)
  let &hlsearch = s:save_hlsearch
  let &cursorline = s:save_cursorline
  call prop_clear(1, line("$"))
endfunction

" avoid error 2nd from prop_type_add by delete it first
call prop_type_delete('text_prop_yank')
call prop_type_add('text_prop_yank', #{ highlight: 'Visual' })
