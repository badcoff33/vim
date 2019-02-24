" Vim ftplugin file

if exists("b:did_ftplugin_after")
  finish
endif

if !exists("*ScopeParserVim")
" Description: A scope parser for Vim files. Added indication in which context
" (scope) the cursor is.
function ScopeParserVim()

  " Regular expressions to find head and bottom lines of a Vim function.
  let l:regexpFindFuncHead = '^fun.*\s\+[A-Za-z0-9#:<>]\+\s*(.*)'
  let l:regexpFindFuncBottom = '^endf.*$'

  " Regular expression to find the function name. Group 1 holds the function
  " name plus its parameters.
  let l:regexpExtractFunctionName = '^fun.*\s\+\([A-Za-z0-9#:<>]\+\s*(.*)\)'

  " Get the line numbers, starting from current cursor line.
  " (search backward, do not move cursor, do not wrap at head of buffer)
  let  l:lineFuncHead = search(l:regexpFindFuncHead, 'bnW')
  let  l:lineFuncBottom = search(l:regexpFindFuncBottom, 'bnW')
  
  " Where is the cursor?
  if l:lineFuncHead > l:lineFuncBottom
    " Cursor is inside of function
    let l:vimFunctionName = substitute(getline(l:lineFuncHead), l:regexpExtractFunctionName, '\1', '')
  else
    let l:vimFunctionName = ''
  endif

  return l:vimFunctionName[:30]

endfun
endif

setlocal textwidth=0
setlocal shiftwidth=2
setlocal nocindent

" statusline with cursors scope info
setlocal statusline=%t%m%r%y%w\ %{ScopeParserVim()}%=%l,%c%V\ %P

nnoremap <buffer> <LocalLeader>o :set <C-r><C-w>?<CR>
nnoremap <buffer> <localleader>h :verbose highlight <C-r><C-w><CR>

" Execute current visual region -- use register @v
vnoremap <special> <buffer> <LocalLeader>e "vyQexecute @v<CR>visual

if empty(matchstr(expand("%:p"), "color"))
  " Execute whole Vim file
  nnoremap <special> <buffer> <LocalLeader>e :w<bar>source%<CR>
else
  " Execute Vim color theme
  nnoremap <special> <buffer> <LocalLeader>e :w<bar>colorscheme <C-r>=expand("%:t:r")<CR><CR>
endif

let b:did_ftplugin_after = 1
