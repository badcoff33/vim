" Vim plugin files

set statusline=%{DivergeBufNames()}%m%r%y%w\ %{DispatchScopeParser()}%=%l,%c%V\ %P

" Description: If a function ScopeParser&ft exists, call it. The returned
" string can be used by 'statusline'. Recommended way to add new parser
" functions is in a file, located in after/ftplugin/&ft/scope.vim. Most
" important is that the function ScopeParser&ft exists.
function! DispatchScopeParser()
  let parser_str = 'ScopeParser' . toupper(&ft[0]) . &ft[1:]
  if exists('*' . parser_str)
    let Parser = function(parser_str)
    return Parser()
  else
    return ''
  endif
endfunction

"Description: Returns a distinguishable buffer name as a
"string. If the previous visited buffer '#' has the name base
"file name as the current buffer '%', then find a unique name
"for the current buffer.
function! DivergeBufNames()
  let file_a = bufname('%')
  if empty(file_a)
    return '[No Name ' . bufnr('%') . ']'
  endif
  let file_b = bufname('#')
  let file_tail_a = fnamemodify(file_a, ":p:t")
  let file_tail_b = fnamemodify(file_b, ":p:t")
  let file_head_a = split(fnamemodify(file_a, ":p:h"), '\')
  let file_head_b = split(fnamemodify(file_b, ":p:h"), '\')
  if file_tail_a == file_tail_b
    while !empty(file_head_a) && !empty(file_head_b)
      let part_a = file_head_a[-1]
      let part_b = file_head_b[-1]
      let file_head_a = file_head_a[:-2]
      let file_head_b = file_head_b[:-2]
      if part_a != part_b
        let file_tail_a = '|' . part_a . '|' . file_tail_a
        let file_tail_b = '|' . part_b . '|' . file_tail_b
        break
      endif
    endwhile
  endif
  return file_tail_a
endfunction

