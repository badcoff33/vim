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
        border: [1, 1, 1, 1],
        padding: [1, 1, 1, 1],
        title: "cmd"
    }
    g:popup_terminal_winid = popup_create(buf, winopts)
    set wincolor=Terminal
    autocmd VimResized <buffer> popup_move(g:popup_terminal_winid, winopts)
enddef

def g:SwitchToMainTerminal()
    var term_bufnrs = term_list()
    if len(term_bufnrs) == 0
        g:OpenTermHere()
        return
    endif
    var winnr = bufwinnr(term_bufnrs[0])
    if winnr >= 1
        execute ":" .. string(winnr) .. "wincmd w"
    else
        wincmd s
        wincmd J
        execute "buffer" term_bufnrs[0]
    endif
enddef

augroup GroupTerminal
    au!
    au TerminalOpen * setlocal signcolumn=no
    au TerminalOpen * setlocal nonumber
    au TerminalOpen * setlocal norelativenumber
    au TerminalOpen * setlocal foldcolumn=0
    au TerminalOpen * tnoremap <buffer> <silent> <CR>   <C-w>:execute "let b:line =" line("$")<CR><CR>
    au TerminalOpen * tnoremap <buffer> <silent> <C-CR> <C-w>:execute b:line .. ",$ write! $TEMP/term.log"<CR><C-w>:cfile $TEMP/term.log<CR>
    au TerminalOpen * nnoremap <buffer> <silent> <C-CR>      :execute b:line .. ",$ write! $TEMP/term.log"<CR><C-w>:cfile $TEMP/term.log<CR>
augroup END

nnoremap <silent> <Leader>T :call SwitchToMainTerminal()<CR>

command! -nargs=0 OpenTermHere  g:OpenTermHere()
command! -nargs=0 PopupTermHere  g:PopupTermHere()

defcompile
