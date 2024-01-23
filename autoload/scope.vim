vim9script
# Autoload functions to detect current scope the cursor is in
#
# Description:
# Maintainer:    markus prepens (markus dot prepens at gmail dot com)

g:scope_prev_text = ""
g:scope_prev_line = 1

def DisplayScope(text: string)
  var rel_col = win_screenpos(win_getid())[1]
  var rel_lin = win_screenpos(win_getid())[0]
  var width = win_getid()->winwidth()
  var pad = (width - len(text)) / 2
  var line: number
  var options = { pos: "topleft",
    line: rel_lin,
    col: rel_col,
    minwidth: width - pad,
    highlight: 'TabLineSel',
    padding: [0, 0, 0, pad],
    time: 3000 }
  popup_create(text, options)
enddef

def LimitString(s: string): string
  var max_text_len: number = 30
  var short_form: string
  if len(s) < max_text_len
      short_form = s[0 : max_text_len]
  else
      short_form = s[0 : max_text_len] .. "..."
  endif
  return short_form
enddef

export def PopupScope(now = false)
  var text: string
  var text_disp: string
  var lines_moved: number

  text = GetScope()
  text_disp = LimitString(text)
  lines_moved = abs(g:scope_prev_line - line("."))

  if empty(text)
    return
  endif
  if now == true
    call DisplayScope(text_disp)
  elseif text != g:scope_prev_text
    call DisplayScope(text_disp)
    g:scope_prev_text = text
  elseif lines_moved > 70
    DisplayScope(text_disp)
    g:scope_prev_line = line(".")
  endif
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
export def GetScopeC(): string
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
export def GetScopePython(): string
    var regexpHead = '^\s*\(class\|def\)\s\+\(\w\+\).*$'
    var lineHead = search(regexpHead, 'bnWe')
    if lineHead > 0
      return substitute(getline(lineHead), regexpHead, '\1 \2', '')[ : 30]
    else
      return ""
    endif
enddef

# Description: A simple scope parser for Markdown files.
export def GetScopeMarkdown(): string
  var fNum = search('^#\{1,\}', 'bcnWez')
    if fNum > 0
      var chapter_str = substitute(getline(fNum),
        '^\(#\{1,\}\)\s\+\(.*\)$',
        '\=len(submatch(1)) .. " | " .. submatch(2)',
        ''
      )
      if len(chapter_str) > 50
        return chapter_str[ : 50] .. '...'
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
