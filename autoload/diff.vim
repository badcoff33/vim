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

let g:compare_dirs_options = get(g:, 'compare_dirs_options', '')

" Description: Run recursive diff between two directories.  Diff's output get
" reformatted and display in a new scratch buffer. Then, press <CR> on a line
" with two files that differ and Vimdiff gets opened.
function! diff#CompareDirs() abort
  let g:compare_dir_default_a = get(g:, 'compare_dir_default_a', getcwd())
  let a = input("compare base dir A: ", g:compare_dir_default_a, "dir")
  let g:compare_dir_default_a = a
  let g:compare_dir_default_b = get(g:, 'compare_dir_default_b', getcwd())
  let b = input("compare base dir B: ", g:compare_dir_default_b, "dir")
  let g:compare_dir_default_b = b
  " remove trailing backslash (added by dir completion). Diff doesn't like
  " them. And expand '~'
  let a = fnamemodify(a, ":p:h")
  let b = fnamemodify(b, ":p:h")
  " create a fresh out buffer

  call term#Start('diff -rq '
        \ .. g:compare_dirs_options
        \ .. ' "' .. a .. '"'
        \ .. ' "' .. b .. '"',
        \ 0) " do not forward to quickfix
  tabnew
  call term#ToFrontBuffer()
  nnoremap <buffer> <silent> <CR> :call <SID>DiffParseLine(getline('.'))<CR>
endfunction

" Description: What to do with a single line of diff output.
" KnownIssue: Wrong parsing of paths with spaces.
function! s:DiffParseLine(line)
  let save_reg_x = @x
  let save_reg_y = @y
  if match(a:line, "File") == 0
    normal 0wvE"xyWWvE"yy
    execute "tabedit" @x
    execute "diffsplit" @y
  elseif match(a:line, "Only") == 0
    normal 02wvE"xyWvE"yy
    let only_file = @x[:-2] . "/" . @y
    execute "tabedit" only_file
  endif
  let @x = save_reg_x
  let @y = save_reg_y
endfunction
