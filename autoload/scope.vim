" Autoload functions to detect current scope the cursor is in
"
" Description:
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

function! g:WinoptsScope(length)
    let rel_col = win_screenpos(win_getid())[1]
    let d = #{ pos: "topleft",
                \ line: "cursor",
                \ col: rel_col + winwidth(0) - min([30, a:length + 1]),
                \ highlight: 'PmenuSel',
                \ padding: [0, 1, 0, 1],
                \ time: 2000 }
    return d
endfunction

let g:scope_prev_text = ""
let g:scope_prev_line = 1

function! scope#PopupScope()
  let text = scope#GetScope()
  if len(text) < 15
      let text_disp = "< " .. text[0:15]
  else
      let text_disp = "< " .. text[0:15] .. "..."
  endif
  let line_diff = abs(g:scope_prev_line - line("."))
  if empty(text)
      return
  endif
  if g:scope_once == v:true
    if text != g:scope_prev_text
      call popup_create(text_disp, g:WinoptsScope(len(text_disp) + 3))
    endif
  else
    if line_diff > 7
      call popup_create(text_disp, g:WinoptsScope(len(text_disp) + 3))
      let g:scope_prev_line = line(".")
    endif
  endif
  let g:scope_prev_text = text
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



