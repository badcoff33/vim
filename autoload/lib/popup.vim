"g:popup_close_win_time = get(g:, 'popup_close_win_time', 1000)
"
"export def TopLeft(text: string)
"  puopt =
"  {
"      pos: "topleft",
"      line: 1,
"      col: 1,
"      time: g:popup_close_win_time,
"      tabpage: -1,
"      highlight: 'PmenuSel',
"      padding: [1,1,1,1],
"      maxwidth: (&columns * 2) / 3,
"      }
"      return popup_create( text, puopt)
"    enddef

function! lib#popup#top_right(text)
  return popup_create(a:text, #{
        \ pos: "topright",
        \ line: 1,
        \ col: &columns,
        \ time: g:popup_close_win_time,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [0,1,0,1],
        \ maxwidth: (&columns * 2) / 3
        \ })
endfunction

function! lib#popup#bottom_right(text)
  return popup_create(a:text, #{
        \ pos: "botright",
        \ line: &lines - 2,
        \ col: &columns,
        \ time: g:popup_close_win_time,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [0,1,0,1],
        \ maxwidth: (&columns * 2) / 3
        \ })
endfunction

function! lib#popup#bottom_left(text)
  return popup_create(a:text, #{
        \ pos: "botleft",
        \ line: &lines - 2,
        \ col: 2,
        \ time: g:popup_close_win_time,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [1,1,1,1],
        \ maxwidth: (&columns * 2) / 3
        \ })
endfunction

function! lib#popup#over_statusline(text)
  if type(a:text) == v:t_list
    let text = a:text[0]
  elseif type(a:text) == v:t_string
    let text = a:text
  else
    return 0
  endif
  return popup_create(text, #{
        \ pos: "botleft",
        \ line: &lines - 2,
        \ col: 1,
        \ time: (2*g:popup_close_win_time)/3,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [0,0,0,0],
        \ minwidth: &columns
        \ })
endfunction
