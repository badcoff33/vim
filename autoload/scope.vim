" autoload file for plugin Statusline
"
" Description: Tune the 'statusline' option. Added indication for files under
" the working path. Added indication in which context (scope) the cursor is.
" Supported for VimL, C and Python.
"
" Maintainer: markus prepens (markus dot prepens at gmail dot com)

" Description: A scope parser for C files.
function! scope#ScopeParserC()

  " Regular expressions to find head and bottom lines of a C function.
  let l:regexpFindFuncHead = '^\w\+.*)\s*\n*{'
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

" Description: A simple scope parser for Python files.
function! scope#ScopeParserPython()
    let l:fNum = search('^\s*\(class\|def\)\s\+.*:$', 'bnW')
    return substitute(getline(l:fNum), '^.*\s\(\w\+\).*$', '\1', '')[:30]
endfun

" Description: A scope parser for Vim files.
function! scope#ScopeParserVim()

  " Regular expressions to find head and bottom lines of a Vim function.
  let l:regexpFindFuncHead = '^fu.*\s\+\(\w\+#\|s:\|<SID>\)\w\+\s*(.*)'
  let l:regexpFindFuncBottom = '^endf.*$'

  " Regular expression to find the function name. Group 1 holds the function
  " name plus its parameters.
  let l:regexpExtractFunctionName = '^fu.*\s\+\(\(\w\+#\|s:\|<SID>\)\w*\s*(.*)\)'

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

