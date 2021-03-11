" Vim ftplugin file

if exists("b:did_ftplugin_after")
"  finish
endif

setlocal textwidth=0
setlocal shiftwidth=2
setlocal nocindent

nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>

" source current visual region
vnoremap <buffer> <LocalLeader>s :<C-U>call VisExecute()<CR>

function! VisExecute() abort
  let save_selection = &selection
  let save_reg_x = @x
  silent normal '<V'>"ay
  let @a = substitute(@a, '\r', '\n', 'g')
  @a
  let @x = save_reg_x
  let &selection = save_selection
endfunction

if !exists('*LogError')
" Description: Support testing with Vim's assert functions
function! LogError(t)
  if a:t
    echomsg "LogAssert:" v:errors[-1]
  endif
endfunction
endif

if empty(matchstr(expand("%:p:h"), "color"))
  " source Vim file
  nnoremap <special> <buffer> <LocalLeader>s :w<bar>source%<CR>
else
  " source Vim color theme
  nnoremap <special> <buffer> <LocalLeader>s :w<bar>colorscheme <C-r>=expand("%:t:r")<CR><CR>
endif

let b:did_ftplugin_after = 1
