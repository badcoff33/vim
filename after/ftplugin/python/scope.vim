" File type plugin for Python
"
" Description:   Some support functions and mappings for Python code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

" statusline with cursors scope info
setlocal statusline=%t%m%r%y%w\ %{ScopeParserPython()}%=%l,%c%V\ %P

" Description: A simple scope parser for Python files.Added indication in which
" context (scope) the cursor is.
function! ScopeParserPython()
    let l:fNum = search('^\s*\(class\|def\)\s\+.*:$', 'bnWe')
    if l:fNum > 0
      return substitute(getline(l:fNum), '^\s*\(class\|def\)\s\+\(\w\+\).*$', '\1 \2', '')[:30]
    else
      return ""
    endif
endfun

