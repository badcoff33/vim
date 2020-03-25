" Vim autoload file

"Description: print a short hint where the buffers % and # differ in
"their name. Might help in Vimdiff view.
function! diff#DivergeNamesVisitedBuffers()
  let l:file_a = bufname('%')
  let l:file_b = bufname('#')
  let l:file_diverge_a =  fnamemodify(l:file_a, ":p:t")
  let l:file_diverge_b =  fnamemodify(l:file_b, ":p:t")
  let l:file_head_a = split(fnamemodify(l:file_a, ":p:h"), '\')
  let l:file_head_b = split(fnamemodify(l:file_b, ":p:h"), '\')

  if l:file_diverge_a == l:file_diverge_b
    while !empty(l:file_head_a) && !empty(l:file_head_b)
      let l:part_a = l:file_head_a[-1]
      let l:part_b = l:file_head_b[-1]
      let l:file_head_a = l:file_head_a[:-2]
      let l:file_head_b = l:file_head_b[:-2]
      if l:part_a != l:part_b
        let l:file_diverge_a =  '|' . l:part_a . '|' . l:file_diverge_a
        let l:file_diverge_b =  '|' . l:part_b . '|' . l:file_diverge_b
        break
      endif
    endwhile
  endif
  echo printf('%%: %s  #: %s', l:file_diverge_a, l:file_diverge_b)
endfunction

" Description: Run a diff of current buffer content and file content.
" Taken from Vims help file diff.txt:
function! diff#UnsavedChanges()
  vert new
  set bt=nofile
  r ++edit #
  0d_
  diffthis
  wincmd p
  diffthis
endfunction

" Description: Run recursive diff between two directories.  Diff's output get
" reformatted. Press <CR> on a set of two files that differ and Vimdiff gets
" opened.
function! diff#CompareDirs(...)
  if !exists('a:1')
    let l:a = input("compare base dir A: ", expand("%:p:h"), "dir")
  else
    let l:a = a:1
  endif
  if !exists('a:2')
    let l:b = input("compare base dir B: ", expand("%:p:h"), "dir")
  else
    let l:b = a:2
  endif
  " remove trailing backslash (added by dir completion) and expand '~'
  let l:a = fnamemodify(l:a, ":p:h")
  let l:b = fnamemodify(l:b, ":p:h")
  " create a fresh out buffer
  tabnew
  setlocal buftype=nofile nonumber norelativenumber
  insert
" Diff run with -rq options
" Press <CR> on the set of files that differ.
.
  " run the recursive diff
  silent execute 'read !diff -rq ' . l:a . " " . l:b
  " save buffer for further changes
  setlocal nomodified nomodifiable
  " one key magic
  nnoremap <buffer> <silent> <CR> :call <SID>DiffParseLine(getline('.'))<CR>
endfunction

function! s:DiffParseLine(line)
  if match(a:line, "File") == 0
    normal 0wvE"xyWWvE"yy
    execute "tabedit" @x
    execute "diffsplit" @y
  elseif match(a:line, "Only") == 0
    normal 02wvE"xyWvE"yy
    let l:only_file = @x[:-2] . "/" . @y
    execute "tabedit" l:only_file
  endif
endfunction
