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
        var qf = getqflist()
        execute "botright" "copen" min([ &lines / 3, max([ 1, len(qf) ]) ])
        wincmd p
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
            appendbufline(b, "$", printf("%s   -->   %s %s\n", m.lhs, m.mode, m.rhs))
        endif
    endfor
    var rel_row = win_screenpos(win_getid())[0]
    var rel_col = win_screenpos(win_getid())[1]
    popup_create(b, {
        pos: "botright",
        title: "BUFFER MAPPINGS",
        line: winheight(0) + rel_row,
        col: winwidth(0) + rel_col,
        highlight: 'Pmenu',
        maxwidth: 40,
        maxheight: 20,
        wrap: 0,
        time: 5500,
        padding: [1, 1, 1, 1],
    })
enddef

nnoremap <Leader>? <Cmd>call PopupFiletypeHelp()<CR>
nnoremap <Leader>q <cmd>call ToggleQuickfix()<CR>

defcompile
