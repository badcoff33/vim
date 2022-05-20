" Vim plugin FIF - find in files
" Description: Some minor extensions to run ripgrep or Windows own findstr.

let g:rg_glob_patterns = {
      \ 'c': '-tc',
      \ 'cpp': '-tcpp',
      \ 'vim': '-g *.vim -g *vimrc',
      \ 'asm': '-g *.850',
      \ 'py': '-tpy',
      \ 'cmake': '-tcmake',
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
  command! -complete=file -nargs=* Rg call run#run({'cmd':'rg --vimgrep <args>', 'hidden':0, 'regexp':&grepformat})
  command! -complete=file -nargs=* RgFiles call run#run({'cmd':"rg --files --glob-case-insensitive --glob *<args>*"})
elseif executable("findstr")
  set grepprg=findstr\ /S\ /N
  set grepformat=%f:%l:%m
endif

if executable("rg")
  " find any file
  command! -nargs=+ FindFile :term rg --files --glob-case-insensitive --glob *<args>* .
else
  command! -nargs=+ FindFile :term dir /S /B <args>
endif


