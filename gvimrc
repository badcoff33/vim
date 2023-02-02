set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~
set guioptions=!a
set guicursor+=a:blinkon0
set renderoptions=type:directx encoding=utf-8
set mousemodel=popup
set nomousefocus

augroup GroupGvimrc
    autocmd!
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

nnoremap <expr> <C-ScrollWheelUp> "<cmd>set guifont=" .. GetFontInfo().family .. ":h" .. GetFontInfo("+").height .. "<CR>"
nnoremap <expr> <C-ScrollWheelDown> "<cmd>set guifont=" .. GetFontInfo().family .. ":h" .. GetFontInfo("-").height .. "<CR>"

tnoremap <LeftMouse> <C-w>N
tmap <RightMouse> <C-w>N<RightMouse>

nnoremenu 1.300 PopUp.-SEP3- <NOP>
if has('win32') || has('win64')
    nnoremenu 1.310 PopUp.Explore :silent !explorer <C-r>=expand('%:p:h')<CR><CR>
else
    nnoremenu 1.310 PopUp.Explore :silent Lexplore <C-r>=expand('%:p:h')<CR><CR>
endif
nnoremenu 1.320 PopUp.-SEP4- <NOP>
nnoremenu 1.321 PopUp.Set\ font  :set guifont=*<CR>

" vim:ft=vim
