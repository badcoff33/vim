vim9script

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
        border: [1, 1, 1, 1],
        padding: [0, 1, 0, 1],
        drag: true,
        close: "click"
    })
    setbufvar(b, "&modified", false)
enddef

nnoremap <Leader>? <Cmd>call PopupFiletypeHelp()<CR>
nnoremap <Leader><Leader> <Cmd>call ToggleQuickfix()<CR>

def BackwardSlashToForward()
  s#\\#/#g
  call histdel("/", -1)
enddef

def ForwardSlashToBackward()
  s#/#\\#g
  call histdel("/", -1)
enddef

nnoremap <Leader>/ :call ForwardSlashToBackward()<CR>
nnoremap <Leader>\ :call BackwardSlashToForward()<CR>

defcompile
