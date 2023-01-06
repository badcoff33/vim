vim9script

def g:PopupTerminal()
    var buf = term_start(['cmd'], {hidden: 1, term_finish: 'close'})
    var winopts = {
        minwidth: &columns - 10,
        minheight: 10,
        maxheight: &lines - 10,
        border: [1, 1, 1, 1],
        padding: [1, 1, 1, 1]
    }
    g:popup_terminal_winid = popup_create(buf, winopts)
    set wincolor=Terminal
    autocmd VimResized <buffer> popup_move(g:popup_terminal_winid, winopts)
enddef

nnoremap <F5> <cmd>call PopupTerminal()<CR>
imap     <F5> <Esc><F5>

