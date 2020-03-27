" File type plugin for Markdown

if exists(':ScopeParserMarkdown')
  finish
endif

" Description: A simple scope parser for Markdown files.
function! ScopeParserMarkdown() abort
  let l:fNum = search('^#\{1,\}\s*\(.*\)$', 'bnWe')
    if l:fNum > 0
      return substitute(getline(l:fNum), '^\(#\{1,\}\)\s*\(.*\)$', '\1 \2', '')[:30]
    else
      return ''
    endif
endfun


