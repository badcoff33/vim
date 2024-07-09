" Vim ftplugin file

let b:undo_ftplugin = "setlocal smartindent< tabstop< shiftwidth<"

setlocal smartindent tabstop=2 shiftwidth=2

" run LLVM's clang-format -- https://clang.llvm.org/docs/ClangFormat.html
nnoremap <buffer> <LocalLeader>f :call FormatLua()<CR>
vnoremap <buffer> <LocalLeader>f :call FormatLua()<CR>

if !executable("stylua")
  finish
endif

" This Vim code requires option '-' to use stdin
let g:stylua_options = "--search-parent-directories -"

function! FormatLua() range
    let save_cursor = getcurpos()
    if a:firstline == a:lastline
        execute "1,$!stylua" g:stylua_options
    else
        execute a:firstline..","..a:lastline.."!stylua" g:stylua_options
    endif
    call setpos('.', save_cursor)
endfunction
