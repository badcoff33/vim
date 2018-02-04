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

" Description: Set up a Vimdiff view in a new tab with 2 files
function! vimdiff#OpenTab(file_list)

  if len(a:file_list) == 2

    let l:file_a = a:file_list[0]
    let l:file_b = a:file_list[1]

    if filereadable(l:file_a) && filereadable(l:file_b)
      execute "tabedit ". l:file_a
      execute "diffsplit " . l:file_b
    else
      echohl WarningMsg
      echo '-- No diff files found ---'
      echohl None
    endif
  else
    echohl WarningMsg
    echo '-- Only 2-way diff supported --'
    echohl None
  endif

endfunction

" If diff was run in unified put put (switch '-u'), this function opens a new
" tab and runs Vimdiff with the files in cursors diff file context.
function! vimdiff#FileContext()

  if &filetype != "diff"
    return
  endif

  let l:find_unified_diff_head = '^\(=== diff\|diff\).*$'
  let l:find_unified_diff_filea = '^--- \(\S\+\).*$'
  let l:find_unified_diff_fileb = '^+++ \(\S\+\).*$'
  let l:diff_files = []

  if search(l:find_unified_diff_head, "cb") == 0
    echohl ErrorMsg | echo '-- No unified diff format found ---' | echohl None
    return []
  endif

  +1
  call add(l:diff_files, substitute(getline("."), l:find_unified_diff_filea, '\1', ''))
  +1
  call add(l:diff_files, substitute(getline("."), l:find_unified_diff_fileb, '\1', ''))

  call vimdiff#OpenTab(l:diff_files)

endfunction


" Description: Toggle vimdiff on/off.
" If option 'diff' is set, turn 'diff' in all buffers of current window off.
" If option 'diff' is unset, run :diffthis in each window in current tab.
function! vimdiff#Toggle()

  if &diff
    " Use :diffoff! to switch off diff mode for the current window and in all
    " windows in the current tab page where 'diff' is set.
    diffoff!
  else
    windo diffthis
  endif

endfunction

function! vimdiff#TwoDirDiff()
  let l:a = input("diff directory A: ", expand("%:p:h"), "dir")
  let l:b = input("diff directory B: ", expand("%:p:h"), "dir")
  let l:a = fnamemodify(l:a, ":p:h")
  let l:b = fnamemodify(l:b, ":p:h")
  enew
  setlocal buftype=nofile 
  execute 'read !diff -rq ' . l:a . " " . l:b 
  %s/^Files\s//e
  %s/\sand\s/\r/e
  %s/\sdiffer/\r/e
  nnoremap <buffer> <CR> {j0"ay$j0"by$:tabedit <C-r>a<CR>:diffsplit <C-r>b<CR>
endfunction
