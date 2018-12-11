" Vim autoload file
"

" Description: Run a diff of current buffer content and file content.
" Taken from Vims help file diff.txt:
function! vimdiff#UnsavedChanges()
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
function! vimdiff#TwoDirDiff()
  let l:a = input("diff directory A: ", expand("%:p:h"), "dir")
  let l:b = input("diff directory B: ", expand("%:p:h"), "dir")
  " remove trailing backslash (added by dir completion)
  let l:a = fnamemodify(l:a, ":p:h")
  let l:b = fnamemodify(l:b, ":p:h")
  " create a fresh out buffer
  enew
  setlocal buftype=nofile 
  insert
" Diff run with -rq options
" Optimal diff paramter can be added by variable 'g:two_dir_diff_option'
" Press <CR> on the set of files that differ.
.
  " run the recursive diff
  silent execute 'read !diff -rq ' . l:a . " " . l:b 
  " reformat diff's --brief output format
  silent %s/^Only\s/\rOnly /e
  silent %s/^Files\s/\r/e 
  silent %s/\sand\s/\r/e 
  silent %s/\sdiffer//e 
  " save buffer for further changes
  setlocal nomodified nomodifiable 
  " one key magic
  nnoremap <buffer> <CR> {j0"ay$j0"by$:tabedit <C-r>a<CR>:diffsplit <C-r>b<CR>
endfunction

