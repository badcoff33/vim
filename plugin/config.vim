vim9script

# Plugin: Read local config in file vim.json
# Reference File: Templates/vim.json

import "config.vim"

autocmd BufNewFile vim.json execute ":0read " expand($VIMHOME .. "/templates/vim.json")
autocmd BufWritePost vim.json config.Update()

