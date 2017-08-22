" File type plugin for diffs
" Description: Making life easier in diff buffers
" Maintainer: markus prepens (markus dot prepens at gmail dot com)

" Only do this when not done yet for this buffer
if exists("b:did_diff_ftplugin")
  finish
endif
let b:did_diff_ftplugin = 1

setlocal foldexpr=Diff_FoldLevel()
setlocal foldmethod=expr
setlocal foldcolumn=2
" use 'zi' to fold diffs output
setlocal nofoldenable

function! Diff_FoldLevel()
  let curr_line = getline(v:lnum)
  if match(curr_line, '^===\s\+') != -1
    return '>1'
  elseif  match(curr_line, '^diff\s\+') != -1
    return '>1'
  else
    return 1
  endif
endfunction


