" TODO
" - cope with engineering units m,k,u,n
" - keep the trailing chars behind result (may be a added comment you want to keep)

function! s:MarkdownCalcLine()
    try
        py3 import decimal
        py3 import re
        py3 line = vim.current.line
        py3 m = re.search("([^=]*)", line)
        py3 eq = m.group(1)
        py3 r = eval(eq.replace(" ", ""))
        py3 d = decimal.Decimal(f"{r}")
        py3 s = "{}= {}".format(eq, d.normalize().to_eng_string())
        py3 vim.current.line = s
    catch /.*/
        echo "trouble in math" py3eval("eq.replace(' ', '')")
    finally
    endtry
endfunction

" Buffer-local command
command! -buffer -nargs=0 Calc call <SID>MarkdownCalcLine()

" Mappings
nnoremap <buffer> <LocalLeader>= <Cmd>Calc<CR>
nnoremap <buffer> <C-CR> <Cmd>Calc<CR>
inoremap <buffer> <C-CR> <Cmd>Calc<CR>

" or trigger by auto command
"autocmd CursorHold <buffer> Calc

