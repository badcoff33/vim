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

if hlexists("AutoPreviewTag") == 0
  highlight! link AutoPreviewTag Search
endif
if !exists("g:c_use_simple_tag_preview")
  let g:c_use_simple_tag_preview = 1
endif

function! c#ToggleAutoPreviewTag()
  if exists("#c#CursorHold") == 1
    augroup c
      autocmd!
    augroup END
    let &previewwindow = s:savePreviewHeight
    let &updatetime = s:saveUpdateTime
    if g:c_use_simple_tag_preview == 0
      wincmd z
    endif
  else
    let s:savePreviewHeight=&previewheight
    let s:saveUpdateTime=&updatetime
    set previewheight=5
    set updatetime=500
    if g:c_use_simple_tag_preview == 1
      augroup c
        autocmd!
        autocmd CursorHold *.c*,*.h* call s:Autocmd_AutoShowTag(expand("<cword>"))
      augroup END
    else
      augroup c
        autocmd!
        autocmd CursorHold *.c*,*.h* call s:Autocmd_AutoPreviewTag(expand("<cword>"))
      augroup END
    endif
  endif
endfunction

function! s:Autocmd_AutoShowTag(symbol)
  let l:tagentry = taglist('\<' . a:symbol . '\>')
  if exists("l:tagentry[0].cmd")
    if len(l:tagentry) == 1
      echo l:tagentry[0].cmd[2:-3] . " [single entry]"
    elseif len(l:tagentry) > 1
      echo l:tagentry[0].cmd[2:-3] . " [" . len(l:tagentry) . " entries]"
    endif
  endif
endfunction

function! s:Autocmd_AutoPreviewTag(cword)
  if &previewwindow
    return
  endif
  if empty(matchstr(a:cword, "^[[:alpha:]].*"))
    return
  endif
  exe "silent! botright ptag " . a:cword
  let l:save_winnr = winnr()
  windo if &previewwindow | exe "match AutoPreviewTag /" . a:cword . "/" | endif
execute l:save_winnr . "wincmd w"
let l:tagentry = taglist(a:cword)
if len(l:tagentry) == 1
  echo l:tagentry[0].cmd . " [single entry]"
elseif len(tagentry) > 1
  echo l:tagentry[0].cmd . " [" . len(l:tagentry) . "entries]"
endif
endfunction
