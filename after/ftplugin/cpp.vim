" File type plugin for C
"
" Description:   Some support functions and mappings for C code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

let g:c_show_list_chars = get(g:, 'c_show_list_chars', 1)

" iabbrev did not work when 'cpoptions' has '>'
if match(&cpoptions, '>') < 0
  iabbrev <buffer> xswi switch ()<C-f><Cr>{<CR>default:<C-f><CR>break;<CR>}<C-o>4k<End>
  iabbrev <buffer> xcas case :<C-f><CR>break;<CR><Up><Up><End><Left>
  iabbrev <buffer> xop  {<C-f><CR><CR>}<CR><Up><Up><C-f>
  iabbrev <buffer> xif  if ()<Left><C-f>
  iabbrev <buffer> xels else<C-f><CR>{<C-f><CR><CR>}<CR><Up><Up><C-f>
  iabbrev <buffer> xinc #include ".h"<Left><Left><Left>
  iabbrev <buffer> xdef #define
  iabbrev <buffer> xtod #warning TODO
endif

" open tag preview
nnoremap <buffer> K <C-w>}

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

let b:load_doxygen_syntax = 0
let g:c_no_comment_fold = 1
if exists("g:c_comment_strings") | unlet g:c_comment_strings | endif
let g:c_space_errors = 1
let g:c_syntax_for_h = 1

" Customize the c indent style
setlocal cinoptions=(0,W4,gN

setlocal textwidth=80
setlocal expandtab
setlocal formatoptions+=j
setlocal foldmethod=indent
setlocal foldnestmax=2
setlocal tabstop=4
setlocal shiftwidth=4

" How to display unprintable charcters
if g:c_show_list_chars == 0
  setlocal nolist
else
  setlocal list
endif
setlocal listchars=tab:>-,trail:.,extends:#

