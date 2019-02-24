" File type plugin for C
"
" Description:   Some support functions and mappings for C code files.
" Maintainer:    markus prepens (markus dot prepens at gmail dot com)

if !exists("*ScopeParserC")
" Description: A scope parser for C files. Added indication in which context
" (scope) the cursor is.
function ScopeParserC()

  " Regular expressions to find head and bottom lines of a C function.
  let l:regexpFindFuncHead = '^\w\+.*)\s*\n*{'
  let l:regexpFindFuncBottom = '^}.*$'

  " Regular expression to find the function name. Group 1 holds the function
  " name.
  let l:regexpExtractFunctionName = '.*\(\<[0-9a-zA-Z_]\+\)\s*(.*'

  " Get the line numbers, starting from current cursor line.
  " (search backward, do not move cursor, do not wrap at head of buffer)
  let  l:lineFuncHead = search(l:regexpFindFuncHead, 'bnW')
  let  l:lineFuncBottom = search(l:regexpFindFuncBottom, 'bnW')

  " Where is the cursor?
  if l:lineFuncHead > l:lineFuncBottom
    " Cursor is inside of function
    let l:cFunctionName = substitute(getline(l:lineFuncHead), l:regexpExtractFunctionName, '\1()', '')
  else
    let l:cFunctionName = ''
  endif

  return l:cFunctionName[:48]

endfun
endif

command! -buffer -nargs=0 ToggleSourceHeaderFile call c#ToggleSourceHeaderFile()
command! -buffer -range -nargs=0 CodeCleanup <line1>,<line2>call c#CodeCleanup()

nnoremap <buffer> <LocalLeader><TAB> :ToggleSourceHeaderFile<CR>

" A enhanced version of :ptjump -- open a preview window with current symbol highlighted 
nnoremap <buffer> <LocalLeader>p yiw<C-w>}<C-w>P:match Search /<C-r>0/<CR><C-w><C-p>

" Toggle automatic code formatting
nnoremap <buffer> <LocalLeader>a :if match(&fo, 'a') < 0 <bar> setlocal fo+=a <bar> else <bar> setlocal fo-=a <bar> endif<CR>

nnoremap <buffer> <LocalLeader>c :CodeCleanup<CR>
vnoremap <buffer> <LocalLeader>c :CodeCleanup<CR>

" run LLVM's clang-format -- https://clang.llvm.org/docs/ClangFormat.html
nmap <buffer> <LocalLeader>f ggVG!clang-format -style=file<CR>
vmap <buffer> <LocalLeader>f !clang-format -style=file<CR>

" run Uncrustify -- https://github.com/uncrustify/uncrustify
" nmap <buffer> <LocalLeader>f ggVG!uncrustify --frag -c .uncrustify -l C -q<CR>
" vmap <buffer> <LocalLeader>f !uncrustify --frag -c .uncrustify -l C -q<CR>

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

" statusline with cursors scope info
setlocal statusline=%t%m%r%y%w\ %{ScopeParserC()}%=%l,%c%V\ %P

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

