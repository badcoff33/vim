vim9script
# autoload file

g:one_line_popup_winlist  = []

def OneLinePopupCB(timer: number, winid: number)
  var i: number
  var l: number
  index(g:one_line_popup_winlist, winid)
  remove(g:one_line_popup_winlist, i)
  for w in g:one_line_popup_winlist
    l = popup_getpos(w)['line'] + 1
    popup_move(w, {line: l})
  endfor
enddef

# text of type string is the thing to show in popup
export def OneLinePopup(text: string, t = 2000, hl = 'User2')
  var winid: number
  winid = popup_create(text, {
    time: t,
    callback: g:OneLinePopupCB,
    col: 1,
    line: &lines - 2 - len(g:one_line_popup_winlist),
    padding: [0, 1, 0, 1],
    minwidth: &columns,
    highlight: hl
  })
  add(g:one_line_popup_winlist, winid)
enddef

def g:PopupFiletypeHelp()
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
    col: winwidth(0) + rel_col - 1,
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
