vim9script
# autoload file

g:popnews_winlist  = []
g:popnews_bottom_left = true

export def Test_olp()
  Open("1", {t: 5000})
  Open("22", {t: 13000})
  Open("333", {t: 15000, hl: "Search"})
  Open("4444", {t: 12000})
  Open("key?", {close_on_key: true})
enddef

def CleanupWinlist(winid: number)
  var i: number
  var popup_del_line: number # line of popup to be removed
  var popup_this_line: number

  i = index(g:popnews_winlist, winid)
  if i >= 0
    remove(g:popnews_winlist, i)
  endif

  popup_del_line = popup_getpos(winid)["line"]
  for w in g:popnews_winlist
    popup_this_line = popup_getpos(w)["line"]
    if popup_this_line < popup_del_line
      popup_move(w, {
        line: popup_this_line + 1,
        pos: g:popnews_bottom_left ? "botleft" : "botright",
        col: g:popnews_bottom_left ? 2 : &columns
      })
    endif
  endfor
enddef

var opt_default = {
  hl: 'PopupNotification',
  no_timeout: false,
  close_on_key: false,
  t: 3000
}

# text of type string is the thing to show in popup
# returns the window id of the created popup
export def Open(text: any, opt: dict<any> = opt_default): number
  var IsCloseOnTime = (): bool =>  (has_key(opt, 'no_timeout') && opt.no_timeout) ? false : true
  var IsCloseOnKey = (): bool =>  (has_key(opt, 'close_on_key') && opt.close_on_key) ? true : false
  var popup_line: number
  var popup_width: number
  var text_lines: number
  var winid: number
  var opt_m: dict<any>

  if !hlexists("PopupNotification")
    highlight! link PopupNotification Pmenu
  endif

  def FilterClose(w: number, key: string): number
    Close(w)
    return 1
  enddef

  if typename(text) == "string"
    popup_width = len(text)
    text_lines = 1
  else
    popup_width = &columns - 4
    text_lines = len(text)
  endif

  for [key, value] in items({
      hl: 'PopupNotification',
      no_timeout: false,
      close_on_key: false,
      t: 3000,
      })
    if has_key(opt, key)
      opt_m[key] = opt[key]
    else
      opt_m[key] = value
    endif
  endfor

  var popup_opt = {
    pos: g:popnews_bottom_left ? "botleft" : "botright",
    col: g:popnews_bottom_left ? 1 : &columns,
    line: &lines - 2,
    padding: [0, 2, 0, 2],
    minwidth: popup_width,
    highlight: opt_m.hl,
    tabpage: -1
  }

  if IsCloseOnKey()
    popup_opt['filter'] = FilterClose
  elseif IsCloseOnTime()
    popup_opt['time'] = opt_m.t
    popup_opt['callback'] = g:NewsCB
  endif

  for w in g:popnews_winlist
    popup_line = popup_getpos(w)['line']
    popup_move(w, {line: popup_line - text_lines})
  endfor

  winid = popup_create(text, popup_opt)
  add(g:popnews_winlist, winid)

  return winid
enddef

export def Close(winid: number)
  if index(popup_list(), winid) > -1 # does it exist?
    CleanupWinlist(winid)
    popup_close(winid)
  endif
enddef

def NewsCB(winid: number, result: number)
  CleanupWinlist(winid)
enddef

#Test_olp()
# uncomment when debugging
defcompile

