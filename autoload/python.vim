" Vim autoload files

" Description: A simple scope parser for Python files.Added indication in which
" context (scope) the cursor is.
function python#ScopeParser()
    let l:fNum = search('^\s*\(class\|def\)\s\+.*:$', 'bnWe')
    if l:fNum > 0
      return substitute(getline(l:fNum), '^\s*\(class\|def\)\s\+\(\w\+\).*$', '\1 \2', '')[:30]
    else
      return ""
    endif
endfun

