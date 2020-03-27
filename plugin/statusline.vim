" Vim plugin files

set statusline=%{GetDiverge()}%t%m%r%y%w\ %{DispatchScopeParser()}%=%l,%c%V\ %P

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

augroup statusline
  au!
  au WinEnter * :call UpdateDiverge()
  au WinLeave * :call UpdateDiverge()
augroup END

" Description: Returns a distinguishable buffer name as a " string. If
" two windows on a tabpage has the same base name, this function returns
" the difference in file's path (if there is any).
function! GetDiverge()
  let b:diverge_string = get(b:, 'diverge_string', '')
  return b:diverge_string
endfunction

function! UpdateDiverge()
  let b:diverge_string = get(b:, 'diverge_string', '')
  if !empty(&buftype) || empty(bufname('%'))
    return ''
  endif
  let div_string = ''
  for b in tabpagebuflist()
    if bufnr('%') != b && empty(div_string)
      let div_string = s:FindDivergePart(bufname('%'), bufname(b))
    endif
  endfor
  let b:diverge_string = div_string
endfunction

function s:FindDivergePart(name_a, name_b)
  if fnamemodify(a:name_a, ":p:t") == fnamemodify(a:name_b, ":p:t")
    let file_head_a = split(fnamemodify(a:name_a, ":p:h"), '\')
    let file_head_b = split(fnamemodify(a:name_b, ":p:h"), '\')
    while !empty(file_head_a) && !empty(file_head_b)
      let part_a = file_head_a[-1]
      let part_b = file_head_b[-1]
      let file_head_a = file_head_a[:-2]
      let file_head_b = file_head_b[:-2]
      if part_a != part_b
        return '|' . part_a . '|'
      endif
    endwhile
    return ''
  else
    return ''
  endif
endfunction
