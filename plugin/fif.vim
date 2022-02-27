" Vim plugin FIF - find in files
" Description: Some minor extensions to run ripgrep or Windows own findstr.

let g:rg_glob_patterns = {
      \ 'c': '-g *.[ch]',
      \ 'cpp': '-g *.[ch]',
      \ 'vim': '-g *.vim -g *vimrc',
      \ 'asm': '-g *.850',
      \ 'py': '-g *.py',
      \ 'cmake': '-g *.cmake -g CMakeLists.txt',
      \ }

let g:findstr_glob_patterns = {
      \ 'c': '*.c *.h',
      \ 'cpp': '*.c* *.h*',
      \ 'vim': '*vimrc *.vim',
      \ 'asm': '*.s *.asm *.850',
      \ 'py': '*.py',
      \ 'cmake': '*.cmake CMakeLists.txt'
      \ }

let RgGlob = {ft -> has_key(g:rg_glob_patterns, ft) ? g:rg_glob_patterns[ft] : '-g *.*'}
let FindstrGlob = {ft -> has_key(g:findstr_glob_patterns, ft) ? g:findstr_glob_patterns[ft] : '*.*'}

if executable("rg")
  " Using links? Ripgrep supports this by th option '--follow'
  set grepprg=rg\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  nnoremap <expr> <Leader>g ':silent grep ' . RgGlob(&ft) . ' ' . expand('<cword>')
elseif executable("findstr")
  set grepprg=findstr\ /S\ /N
  set grepformat=%f:%l:%m
  nnoremap <expr> <Leader>g ':silent grep ' . expand('<cword>') . ' ' . FindstrGlob(&ft)
endif

if executable("rg")
  " find any file
  command! -nargs=+ Glob :term rg --files -g <args> .
else
  command! -nargs=+ Glob :term dir /S /B <args>
endif


