vim9script

import autoload "ctags.vim"

augroup GroupeCtags
  autocmd!
  autocmd BufWritePost *.c,*.h     ctags.Update({})
  autocmd BufWritePost *.cpp,*.hpp ctags.Update({})
augroup END

command! -nargs=0 CtagsForceUpdate ctags.Update({rebuild: true})
nnoremap <Leader>T <Cmd>call ctags#Tags()<CR>
nnoremap <Leader>t <Cmd>call ctags#Tags("local")<CR>

defcompile
