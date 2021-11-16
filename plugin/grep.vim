vim9script
# Vim plugin Grep
#
# Description: Some mior extensions run ripgrep or Windows own findstr.
# Ironically, right now grep iteslf is not used, because I work On Windows
# only.


g:rg_glob_patterns = {
  'c': '-g *.[ch]',
  'cpp': '-g *.[ch]',
  'vim': '-g *.vim',
  'asm': '-g *.850',
  'py': '-g *.py',
  'cmake': '-g *.cmake -g CMakeLists.txt',
  }

  g:findstr_glob_patterns = {
    'c': '*.c *.h',
    'cpp': '*.c* *.h*',
    'vim': '*vimrc *.vim',
    'asm': '*.s *.asm *.850',
    'py': '*.py',
    'cmake': '*.cmake CMakeLists.txt'
    }

if executable("rg")

  # Using links? Ripgrep supports this by th option '--follow'
  set grepprg=rg\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  var RgGlob = (ft) => has_key(g:rg_glob_patterns, ft) ? g:rg_glob_patterns[ft] : '-g *.*'
  nnoremap <expr> <Leader>g ':silent grep ' .. RgGlob(&ft) .. ' ' .. expand('<cword>')
  nmap <F8> <Leader>g<CR>

elseif executable("findstr")

  set grepprg=findstr\ /S\ /N
  set grepformat=%f:%l:%m
  var FindstrGlob = (ft) => has_key(g:findstr_glob_patterns, ft) ? g:findstr_glob_patterns[ft] : '*.*' }
  nnoremap <expr> <Leader>g ':silent grep ' .. expand('<cword>') .. ' ' .. FindstrGlob(&ft)
  nmap <F8> <Leader>g<CR>

elseif executable("grep")

  set grepprg=grep\ -Hnr\ --exclude=cmake\ $* \.
  set grepformat=%f:%l:%m

endif

if executable("rg")
  # find any file
  command! -nargs=+ Glob :term rg --files -g <args> .
else
  command! -nargs=+ Glob :term dir /S /B <args>
endif

