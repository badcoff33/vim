" Vim autoload files

" statusline with cursors scope info
setlocal statusline=%t%m%r%y%w\ %{ScopeParserVim()}%=%l,%c%V\ %P

" Description: A scope parser for Vim files. Added indication in which context
" (scope) the cursor is.
function! ScopeParserVim()

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


