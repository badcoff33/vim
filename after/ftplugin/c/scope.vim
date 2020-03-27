" File type plugin for C
"
" Description:   Some support functions and mappings for C code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

if exists(':ScopeParserC')
  finish
endif

" Description: A scope parser for C files.
function! ScopeParserC() abort

  " Regular expressions to find head and bottom lines of a C function.
  let l:regexpFindFuncHead = '^\w\+.*('
  let l:regexpFindFuncBottom = '^}.*$'

  " Regular expression to find the function name. Group 1 holds the function
  " name.
  let l:regexpExtractFunctionName = '.*\(\<[0-9a-zA-Z_]\+\)\s*(.*'

  " Get the line numbers, starting from current cursor line.
  " (search backward, do not move cursor, do not wrap at head of buffer)
  let  l:lineFuncHead = search(l:regexpFindFuncHead, 'bnW')
  let  l:lineFuncBottom = search(l:regexpFindFuncBottom, 'bnW')

  " Where is the cursor?
  if l:lineFuncHead > l:lineFuncBottom
    " Cursor is inside of function
    let l:cFunctionName = substitute(getline(l:lineFuncHead), l:regexpExtractFunctionName, '\1()', '')
  else
    let l:cFunctionName = ''
  endif

  return l:cFunctionName[:48]

endfun
