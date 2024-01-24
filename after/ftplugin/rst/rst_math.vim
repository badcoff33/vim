vim9script
import autoload "math.vim"

# Mappings
nnoremap <buffer> <C-CR> <Cmd>call math#CalcPyLine()<CR>
nnoremap <buffer> <A-CR> <Cmd>call math#EvalPyLine()<CR>
inoremap <buffer> <C-CR> <Cmd>call math#CalcPyLine()<CR>
inoremap <buffer> <A-CR> <Cmd>call math#EvalPyLine()<CR>
