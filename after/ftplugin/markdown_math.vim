" TODO
" - cope with engineering units m,k,u,n
" - keep the trailing chars behind result (may be a added comment you want to keep)

function! s:MarkdownCalcLine()
    let equation_orig = substitute(matchstr(getline('.'), '^[^=]*'), '\s\+$', '', 'g')
    let b:equation_nospc = substitute(equation_orig, '\s\+', '', 'g')
    py3 import decimal
    py3 b = vim.current.buffer
    py3 d = decimal.Decimal(str(eval(b.vars["equation_nospc"])))
    "                   use str() to avoid values in the significant
    py3 b.vars["result"] = d.normalize().to_eng_string()
    let replace_line = printf("%s = %s", equation_orig, b:result)
    call setline(line("."), replace_line)
    unlet b:result
    unlet b:equation_nospc
endfunction

" Buffer-local command
command! -buffer -nargs=0 Calc call <SID>MarkdownCalcLine()

" Mappings
nnoremap <buffer> <A-CR> <Cmd>Calc<CR>
imap <buffer> <A-CR> <Esc><A-CR>

