" Vim ftplugin file

let b:undo_ftplugin = "setlocal textwidth< shiftwidth< nocindent<"

setlocal textwidth=0
setlocal tabstop=4
setlocal shiftwidth=4
setlocal nocindent
setlocal foldmethod=marker

nnoremap <buffer> K :help <C-r><C-w><CR>
nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>

setlocal path=
for p in split(&rtp, ",")
    execute "setlocal path+=" .. escape(p .. g:slash, " \\") .. "**"
endfor

" source current visual region
vnoremap <buffer> <CR> :source<CR>

if empty(matchstr(expand("%:p:h"), "color"))
    " source Vim file
    cabbrev <buffer> x write<bar>source%
else
    " source Vim color theme
    cabbrev <buffer> x :write<bar>colorscheme <C-r>=expand("%:t:r")<CR>
endif

iabbrev <buffer> xfun function!<CR>endfunction<C-f><Up><End>
iabbrev <buffer> xdef def<CR>enddef<Up><End>
iabbrev <buffer> xaug augroup NAME<CR>au!<CR>augroup END<Up><Up><End>
iabbrev <buffer> xfor for<CR>endfor<C-f><CR><Up><Up><End>
iabbrev <buffer> xif  if<CR>endif<C-f><CR><Up><Up><End>

if !exists('*LogError')
    " Description: Support testing with Vim's assert functions
    function! LogError(t)
        if a:t
            echomsg "LogAssert:" v:errors[-1]
        endif
    endfunction
endif


