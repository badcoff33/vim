vim9script
# Autoload functions to detect current scope the cursor is in
#
# Description:
# Maintainer:    markus prepens (markus dot prepens at gmail dot com)

g:scope_prev_text = ""
g:scope_prev_line = 1

def DisplayScope(text: string)
  var rel_col = win_screenpos(win_getid())[1]
  var width = win_getid()->winwidth()
  var options = { pos: "topleft",
    line: 1,
    col: rel_col,
    minwidth: width,
    highlight: 'Search',
    padding: [0, 0, 0, (width - len(text)) / 2],
    time: 2000 }
  popup_create(text, options)
enddef

export def PopupScope()
  var max_text_len: number = 30
  var text: string = GetScope()
  var text_disp: string
  if len(text) < max_text_len
      text_disp = text[0 : max_text_len]
  else
      text_disp = text[0 : max_text_len] .. "..."
  endif
  var lines_moved = abs(g:scope_prev_line - line("."))
  if empty(text)
      return
  endif
  if g:scope_once == true
    if text != g:scope_prev_text
      call DisplayScope(text_disp)
    endif
  else
    if lines_moved > 7
      call DisplayScope(text_disp)
      g:scope_prev_line = line(".")
    endif
  endif
  g:scope_prev_text = text
enddef

# Description: If a function 'scope#GetScope'..&ft exists, call it. The returned
# string can be used by 'statusline'. Recommended way to add new parser
# functions is to add it in this file. Most important is that the function
# ScopeParser&ft exists.
def GetScope(): string
  var parser_fname = 'scope#GetScope' .. toupper(&ft[0]) .. &ft[1 : ]
  try
    var FuncRef = function(parser_fname)
    return FuncRef()
  catch
    return ''
  endtry
enddef

# Description: A scope parser for C files.
def GetScopeC(): string
  var funcName: string = ''
  # Regular expressions to find head and bottom lines of a C function.
  var regexpHead = '^[a-zA-Z_].*\(\<[0-9a-zA-Z_]\+\)\s*(.*'
  var regexpTail = '^}.*$'
  # Get the line numbers, starting from current cursor line.
  # (search backward, do not move cursor, do not wrap at head of buffer)
  var  lineHead = search(regexpHead, 'bnW')
  var  lineTail = search(regexpTail, 'bnW')
  # Where is the cursor?
  if lineHead > lineTail
    # Cursor is inside of function
    funcName = substitute(getline(lineHead), regexpHead, '\1', '')
  endif
  return funcName[ : 48]
enddef

# Description: A simple scope parser for Python files.
def GetScopePython(): string
    var regexpHead = '^\s*\(class\|def\)\s\+\(\w\+\).*$'
    var lineHead = search(regexpHead, 'bnWe')
    if lineHead > 0
      return substitute(getline(lineHead), regexpHead, '\1 \2', '')[ : 30]
    else
      return ""
    endif
enddef

# Description: A simple scope parser for Markdown files.
def GetScopeMarkdown(): string
  var fNum = search('^#\{1,\}', 'bcnWez')
    if fNum > 0
      var chapter_str = substitute(getline(fNum),
        '^\(#\{1,\}\)\s\+\(.*\)$',
        '\=len(submatch(1)) .. "|" .. submatch(2)',
        ''
      )
      if len(chapter_str) > 30
        return chapter_str[ : 30] .. '...'
      else
        return chapter_str
      endif
    else
      return ''
    endif
enddef

# Description: A scope parser for Vim files.
export def GetScopeVim(): string
  var funcName: string
  # Regular expressions to find head and bottom lines of a Vim function.
  var regexpHead = '^\(func\|def\|export def\).*\ \+\([A-Za-z0-9#:<>]\+\)(.*$'
  var regexpTail = '^end.*$'
  # Get the line numbers, starting from current cursor line.
  # (search backward, do not move cursor, do not wrap at head of buffer)
  var lineHead = search(regexpHead, 'bnW')
  var lineTail = search(regexpTail, 'bnW')
  # Where is the cursor?
  if lineHead > lineTail
    # Cursor is inside of function
    funcName = substitute(getline(lineHead), regexpHead, '\=submatch(2)', '')
  else
    funcName = ''
  endif
  return funcName[ : 30]
enddef


defcompile
