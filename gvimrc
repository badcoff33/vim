set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~
set guioptions=!a
set guicursor+=n:blinkon0
set guicursor+=i:ver10-Cursor
set guicursor+=ve:ver10-Cursor
" set renderoptions=type:directx encoding=utf-8
set mousemodel=popup
set nomousefocus

augroup GroupGvimrc
    autocmd!
    autocmd GuiEnter * call foreground()
    autocmd FocusLost * try | wall | catch /.*/ | endtry
augroup END

function GetFontInfo(...)
    let font_dict = {}
    let font_dict.family = escape(split(&gfn, ":")[0], ' ')
    try
        let font_height_str = split(&gfn, ":h")[1]
        if a:0 == 1 && a:1 == "+"
            let height = min([20, str2nr(font_height_str) + 1])
        elseif a:0 == 1 && a:1 == "-"
            let height = max([6, str2nr(font_height_str) - 1])
        else
            let height = str2nr(font_height_str)
        endif
        let font_dict.height = string(height)
    catch /.*/
        " height info not part of &gfn: use default
        let font_dict.height = "11"
    endtry
    return font_dict
endfunction

" Resize window
nnoremap <C-ScrollWheelUp> 3<C-w>>
nnoremap <C-ScrollWheelDown> 3<C-w><
nnoremap <C-A-ScrollWheelUp> 3<C-w>+
nnoremap <C-A-ScrollWheelDown> 3<C-w>-

nnoremap <expr> <C-S-ScrollWheelUp> "<cmd>set guifont=" .. GetFontInfo().family .. ":h" .. GetFontInfo("+").height .. "<CR>"
nnoremap <expr> <C-S-ScrollWheelDown> "<cmd>set guifont=" .. GetFontInfo().family .. ":h" .. GetFontInfo("-").height .. "<CR>"
tnoremap <LeftMouse> <C-w>N
tnoremap <RightMouse> <C-w>N

nnoremenu 1.300 PopUp.-SEP3- <NOP>
if has('win32') || has('win64')
    nnoremenu 1.310 PopUp.Explore :silent !explorer <C-r>=expand('%:p:h')<CR><CR>
else
    nnoremenu 1.310 PopUp.Explore :silent Lexplore <C-r>=expand('%:p:h')<CR><CR>
endif
nnoremenu 1.320 PopUp.-SEP4- <NOP>
nnoremenu 1.321 PopUp.Set\ font  :set guifont=*<CR>

" vim:ft=vim

