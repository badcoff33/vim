" Vim plugin files

set statusline=%{GetUniqueName()}%t%m%r%y%w\ %l/%L,%c\ %{GetJobActive()}%{GetSearchMode()}\ %=%{GetScope()}

" Description: give a simple indicator about the job status to make it more
" obvious.
function! GetJobActive()
  if job#JobActive()
    return '& '
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
  let parser_str = 'scope#Parser' . toupper(&ft[0]) . &ft[1:]
  try
    let Parser = function(parser_str)
    return Parser()
  catch
    return ''
  endtry
endfunction

augroup statusline
  au!
  au WinEnter * :call UpdateUniqueName()
  au BufWinEnter * :call UpdateUniqueName()
augroup END

" List of all opened buffers during the running Vim session. Each listed buffer
" is tested by UpdateUniqueName.
let g:unique_name_buflist = []

" Description: Returns a distinguishable buffer name as a " string. If
" two windows on a tabpage has the same base name, this function returns
" the difference in file's path (if there is any).
function! GetUniqueName()
  let b:unique_name_string = get(b:, 'unique_name_string', '')
  if !exists('b:unique_name_string') || empty(b:unique_name_string)
    return ''
  else
    return b:unique_name_string..'|'
  endif
endfunction

" Description: autocmd function
function! UpdateUniqueName()
  if !empty(&buftype) || empty(bufname('%'))
    let b:unique_name_string = ''
    return
  endif
  call add(g:unique_name_buflist, bufnr('%'))
  let g:unique_name_buflist = uniq(sort(g:unique_name_buflist))
  let div_string = ''
  for b in g:unique_name_buflist
    if bufnr('%') != b && empty(div_string)
      let div_string = s:FindUniqueNamePart(bufname('%'), bufname(b))
    endif
  endfor
  let b:unique_name_string = div_string
endfunction

" Description: Find the differences in buffers path name and return the
" resulting string for the first parameter bufname_a.
function s:FindUniqueNamePart(bufname_a, bufname_b)
  if fnamemodify(a:bufname_a, ":p:t") == fnamemodify(a:bufname_b, ":p:t")
    let path_a = substitute(fnamemodify(a:bufname_a, ":p:h"), '\', '/', 'g')
    let path_list_a = split(path_a, '/')
    let path_b = substitute(fnamemodify(a:bufname_b, ":p:h"), '\', '/', 'g')
    let path_list_b = split(path_b, '/')
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
call LogError(assert_match( "", s:FindUniqueNamePart("aaa/bbb/ccc/111.txt", "aaa/bbb/ccc/111.txt")))
call LogError(assert_match( "", s:FindUniqueNamePart("aaa/bbb/ccc/111.txt", "aaa/bbb/ccc/111.txt")))

call LogError(assert_match( "ccc", s:FindUniqueNamePart("aaa/b2/ccc/111.txt", "aaa/b2/c3/111.txt")))
call LogError(assert_match( "c3", s:FindUniqueNamePart("aaa/b2/c3/111.txt", "aaa/b2/ccc/111.txt")))
call LogError(assert_match( "bb", s:FindUniqueNamePart("aaa/bb/c3/111.txt", "aaa/bbb/ccc/111.txt")))

" varying path length
call LogError(assert_match( "bb", s:FindUniqueNamePart("aaa/bb/111.txt", "aaa/bb/ccc/111.txt")))
call LogError(assert_match( "c3", s:FindUniqueNamePart("aaa/bb/c3/111.txt", "aaa/bb/111.txt")))

call LogError(assert_match( 'cmake', s:FindUniqueNamePart('\Daten\play\Software\cmake\_3P\comp_MCAL_V_RH850_F1KM\42.6.0\MCAL\ASR_RH850_F1KM_42.06.00\X1X\F1x\common_family\src\ghs\Mcu_Rram_startup_F1KM.850',
      \ '\Daten\play\Software\sources\LowLevel\Mcu_Rram_startup_F1KM.850')))

" case sensitive?
call LogError(assert_match( "CCC", s:FindUniqueNamePart("aaa/bbb/CCC/111.txt", "aaa/bbb/ccc/111.txt")))
call LogError(assert_match( "ccc", s:FindUniqueNamePart("aaa/bbb/ccc/111.txt", "aaa/bbb/CCC/111.txt")))
endif

