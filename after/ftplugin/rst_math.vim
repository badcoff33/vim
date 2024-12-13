vim9script

import "math.vim"

# Local command to have an abstraction of imported function
command! -buffer -nargs=0 CalcLine math.EvalPyLine()

# Local mappings
nnoremap <buffer> <C-CR> <Cmd>py3 DoCalcCurrLine()<CR>
inoremap <buffer> <C-CR> <Cmd>py3 DoCalcCurrLine()<CR>
## nnoremap <buffer> <C-CR> <Cmd>CalcLine<CR>
## inoremap <buffer> <C-CR> <Cmd>CalcLine<CR>
