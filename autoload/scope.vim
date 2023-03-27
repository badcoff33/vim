" Autoload functions to detect current scope the cursor is in
"
" Description:
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

function! g:WinoptsScope()
    let d = #{ pos: "topright",
                \ line: "cursor",
                \ col: win_screenpos(win_getid())[1] + winwidth(0),
                \ highlight: 'Search',
                \ padding: [0, 1, 0, 1],
                \ time: 2000 }
    return d
endfunction

function! scope#PopupScope()
    let g:scope_previous = get(g:, "scope_previous", "")
    let text = scope#GetScope()
    if text != g:scope_previous && text != ""
        call popup_create(text, g:WinoptsScope())
    endif
    let g:scope_previous = text
endfunction

" Description: If a function 'scope#GetScope'..&ft exists, call it. The returned
" string can be used by 'statusline'. Recommended way to add new parser
" functions is to add it in this file. Most important is that the function
" ScopeParser&ft exists.
function! scope#GetScope()
  let parser_fname = 'scope#GetScope' . toupper(&ft[0]) . &ft[1:]
  try
    let FuncRef = function(parser_fname)
    return FuncRef()
  catch
    return ''
  endtry
endfunction

" Description: A scope parser for C files.
function! scope#GetScopeC() abort
  " Regular expressions to find head and bottom lines of a C function.
  let regexpHead = '^[a-zA-Z_].*\(\<[0-9a-zA-Z_]\+\)\s*(.*'
  let regexpTail = '^}.*$'
  " Get the line numbers, starting from current cursor line.
  " (search backward, do not move cursor, do not wrap at head of buffer)
  let  lineHead = search(regexpHead, 'bnW')
  let  lineTail = search(regexpTail, 'bnW')
  " Where is the cursor?
  if lineHead > lineTail
    " Cursor is inside of function
    let funcName = substitute(getline(lineHead), regexpHead, '\1', '')
  else
    let funcName = ''
  endif
  return funcName[:48]
endfun

" Description: A simple scope parser for Python files.
function! scope#GetScopePython() abort
    let regexpHead = '^\s*\(class\|def\)\s\+\(\w\+\).*$'
    let lineHead = search(regexpHead, 'bnWe')
    if lineHead > 0
      return substitute(getline(lineHead), regexpHead, '\1 \2', '')[:30]
    else
      return ""
    endif
endfun

" Description: A simple scope parser for Markdown files.
function! scope#GetScopeMarkdown() abort
  let fNum = search('^#\{1,\}', 'bcnWez')
    if fNum > 0
      let chapter_str = substitute(getline(fNum), '^\(#\{1,\}\)\s\+\(.*\)$', '\=len(submatch(1)).."|"..submatch(2)', '')
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
function! scope#GetScopeVim() abort
  " Regular expressions to find head and bottom lines of a Vim function.
  let regexpHead = '^\(func\|def\|export def\).*\ \+\([A-Za-z0-9#:<>]\+\)(.*$'
  let regexpTail = '^end.*$'
  " Get the line numbers, starting from current cursor line.
  " (search backward, do not move cursor, do not wrap at head of buffer)
  let  lineHead = search(regexpHead, 'bnW')
  let  lineTail = search(regexpTail, 'bnW')
  " Where is the cursor?
  if lineHead > lineTail
    " Cursor is inside of function
    let funcName = substitute(getline(lineHead), regexpHead, '\=submatch(2)', '')
  else
    let funcName = ''
  endif
  return funcName[:30]
endfun



