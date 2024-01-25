vim9script
import autoload "math.vim"

# Mappings
nnoremap <buffer> <C-S-CR> <Cmd>call math#CalcPyLine()<CR>
inoremap <buffer> <C-S-CR> <Cmd>call math#CalcPyLine()<CR>
nnoremap <buffer> <C-CR> <Cmd>call math#EvalPyLine()<CR>
inoremap <buffer> <C-CR> <Cmd>call math#EvalPyLine()<CR>

