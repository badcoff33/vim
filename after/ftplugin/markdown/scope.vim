" File type plugin for Markdown

if exists(':ScopeParserMarkdown')
  finish
endif

" Description: A simple scope parser for Markdown files.
function! ScopeParserMarkdown() abort
  let l:fNum = search('^#\{1,\}\s*\(.*\)$', 'bnWe')
    if l:fNum > 0
      let chapter_str = substitute(getline(l:fNum), '^\(#\{1,\}\)\s\+\(.*\)$', '\=len(submatch(1)).."/"..submatch(2)', '')
      if len(chapter_str) > 30
        return chapter_str[:30] .. '...'
      else
        return chapter_str
      endif
    else
      return ''
    endif
endfun


