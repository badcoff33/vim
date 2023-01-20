" Vim ftplugin file

let b:undo_ftplugin = "setlocal textwidth< shiftwidth< nocindent<"

setlocal textwidth=0
setlocal shiftwidth=4
setlocal nocindent

nnoremap <buffer> K :help <C-r><C-w><CR>
nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>

setlocal path=
for p in split(&rtp, ",")
    execute "setlocal path+=" .. escape(p .. g:slash, " \\") .. "**"
endfor

if empty(matchstr(expand("%:p:h"), "color"))
    " source Vim file
    nnoremap <special> <buffer> <CR> :w<bar>messages clear<bar>source%<CR>
else
    " source Vim color theme
    nnoremap <special> <buffer> <CR> :w<bar>colorscheme <C-r>=expand("%:t:r")<CR><CR>
endif

" source current visual region
vnoremap <buffer> <CR> :call VimScriptExecuteVisual()<CR>

iabbrev <buffer> _fun function!<CR>endfunction<Up>
iabbrev <buffer> _aug augroup NAME<CR>au!<CR>augroup END<Up><Up><End>

function! VimScriptExecuteVisual() range
    let script_lines = getline(a:firstline, a:lastline)
    echo "Execute" len(script_lines) len(script_lines) == 1 ? "line" : "lines"
    for script_line in script_lines
        execute script_line
    endfor
endfunction

if !exists('*LogError')
    " Description: Support testing with Vim's assert functions
    function! LogError(t)
        if a:t
            echomsg "LogAssert:" v:errors[-1]
        endif
    endfunction
endif


