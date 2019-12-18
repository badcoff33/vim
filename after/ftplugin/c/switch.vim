" File type plugin for C
"
" Description:   Some support functions and mappings for C code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

command! -buffer -nargs=0 ToggleSourceHeaderFile call <SID>ToggleSourceHeaderFile()

nnoremap <buffer> <LocalLeader><TAB> :ToggleSourceHeaderFile<CR>

if exists('g:did_load_c_switch')
  finish
endif
let g:did_load_c_switch = 1

function! s:ToggleSourceHeaderFile()
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

