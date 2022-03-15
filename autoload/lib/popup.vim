function! lib#popup#bottom_right(text)
  if type(a:text) == v:t_list
    let w = 0
    for e in a:text
      let w = max([w, e])
    endfor
    return popup_create(a:text, #{
          \ line: &lines,
          \ col: &columns - w,
          \ time: 2500,
          \ tabpage: -1,
          \ highlight: 'PmenuSel',
          \ padding: [1,1,1,1],
          \ })
  endif
endfunction

