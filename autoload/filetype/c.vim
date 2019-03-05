" Vim autoload files

function! s:WhatHiGroupName()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  return synIDattr(synidtrans, "name")
endfunction

" Description: Adjust spaces in C code files.
function! filetype#c#CodeCleanup() range
  execute "normal " . a:firstline . "G0"
  " Rule "Put one space after each keyword"
  while search('\<\(switch\|if\|while\)(', 'W') > 0
    if line('.') > a:lastline | break | endif
    let a:whatHiGroupName = s:WhatHiGroupName()
    if (a:whatHiGroupName == "Conditional") || (a:whatHiGroupName == "Repeat")
      execute "normal ea "
    endif
  endwhile
  execute "normal " . a:firstline . "G0"
  " Rule "No space after opening bracket"
  while search('(\s\+', 'W') > 0
    if line('.') > a:lastline | break | endif
    let a:whatHiGroupName = s:WhatHiGroupName()
    if (a:whatHiGroupName == "cParen")
      execute "normal wdT(_"
    endif
  endwhile
  execute "normal " . a:firstline . "G0"
  " Rule "No leading space at closing bracket"
  while search('\s\+)', 'W') > 0
    if line('.') > a:lastline | break | endif
    let a:whatHiGroupName = s:WhatHiGroupName()
    if (a:whatHiGroupName == "cParen")
      execute "normal dt)_"
    endif
  endwhile
endfunction

function! filetype#c#ToggleSourceHeaderFile()
  let l:file_pairs = {
        \ 'C': ['.H'],
        \ 'H': ['.C'],
        \ 'cc': ['.hh'],
        \ 'hh': ['.cc'],
        \ 'c': ['.h', 'Port.h'],
        \ 'h': ['.c'] }
  let l:extension = expand("%:e")
  if l:extension == ''
    return " No extension found: skip this file
  endif
  for [l:key, l:list] in items(l:file_pairs)
    for l:value in l:list
      if l:key == l:extension
        let l:candidate = expand("%:r") . l:value
        if filereadable(l:candidate)
          execute "sil e " . l:candidate
          return
        endif
      endif
    endfor
  endfor
endfunction

" Description: A scope parser for C files. Added indication in which context
" (scope) the cursor is.
function filetype#c#ScopeParser()

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
