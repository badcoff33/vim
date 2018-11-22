" Vim autoload files

function! s:WhatHiGroupName()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  return synIDattr(synidtrans, "name")
endfunction

" Description: Adjust spaces in C code files.
function! c#CodeCleanup()
  normal m5gg
  " Rule "Put one space after each keyword"
  while search('\<\(switch\|if\|while\)(', 'W') > 0
    let l:whatHiGroupName = s:WhatHiGroupName()
    if (l:whatHiGroupName == "Conditional") || (l:whatHiGroupName == "Repeat")
      execute "normal ea "
    endif
  endwhile
  normal gg
  " Rule "No space after opening bracket"
  while search('(\s\+', 'W') > 0
    let l:whatHiGroupName = s:WhatHiGroupName()
    if (l:whatHiGroupName == "cParen")
      execute "normal wdT(_"
    endif
  endwhile
  normal gg
  " Rule "No leading space at closing bracket"
  while search('\s\+)', 'W') > 0
    let l:whatHiGroupName = s:WhatHiGroupName()
    if (l:whatHiGroupName == "cParen")
      execute "normal dt)_"
    endif
  endwhile
  normal '5
endfunction

function! c#ToggleSourceHeaderFile()
  let l:file_pairs = {
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

" Description: scan trough current TAG file, find the function symbols and
" highlight them as keyword.
function! c#HighlightTaggedFunctions()
  for l:tagsfile in tagfiles()
    for l:line in readfile(l:tagsfile)
      if match(l:line, '\<f\>') > 0
        let l:symbolStr = split(l:line, '\s\+')[0]
        execute "syntax keyword Function " . l:symbolStr
      endif
    endfor
  endfor
endfunction

" Description: scan trough current TAG file, find the type symbols and
" highlight them as keyword.
function! c#HighlightTaggedTypes()
  for l:tagsfile in tagfiles()
    for l:line in readfile(l:tagsfile)
      if match(l:line, '\<t\>') > 0
        let l:typeStr = split(l:line, '\s\+')[0]
        execute "syntax keyword cType " . l:typeStr
      endif
    endfor
  endfor
endfunction
