" Vim autoload files

function! s:WhatHiGroupName()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  return synIDattr(synidtrans, "name")
endfunction

" Description: Adjust spaces in C code files.
function! c#CodeCleanup() range
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
