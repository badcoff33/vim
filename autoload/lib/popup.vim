function! lib#popup#top_left(text)
  return popup_create(a:text, #{
        \ pos: "topleft",
        \ line: 1,
        \ col: 1,
        \ time: 2500,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [1,1,1,1],
        \ maxwidth: (&columns * 2) / 3
        \ })
endfunction

function! lib#popup#top_right(text)
  return popup_create(a:text, #{
        \ pos: "topright",
        \ line: 1,
        \ col: &columns,
        \ time: 2500,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [1,1,1,1],
        \ maxwidth: (&columns * 2) / 3
        \ })
endfunction

function! lib#popup#bottom_right(text)
  return popup_create(a:text, #{
        \ pos: "botright",
        \ line: &lines - 2,
        \ col: &columns,
        \ time: 2500,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [1,1,1,1],
        \ maxwidth: (&columns * 2) / 3
        \ })
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

