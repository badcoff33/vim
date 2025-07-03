vim9script

import autoload "ripgrep.vim"

nnoremap <Leader>G :call ripgrep#PatternInput()<CR>
nnoremap <silent> <Leader>g :call ripgrep#RunCompiledCmdLine("<C-r><C-w>")<CR>

defcompile

