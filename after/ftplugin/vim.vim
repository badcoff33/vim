" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

let b:undo_ftplugin = "setlocal textwidth< shiftwidth< nocindent<"

setlocal textwidth=0
setlocal shiftwidth=2
setlocal nocindent

nnoremap <buffer> K :help <C-r><C-w><CR>
nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>

" source current visual region
vnoremap <buffer> <LocalLeader>x :<C-U>call VisExecute()<CR>

function! VisExecute() abort
  let save_selection = &selection
  let save_reg_x = @x
  silent normal '<V'>"xy
  let @a = substitute(@x, '\r', '\n', 'g')
  @x
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
  nnoremap <special> <buffer> <LocalLeader>x :w<bar>source%<CR>
else
  " source Vim color theme
  nnoremap <special> <buffer> <LocalLeader>x :w<bar>colorscheme <C-r>=expand("%:t:r")<CR><CR>
endif

let b:did_ftplugin_after = 1
