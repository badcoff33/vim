" Vim ftplugin file

let b:undo_ftplugin = "setlocal smartindent< tabstop< shiftwidth<"

setlocal smartindent tabstop=2 shiftwidth=2

nnoremap <special> <buffer> <CR> :w<bar>luafile %<CR>
vnoremap <buffer> <CR> y:lua <C-r>"<CR>

nnoremap <buffer> K :help <C-r><C-w><CR>

" run LLVM's clang-format -- https://clang.llvm.org/docs/ClangFormat.html
nnoremap <buffer> <LocalLeader>f :call FormatLua()<CR>
vnoremap <buffer> <LocalLeader>f :call FormatLua()<CR>

let g:lua_format_options = "--no-use-tab --indent-width=2 --tab-width=2"

function! FormatLua() range
    let save_cursor = getcurpos()
    if a:firstline == a:lastline
        execute "1,$!lua-format" g:lua_format_options
    else
        execute a:firstline..","..a:lastline.."!lua-format" g:lua_format_options
    endif
    call setpos('.', save_cursor)
endfunction
