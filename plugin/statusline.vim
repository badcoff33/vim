" Vim plugin files

"set statusline=%{GetJobActive()}\ %{GetDiverge()}%t%m%r%y%w%=/%{GetSearchMode()}\ %{GetScope()}\ %l,%c%V\ %P
set statusline=%{GetDiverge()}%t%m%r%y%w\ %l/%L,%c\ %{GetJobActive()}%{GetSearchMode()}\ %=%{GetScope()}

" Description: give a simple indicator about the job status to make it more
" obvious.
function! GetJobActive()
  if term#JobActive()
    return '$ '
  else
    return''
  endif
endfunction

function! GetSearchMode()
  if &ignorecase == 1 && &smartcase == 1
    return 's'
  elseif &ignorecase == 0
    return 'c'
  else
    return 'i'
  endif
endfunction

" Description: If a function ScopeParser&ft exists, call it. The returned
" string can be used by 'statusline'. Recommended way to add new parser
" functions is in a file, located in after/ftplugin/&ft/scope.vim. Most
" important is that the function ScopeParser&ft exists.
function! GetScope()
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
  au BufWinEnter * :call UpdateDiverge()
augroup END

" List of all opened buffers during the running Vim session. Each listed buffer
" is tested by UpdateDiverge.
let g:diverge_buflist = []

" Description: Returns a distinguishable buffer name as a " string. If
" two windows on a tabpage has the same base name, this function returns
" the difference in file's path (if there is any).
function! GetDiverge()
  let b:diverge_string = get(b:, 'diverge_string', '')
  if !exists('b:diverge_string') || empty(b:diverge_string)
    return ''
  else
    return b:diverge_string..'|'
  endif
endfunction

" Description: autocmd function
function! UpdateDiverge()
  if !empty(&buftype) || empty(bufname('%'))
    let b:diverge_string = ''
    return
  endif
  call add(g:diverge_buflist, bufnr('%'))
  let g:diverge_buflist = uniq(sort(g:diverge_buflist))
  let div_string = ''
  for b in g:diverge_buflist
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
    let path_list_a = split(fnamemodify(a:bufname_a, ":p:h"), '\')
    let path_list_b = split(fnamemodify(a:bufname_b, ":p:h"), '\')
    while !empty(path_list_a) && !empty(path_list_b)
      " get last part of directories A/B
      let part_a = path_list_a[0]
      let part_b = path_list_b[0]
      if part_a != part_b
        break
      endif
      " throwaway the last directory items A/B for next iteration
      let path_list_a = path_list_a[1:]
      let path_list_b = path_list_b[1:]
    endwhile
    if !empty(path_list_a)
      return path_list_a[0]
    else
      return part_a
    endif
  else
    return ''
  endif
endfunction

if exists('*LogError')
call LogError(assert_match( "", s:FindDivergePart("aaa/bbb/ccc/111.txt", "aaa/bbb/ccc/111.txt")))
call LogError(assert_match( "", s:FindDivergePart("aaa/bbb/ccc/111.txt", "aaa/bbb/ccc/111.txt")))

call LogError(assert_match( "ccc", s:FindDivergePart("aaa/b2/ccc/111.txt", "aaa/b2/c3/111.txt")))
call LogError(assert_match( "c3", s:FindDivergePart("aaa/b2/c3/111.txt", "aaa/b2/ccc/111.txt")))
call LogError(assert_match( "bb", s:FindDivergePart("aaa/bb/c3/111.txt", "aaa/bbb/ccc/111.txt")))

" varying path length
call LogError(assert_match( "bb", s:FindDivergePart("aaa/bb/111.txt", "aaa/bb/ccc/111.txt")))
call LogError(assert_match( "c3", s:FindDivergePart("aaa/bb/c3/111.txt", "aaa/bb/111.txt")))

" case sensitive?
call LogError(assert_match( "CCC", s:FindDivergePart("aaa/bbb/CCC/111.txt", "aaa/bbb/ccc/111.txt")))
call LogError(assert_match( "ccc", s:FindDivergePart("aaa/bbb/ccc/111.txt", "aaa/bbb/CCC/111.txt")))
endif

