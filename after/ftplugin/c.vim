" File type plugin for C
"
" Description:   Some support functions and mappings for C code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

let b:undo_ftplugin = "setl cinoptions< list< tw< expandtab< formatoptions< tabstop< shiftwidth< foldnestmax< foldmethod<"

setlocal cinoptions=(0,W4,gN
setlocal complete+=]
setlocal expandtab
setlocal foldmethod=indent
setlocal foldnestmax=2
setlocal formatoptions+=j
setlocal list
setlocal shiftwidth=4
setlocal tabstop=4
setlocal textwidth=80

let b:load_doxygen_syntax = 0
let g:c_no_comment_fold = 1
if exists("g:c_comment_strings") | unlet g:c_comment_strings | endif
let g:c_space_errors = 1
let g:c_syntax_for_h = 1

" iabbrev did not work when 'cpoptions' has '>'
if match(&cpoptions, '>') < 0
  iabbrev <buffer> xswi switch ()<C-f><Cr>{<CR>default:<C-f><CR>break;<CR>}<C-o>4k<End><Left>
  iabbrev <buffer> xcas case <CR>break;<CR><Up><Up><End>
  iabbrev <buffer> xop  {<C-f><CR><CR>}<CR><Up><Up><C-f>
  iabbrev <buffer> xif  if ()<Left><C-f>
  iabbrev <buffer> xels else<C-f><CR>{<C-f><CR><CR>}<CR><Up><Up><C-f>
  iabbrev <buffer> xinc #include ".h"<Left><Left><Left>
  iabbrev <buffer> xdef #define
  iabbrev <buffer> xtod #warning TODO
  iabbrev <buffer> {} {<CR><CR>}<Up><C-f>
  iabbrev <buffer> xdoc /**<CR>\brief<CR>\param[in]<CR>\param[out]<CR>\return<CR><BS>*/<CR><Up><Up><Up><Up><Up><End>
endif

" open tag preview
nnoremap <buffer> K g<C-]>
nnoremap <buffer> <A-+> :tnext<CR>
nnoremap <buffer> <A--> :tprev<CR>
nnoremap <buffer> <LocalLeader>S <Cmd>call scope#PopupScope()<CR>

" Toggle automatic comment formatting
nnoremap <buffer> <LocalLeader>a :if match(&fo, 'a') < 0 <bar> setlocal fo+=a <bar> else <bar> setlocal fo-=a <bar> endif<CR>

" run LLVM's clang-format -- https://clang.llvm.org/docs/ClangFormat.html
nnoremap <buffer> <LocalLeader>f :silent call <SID>FormatC()<cr>
vnoremap <buffer> <LocalLeader>f :silent call <SID>FormatC()<cr>

" switch between header/source
nnoremap <buffer> <LocalLeader><Tab> :call swap#OtherFileC()<CR>

function! s:FormatC() range
  let save_cursor = getcurpos()
  noautocmd execute "cd" expand("%:p:h")
  if a:firstline == a:lastline
    1,$!clang-format -style=file
  else
    execute a:firstline.."."..a:lastline.."!clang-format -style=file"
  endif
  noautocmd execute "cd -"
  call setpos('.', save_cursor)
endfunction
