" TODO
" - cope with engineering units m,k,u,n
" - keep the trailing chars behind result (may be a added comment you want to keep)

function! s:MarkdownCalcLine()
    try
        py3 import decimal
        py3 eq = vim.eval("substitute(matchstr(getline('.'), '^[^=]*'), '\\s\\+$', '', 'g')")
        py3 eq_ = vim.eval("substitute(py3eval('eq'), '\\s\\+', '', 'g')")
        py3 d = decimal.Decimal(str(eval(eq_))) # convert to string to avoid floating point noise
        py3 o = "{} = {}".format(eq, d.normalize().to_eng_string())
        py3 vim.command("call setline(line('.'), py3eval('o'))")
    catch /.*/
        echo "trouble in math"
    finally
    endtry
endfunction

" Buffer-local command
command! -buffer -nargs=0 Calc call <SID>MarkdownCalcLine()
" or
"autocmd CursorHold <buffer> Calc

" Mappings
nnoremap <buffer> <A-CR> <Cmd>Calc<CR>
imap <buffer> <A-CR> <Esc><A-CR>

