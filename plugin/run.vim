" Vim plugin interface

command! -complete=file -nargs=* Ctags call run#run({'cmd':'ctags <args>','hidden':1})
command! -complete=file -nargs=* Make call run#run({'cmd':'make <args>', 'hidden':0, 'notify':1})

nnoremap <C-CR> :<C-u>Rg -tc -tcmake \b<C-r><C-w>\b .
nnoremap <leader>M :<C-u>Make<space>
nnoremap <leader>m :<C-u>Make <up><cr>
