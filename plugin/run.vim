" Vim plugin interface

command! -complete=file -nargs=* Ctags call run#run({'cmd':'ctags <args>','hidden':1})
command! -complete=file -nargs=* Make call run#run({'cmd':'make <args>', 'hidden':0, 'popup_end':1})
command! -complete=file -nargs=* Rg call run#run({'cmd':'rg --vimgrep <args>', 'hidden':0, 'regexp':&grepformat})

nnoremap <leader>M :<C-u>Make -s<space>
nnoremap <leader>m :<C-u>Make -s<up><cr>
