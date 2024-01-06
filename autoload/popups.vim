vim9script
# autoload file

g:one_line_popup_winlist  = []

# export def Test_olp()
#   OneLinePopup("1", 5000)
#   OneLinePopup("22", 13000)
#   OneLinePopup("333", 15000, "Search")
#   OneLinePopup("4444", 12000)
# enddef

def OneLinePopupCB(winid: number, result: number)
  var i: number
  var l: number # line of popup to be removed
  var ll: number
  l = popup_getpos(winid)["line"]
  i = index(g:one_line_popup_winlist, winid)
  remove(g:one_line_popup_winlist, i)
  for w in g:one_line_popup_winlist
    ll = popup_getpos(w)['line']
    if ll < l
      popup_move(w, {line: ll + 1})
    endif
  endfor
enddef

# text of type string is the thing to show in popup
# returns the window id of the created popup
export def OneLinePopup(text: string, t: number = 3000, hl: string = 'User2')
  var winid: number
  winid = popup_create(text, {
    time: t,
    callback: g:OneLinePopupCB,
    col: 1,
    line: &lines - 2 - len(g:one_line_popup_winlist),
    padding: [0, 2, 0, 2],
    minwidth: len(text),
    highlight: hl
  })
  add(g:one_line_popup_winlist, winid)
  return winid
enddef

export def PopupFiletypeHelp()
  if bufexists("BUF-MAP")
    noautocmd bwipeout! BUF-MAP
  endif
  var b = bufadd("BUF-MAP")
  bufload(b)
  for m in maplist()
    if m.buffer > 0
      appendbufline(b, "$", printf("%s %s\t%s\n", m.mode, m.lhs, m.rhs))
    endif
  endfor
  deletebufline(b, 1) # delete first line (always blank)
  var rel_row = win_screenpos(win_getid())[0]
  var rel_col = win_screenpos(win_getid())[1]
  popup_create(b, {
    pos: "botright",
    title: "BUFFER MAPPINGS",
    line: winheight(0) + rel_row,
    col: winwidth(0) + rel_col - 2,
    highlight: 'Pmenu',
    maxwidth: 40,
    maxheight: 20,
    wrap: 0,
    moved: "any",
    padding: [0, 1, 0, 1],
    drag: true,
    close: "click"
  })
  setbufvar(b, "&modified", false)
enddef

# uncomment when debugging
#defcompile
