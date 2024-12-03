vim9script
import autoload "math.vim"

# Mappings
nnoremap <buffer> <C-CR> <Cmd>call math#EvalPyLine()<CR>
inoremap <buffer> <C-CR> <Cmd>call math#EvalPyLine()<CR>
