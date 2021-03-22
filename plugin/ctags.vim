" File plugin for C
"
" Description:   Some support functions and mappings for C code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

function! HighlightTagsCompletion(A,L,P)
    return filter(['functions', 'types'], 'v:val =~ a:A')
endfun

command! -complete=customlist,HighlightTagsCompletion -nargs=1
      \ HighlightTags
      \ call ctags#HighlightTags(<q-args>)

