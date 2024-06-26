vim9script
# autoload file

g:news_winlist  = []
g:popnews_bottom_left = false

export def Test_olp()
  Open("1", 5000)
  Open("22", 13000)
  Open("333", 15000, "Search")
  Open("4444", 12000)
enddef

# text of type string is the thing to show in popup
# returns the window id of the created popup
export def Open(text: string, t: number = 3000, hl: string = 'PmenuSel'): number
  var ll: number
  var winid: number
  var winopts = {
    pos: g:popnews_bottom_left ? "botleft" : "botright",
    col: g:popnews_bottom_left ? 2 : &columns,
    line: &lines - 2,
    padding: [0, 2, 0, 8],
    minwidth: len(text),
    highlight: hl,
    tabpage: -1
  }
  if t > 0
    winopts['time'] = t
    winopts['callback'] = g:NewsCB
  endif
  for w in g:news_winlist
    ll = popup_getpos(w)['line']
    popup_move(w, {line: ll - 1})
  endfor
  winid = popup_create(text, winopts)
  add(g:news_winlist, winid)
  return winid
enddef

export def Resize()
  if !exists('g:news_winlist')
    return
  endif
  for w in g:news_winlist
    echo "1"
    popup_move(w, {
      pos: g:popnews_bottom_left ? "botleft" : "botright",
      col: g:popnews_bottom_left ? 2 : &columns,
      line: &lines - 2,
    })
  endfor
enddef

export def Close(winid: number)
  var i: number
  var l: number # line of popup to be removed
  var ll: number
  if index(popup_list(), winid) > -1 # does it exist?
    l = popup_getpos(winid)["line"]
    popup_close(winid)
    i = index(g:news_winlist, winid)
    remove(g:news_winlist, i)
    for w in g:news_winlist
      ll = popup_getpos(w)['line']
      if ll < l
        popup_move(w, {line: ll + 1})
      endif
    endfor
  endif
enddef

def NewsCB(winid: number, result: number)
  var i: number
  var l: number # line of popup to be removed
  var ll: number
  l = popup_getpos(winid)["line"]
  i = index(g:news_winlist, winid)
  remove(g:news_winlist, i)
  for w in g:news_winlist
    ll = popup_getpos(w)['line']
    if ll < l
      popup_move(w, {
        line: ll + 1,
        pos: g:popnews_bottom_left ? "botleft" : "botright",
        col: g:popnews_bottom_left ? 2 : &columns
      })
    endif
  endfor
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
defcompile
