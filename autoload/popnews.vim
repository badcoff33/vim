vim9script
# autoload file

g:popnews_winlist  = []
g:popnews_bottom_left = true

export def Test_olp()
  Open("1", {t: 5000})
  Open("22", {t: 13000})
  Open("333", {t: 15000, hl: "Search"})
  Open("4444", {t: 12000})
enddef

def g:PopnewsAdjustColors()
  if !hlexists("PopupNotification")
    highlight! link PopupNotification Pmenu
  endif
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
    popup_this_line = popup_getpos(w)['line']
    if popup_this_line < popup_del_line
      popup_move(w, {
        line: popup_this_line + 1,
        pos: g:popnews_bottom_left ? "botleft" : "botright",
        col: g:popnews_bottom_left ? 2 : &columns
      })
    endif
  endfor
enddef

# text of type string is the thing to show in popup
# returns the window id of the created popup
export def Open(text: string, param_in: dict<any> = {t: 3000, hl: 'PopupNotification'}): number
  var IsPermanent = (): bool =>  (has_key(param_in, 'permanent') && param_in.permanent) ? true : false
  var popup_line: number
  var winid: number
  var param_merged: dict<any>
  doautocmd ColorScheme *
  for [key, value] in items({
      permanent: false,
      t: 3000,
      hl: 'PopupNotification'
      })
    if has_key(param_in, key)
      param_merged[key] = param_in[key]
    else
      param_merged[key] = value
    endif
  endfor

  var popup_opts = {
    pos: g:popnews_bottom_left ? "botleft" : "botright",
    col: g:popnews_bottom_left ? 1 : &columns,
    line: &lines - 2,
    padding: [0, 2, 0, 2],
    minwidth: len(text),
    highlight: param_merged.hl,
    tabpage: -1
  }

  if IsPermanent()
  else
    popup_opts['time'] = param_merged.t
    popup_opts['callback'] = g:NewsCB
  endif

  for w in g:popnews_winlist
    popup_line = popup_getpos(w)['line']
    popup_move(w, {line: popup_line - 1})
  endfor

  winid = popup_create(text, popup_opts)
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

augroup GroupNews
    autocmd!
    autocmd ColorScheme * call PopnewsAdjustColors()
augroup END

# uncomment when debugging
defcompile

