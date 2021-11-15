" Vim plugin Grep
"
" Description: Some mior extensions run ripgrep or Windows own findstr.
" Ironically, right now grep iteslf is not used, because I work On Windows
" only.

nnoremap <F8> <cmd>sil grep <C-r><C-w><CR>

if executable("rg")
  " Using links? Ripgrep supports this by th option '--follow'
  set grepprg=rg\ --vimgrep\ -g\ !cmake\ $*
  set grepformat=%f:%l:%c:%m
  let g:ft2rg_glob = { 'c':'-g *.[ch]',
        \ 'cpp':'-g *.[ch]',
        \ 'vim':'-g *.vim',
        \ 'asm': '-g *.850',
        \ 'py':'-g *.py',
        \ 'cmake':'-g *.cmake -g CMakeLists.txt'
        \ }
  let RgGlob = { ft -> has_key(g:ft2rg_glob, ft) ? g:ft2rg_glob[ft] : '-g *.*' }
  nnoremap <expr> <Leader>g ':silent grep ' .. RgGlob(&ft) .. ' ' .. expand('<cword>')
  command! -nargs=+ Glob :term rg --files -g <args> .
elseif executable("findstr")
  let g:ft2findstr_glob = { 'c':'*.c *.h',
        \ 'cpp':'*.c* *.h*',
        \ 'vim':'*vimrc *.vim',
        \ 'asm': '*.s *.asm *.850',
        \ 'py':'*.py',
        \ 'cmake':'*.cmake CMakeLists.txt'
        \ }
  let FindstrGlob = { ft -> has_key(g:ft2findstr_glob, ft) ? g:ft2findstr_glob[ft] : '*.*' }
  nnoremap <expr> <Leader>g ':silent grep ' .. expand('<cword>') .. ' ' .. FindstrGlob(&ft)
  set grepprg=findstr\ /S\ /N
  set grepformat=%f:%l:%m
elseif executable("grep")
  set grepprg=grep\ -Hnr\ --exclude=cmake\ $* \.
  set grepformat=%f:%l:%m
endif
