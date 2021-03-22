" File type plugin for C
"
" Description:   Some support functions and mappings for C code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

" Description: Scan trough current TAG file, find the function symbols and
" highlight them as keyword.
function! ctags#HighlightTags(what)
  for tagsfile in tagfiles()
    for line in readfile(tagsfile)
      if a:what == 'functions'
        if match(line, '\<f\>') > 0
          execute "syntax keyword Function" matchstr(line, '^\w\+')
        endif
      elseif a:what == 'types'
        if match(line, '\<t\>') > 0
          execute "syntax keyword Type" matchstr(line, '^\w\+')
        endif
      endif
    endfor
  endfor
endfunction
