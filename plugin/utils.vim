vim9script

g:one_line_popup_winlist  = []

def g:OneLinePopupCB(timer: number, winid: number)
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
def g:OneLinePopup(text: string, t = 2000, hl = 'User2')
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

# Toggle the quickfix window
def g:ToggleQuickfix()
  var is_open = false
  for m in getbufinfo()
    if getbufvar(m.bufnr, "&buftype") == "quickfix" && len(m.windows) > 0
      is_open = true
      break
    endif
  endfor
  if is_open == false
    var num_qf_lines = len(getqflist())
    if num_qf_lines > 0
      execute "botright" "copen" min([ &lines / 3, num_qf_lines])
      wincmd p
    else
      echomsg "- Quickfix empty -"
    endif
  else
    if (winnr("$") == 1) && (&buftype == "quickfix")
      buffer #
    else
      cclose
      wincmd p
    endif
  endif
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

def g:BackwardSlashToForward()
  s#\\#/#g
  call histdel("/", -1)
enddef

def g:ForwardSlashToBackward()
  s#/#\\#g
  call histdel("/", -1)
enddef

nnoremap <Leader>/ :call ForwardSlashToBackward()<CR>
nnoremap <Leader>\ :call BackwardSlashToForward()<CR>
nnoremap <Leader>? <Cmd>call PopupFiletypeHelp()<CR>
nnoremap <Leader><Leader> <Cmd>call ToggleQuickfix()<CR>


defcompile
