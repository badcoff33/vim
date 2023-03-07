vim9script

def g:OpenTermHere()
    var save_cwd = getcwd()

    execute "cd" expand("%:h")
    terminal
    wincmd J
    startinsert
    execute "cd" save_cwd
enddef

def g:PopupTermHere()
    var buf = term_start(['cmd'], {
        hidden: 1,
        term_finish: 'close',
        cwd: expand("%:h") == "" ? "." : expand("%:h")
    })
    var winopts = {
        minwidth: &columns - 10,
        minheight: 10,
        maxheight: &lines - 10,
        border: [0, 0, 0, 0],
        padding: [1, 1, 1, 1],
        title: "cmd"
    }
    g:popup_terminal_winid = popup_create(buf, winopts)
    set wincolor=Terminal
    autocmd VimResized <buffer> popup_move(g:popup_terminal_winid, winopts)
enddef

command! -nargs=0 OpenTermHere  g:OpenTermHere()
command! -nargs=0 PopupTermHere  g:PopupTermHere()

defcompile
