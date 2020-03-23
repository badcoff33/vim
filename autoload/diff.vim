" Vim autoload file

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
