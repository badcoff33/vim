vim9script

# Plugin: Easy access to the most used Vim resource files

import "config.vim"

autocmd BufNewFile config.json execute ":0read " expand($VIMHOME .. "/templates/vim.json")
autocmd BufWritePost config.json config.Update()

