" Autoload functions to detect current scope the cursor is in
"
" Description:
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

" Description: If a function 'scope#Parser'..&ft exists, call it. The returned
" string can be used by 'statusline'. Recommended way to add new parser
" functions is to add it in this file. Most
" important is that the function ScopeParser&ft exists.
function! scope#GetScope()
  let parser_fname = 'scope#Parser' . toupper(&ft[0]) . &ft[1:]
  try
    let Parser = function(parser_fname)
    return Parser()
  catch
    return ''
  endtry
endfunction

" Description: A scope parser for C files.
function! scope#ParserC() abort
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

" Description: A simple scope parser for Python files.
function! scope#ParserPython() abort
    let l:fNum = search('^\s*\(class\|def\)\s\+.*:$', 'bnWe')
    if l:fNum > 0
      return substitute(getline(l:fNum), '^\s*\(class\|def\)\s\+\(\w\+\).*$', '\1 \2', '')[:30]
    else
      return ""
    endif
endfun

" Description: A simple scope parser for Markdown files.
function! scope#ParserMarkdown() abort
  let l:fNum = search('^#\{1,\}', 'bcnWez')
    if l:fNum > 0
      let chapter_str = substitute(getline(l:fNum), '^\(#\{1,\}\)\s\+\(.*\)$', '\=len(submatch(1)).."|"..submatch(2)', '')
      if len(chapter_str) > 30
        return chapter_str[:30] .. '...'
      else
        return chapter_str
      endif
    else
      return ''
    endif
endfun

" Description: A scope parser for Vim files.
function! scope#ParserVim() abort
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



