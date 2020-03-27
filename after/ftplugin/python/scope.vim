" File type plugin for Python
"
" Description:   Some support functions and mappings for Python code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

if exists(':ScopeParserPython')
  finish
endif

" Description: A simple scope parser for Python files.
function! ScopeParserPython() abort
    let l:fNum = search('^\s*\(class\|def\)\s\+.*:$', 'bnWe')
    if l:fNum > 0
      return substitute(getline(l:fNum), '^\s*\(class\|def\)\s\+\(\w\+\).*$', '\1 \2', '')[:30]
    else
      return ""
    endif
endfun

