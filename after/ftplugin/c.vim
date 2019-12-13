" File type plugin for C
"
" Description:   Some support functions and mappings for C code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

" Kind of standard to have a type prefix _t
syn match cType /\w*_t/

" A enhanced version of :ptjump -- open a preview window with current symbol highlighted 
nnoremap <buffer> <LocalLeader>p yiw<C-w>}<C-w>P:match Search /<C-r>0/<CR><C-w><C-p>

" Toggle automatic code formatting
nnoremap <buffer> <LocalLeader>a :if match(&fo, 'a') < 0 <bar> setlocal fo+=a <bar> else <bar> setlocal fo-=a <bar> endif<CR>

" run LLVM's clang-format -- https://clang.llvm.org/docs/ClangFormat.html
nmap <buffer> <LocalLeader>f ggVG!clang-format -style=file<CR>
vmap <buffer> <LocalLeader>f !clang-format -style=file<CR>gv=

let b:load_doxygen_syntax=1
let c_no_comment_fold = 1
let c_comment_strings = 1
let c_space_errors = 1

setlocal noshowfulltag
setlocal textwidth=80
setlocal expandtab
setlocal formatoptions+=j
setlocal foldmethod=indent
setlocal foldnestmax=2
setlocal tabstop=4
setlocal shiftwidth=4

" How to display unprintable charcters
setlocal list
setlocal listchars=tab:>-,trail:.,extends:#

" Customize the c indent style
setlocal cinoptions=(0,W4

" iabbrev did not work when 'cpoptions' has '>'
if match(&cpoptions, '>') >= 0
  finish
endif

iabbrev <buffer> xswitch switch ()<Left><C-f>
iabbrev <buffer> xcase   case :<C-f><CR>break;<CR><Up><Up><End><Left>
iabbrev <buffer> xop     {<C-f><CR><CR>}<CR><Up><Up><C-f>
iabbrev <buffer> xif     if ()<Left><C-f>
iabbrev <buffer> xelse   else<C-f><CR>{<C-f><CR><CR>}<CR><Up><Up><C-f>
iabbrev <buffer> xinc    #include ".h"<Left><Left><Left>
iabbrev <buffer> xdef    #define<Space>
iabbrev <buffer> xc      /** \brief */<Left><Left><Left>
iabbrev <buffer> xcc     /**<CR>\brief<CR><BS>/<Up><End>
iabbrev <buffer> xdbg    #warning DEBUG CHANGE STARTS HERE<CR><CR>#warning DEBUG CHANGE ENDS HERE<CR>


