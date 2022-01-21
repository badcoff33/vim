" Vim autoload file
"
" List of all opened buffers during the running Vim session. Each listed buffer
" is tested by UpdateUniqueName.
let g:unique_name_buflist = get(g: , "unique_name_buflist", [])

" Description: Returns a distinguishable buffer name as a " string. If
" two windows on a tabpage has the same base name, this function returns
" the difference in file's path (if there is any).
function! unique#GetUniqueName()
  let b:unique_name_string = get(b:, 'unique_name_string', '')
  if !exists('b:unique_name_string') || empty(b:unique_name_string)
    return ''
  else
    return b:unique_name_string..'|'
  endif
endfunction

" Description: autocmd function
function! unique#UpdateUniqueName()
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
" resulting string for the first parameter file_a.
function s:FindUniqueNamePart(file_a, file_b)
  if a:file_a == a:file_b
    return ''
  elseif fnamemodify(a:file_a, ":p:t") != fnamemodify(a:file_b, ":p:t")
    return ''
  else
    let paths_a = split(substitute(fnamemodify(a:file_a, ":p:h"), '\', '/', 'g'), '/')
    let paths_b = split(substitute(fnamemodify(a:file_b, ":p:h"), '\', '/', 'g'), '/')
    while !empty(paths_a) && !empty(paths_b)
      " check list index 0 of directory lists A/B
      if (paths_a[0] != paths_b[0]) || (len(paths_a) == 1)
        return paths_a[0]
      endif
      " throwaway the tested directory items A/B for next iteration
      let paths_a = paths_a[1:]
      let paths_b = paths_b[1:]
    endwhile
    return paths_a[0]
  endif
endfunction

" --- testing
let v:errors = []

call assert_equal( "vimfiles" , s:FindUniqueNamePart(
      \ "~/vimfiles/colors/twotone.vim",
      \ "~/AppData/Roaming/nvim/colors/twotone.vim"))

call assert_equal( "", s:FindUniqueNamePart(
      \ "aaa/bbb/ccc/111.txt",
      \ "aaa/bbb/ccc/222.txt"))
call assert_equal( "", s:FindUniqueNamePart(
      \ "aaa/bbb/ccc/111.txt",
      \ "aaa/bbb/ccc/111.txt"))

call assert_equal( "ccc", s:FindUniqueNamePart(
      \ "aaa/b2/ccc/111.txt",
      \ "aaa/b2/c3/111.txt"))
call assert_equal( "c3", s:FindUniqueNamePart(
      \ "aaa/b2/c3/111.txt",
      \ "aaa/b2/ccc/111.txt"))
call assert_equal( "bb", s:FindUniqueNamePart(
      \ "aaa/bb/c3/111.txt",
      \ "aaa/bbb/ccc/111.txt"))

" --- varying path length
call assert_equal( "bb", s:FindUniqueNamePart(
      \ "aaa/bb/111.txt",
      \ "aaa/bb/ccc/111.txt"))
call assert_equal( "c3", s:FindUniqueNamePart(
      \ "aaa/bb/c3/111.txt",
      \ "aaa/bb/111.txt"))
call assert_equal( 'sources', s:FindUniqueNamePart(
      \ '\Daten\play\Software\sources\LowLevel\Mcu_Rram_startup_F1KM.850',
      \ '\Daten\play\Software\cmake\_3P\src\ghs\Mcu_Rram_startup_F1KM.850'))
call assert_equal( 'cmake', s:FindUniqueNamePart(
      \ '\Daten\play\Software\cmake\_3P\src\ghs\Mcu_Rram_startup_F1KM.850',
      \ '\Daten\play\Software\sources\LowLevel\Mcu_Rram_startup_F1KM.850'))

" --- case sensitive
if has('unix')
  call assert_equal( "CCC", s:FindUniqueNamePart(
        \ "aaa/bbb/CCC/111.txt",
        \ "aaa/bbb/ccc/111.txt"))
  call assert_equal( "ccc", s:FindUniqueNamePart(
        \ "aaa/bbb/ccc/111.txt",
        \ "aaa/bbb/CCC/111.txt"))
endif
" Show assert results
for e in v:errors
  echo e
endfor




