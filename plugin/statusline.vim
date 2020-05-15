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
  au WinEnter    * :windo call UpdateDiverge()
  au WinLeave    * :windo call UpdateDiverge()
  au BufWinEnter * :windo call UpdateDiverge()
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

" Description: Find the differences in buffers path name and return the
" resulting string for the first parameter bufname_a.
function s:FindDivergePart(bufname_a, bufname_b)
  if fnamemodify(a:bufname_a, ":p:t") == fnamemodify(a:bufname_b, ":p:t")
    let diverge_list = [] " converted to a string, the returned
    let path_list_a = split(fnamemodify(a:bufname_a, ":p:h"), '\')
    let path_list_b = split(fnamemodify(a:bufname_b, ":p:h"), '\')
    while !empty(path_list_a) && !empty(path_list_b)
      " get last part of directories A/B
      let part_a = path_list_a[-1]
      if part_a != path_list_b[-1]
        call insert(diverge_list, part_a)
        break
      else
        call insert(diverge_list, '')
      endif
      " throwaway the last directory items A/B for next
      " iteration
      let path_list_a = path_list_a[:-2]
      let path_list_b = path_list_b[:-2]
    endwhile
    return '|' . substitute(join(diverge_list, '|') . '|'
          \ , '|\{2,\}'
          \ , '|'
          \ , 'g')
  else
    return ''
  endif
endfunction
