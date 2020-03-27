" Vim plugin files

set statusline=%{DivergeBufNames()}%m%r%y%w\ %{ScopeParser()}%=%l,%c%V\ %P

function! ScopeParser()
  if &ft == 'vim'
    return <SID>ScopeParserVim()
  elseif &ft == 'c'
    return <SID>ScopeParserC()
  elseif &ft == 'python'
    return <SID>ScopeParserPython()
  else
    return ''
  endif
endfunction

" Description: A scope parser for C files. Returns a string in which context
" (scope) the cursor is.
function! s:ScopeParserC()
  " Regular expressions to find head and bottom lines of a C function.
  let regexpFindFuncHead = '^\w\+.*('
  let regexpFindFuncBottom = '^}.*$'
  " Regular expression to find the function name. Group 1 holds the function
  " name.
  let regexpExtractFunctionName = '.*\(\<[0-9a-zA-Z_]\+\)\s*(.*'
  " Get the line numbers, starting from current cursor line.
  " (search backward, do not move cursor, do not wrap at head of buffer)
  let  lineFuncHead = search(regexpFindFuncHead, 'bnW')
  let  lineFuncBottom = search(regexpFindFuncBottom, 'bnW')
  " Where is the cursor?
  if lineFuncHead > lineFuncBottom
    " Cursor is inside of function
    let cFunctionName = substitute(getline(lineFuncHead),
          \ regexpExtractFunctionName, '\1()', '')
  else
    let cFunctionName = ''
  endif
  return cFunctionName[:48]
endfun

" Description: A scope parser for Vim files. Returns a string in which context
" (scope) the cursor is.
function! s:ScopeParserVim()
  " Regular expressions to find head and bottom lines of a Vim function.
  let regexpFindFuncHead = '^fun.*\s\+[A-Za-z0-9#:<>]\+\s*(.*)'
  let regexpFindFuncBottom = '^endf.*$'
  " Regular expression to find the function name. Group 1 holds the function
  " name plus its parameters.
  let regexpExtractFunctionName = '^fun.*\s\+\([A-Za-z0-9#:<>]\+\s*(.*)\)'
  " Get the line numbers, starting from current cursor line.
  " (search backward, do not move cursor, do not wrap at head of buffer)
  let  lineFuncHead = search(regexpFindFuncHead, 'bnW')
  let  lineFuncBottom = search(regexpFindFuncBottom, 'bnW')
  " Where is the cursor?
  if lineFuncHead > lineFuncBottom
    " Cursor is inside of function
    let vimFunctionName = substitute(getline(lineFuncHead),
          \ regexpExtractFunctionName, '\1', '')
  else
    let vimFunctionName = ''
  endif
  return vimFunctionName[:30]
endfun


" Description: A simple scope parser for Python files. Returns a string in
" which context (scope) the cursor is.
function! s:ScopeParserPython()
    let fNum = search('^\s*\(class\|def\)\s\+.*:$', 'bnWe')
    if fNum > 0
      return substitute(getline(fNum), '^\s*\(class\|def\)\s\+\(\w\+\).*$', '\1 \2', '')[:30]
    else
      return ""
    endif
endfun

"Description: Returns a distinguishable buffer name as a
"string. If the previous visited buffer '#' has the name base
"file name as the current buffer '%', then find a unique name
"for the current buffer.
function! DivergeBufNames()
  let file_a = bufname('%')
  if empty(file_a)
    return '[No Name ' . bufnr('%') . ']'
  endif
  let file_b = bufname('#')
  let file_tail_a = fnamemodify(file_a, ":p:t")
  let file_tail_b = fnamemodify(file_b, ":p:t")
  let file_head_a = split(fnamemodify(file_a, ":p:h"), '\')
  let file_head_b = split(fnamemodify(file_b, ":p:h"), '\')
  if file_tail_a == file_tail_b
    while !empty(file_head_a) && !empty(file_head_b)
      let part_a = file_head_a[-1]
      let part_b = file_head_b[-1]
      let file_head_a = file_head_a[:-2]
      let file_head_b = file_head_b[:-2]
      if part_a != part_b
        let file_tail_a = '|' . part_a . '|' . file_tail_a
        let file_tail_b = '|' . part_b . '|' . file_tail_b
        break
      endif
    endwhile
  endif
  return file_tail_a
endfunction

