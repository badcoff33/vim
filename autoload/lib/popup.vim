function! lib#popup#bottom_right(text)
  if type(a:text) == v:t_list
    let w = 0
    for e in a:text
      let w = max([w, e])
    endfor
    return popup_create(a:text, #{
          \ pos: "botright",
          \ line: &lines - 2,
          \ col: &columns,
          \ time: 2500,
          \ tabpage: -1,
          \ highlight: 'PmenuSel',
          \ padding: [1,1,1,1]
          \ })
  endif
endfunction

function! lib#popup#bottom_left(text)
  return popup_create(a:text, #{
        \ pos: "botleft",
        \ line: &lines - 2,
        \ col: 1,
        \ time: 2500,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [1,1,1,1],
        \ maxwidth: (&columns * 2) / 3
        \ })
endfunction

