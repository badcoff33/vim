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

" Description: scan trough current TAG file, find the type and function symbols
" and highlight them as keyword.
function! c#HighlightTags()
  let g:tagged_files = []
  for l:tagsfile in tagfiles()
    for l:line in readfile(l:tagsfile)
      let l:line_split = split(l:line, '\s\+');
      if match(l:line, '\<t\>') > 0
        execute "syntax keyword cType l:line_split[0]"
        call insert(g:tagged_files, line_split[1])
      elseif match(l:line, '\<f\>') > 0
        execute "syntax keyword Function l:line_split[0]"
        call insert(g:tagged_files, line_split[1])
      endif
    endfor
    call uniq(sort(g:tagged_files))
  endfor
endfunction
