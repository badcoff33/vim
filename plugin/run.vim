" Vim plugin interface

command! -complete=file -nargs=* Ctags call run#run({'cmd':'ctags <args>','hidden':1})
command! -complete=file -nargs=* Make call run#run({'cmd':'make <args>', 'hidden':0, 'notify':1})

nnoremap <C-CR> :<C-u>Rg -tc -tcmake \b<C-r><C-w>\b .
nnoremap <leader>M :<C-u>Make<Space>
nnoremap <leader>m :<C-u>Make<Up><cr>
nmap <F7> <Leader>m
imap <F7> <Esc><Leader>m
nmap <C-F7> <Leader>M
imap <C-F7> <Esc><Leader>M

nnoremap <F5> <cmd>call run#popup_terminal()<CR>
imap     <F5> <Esc><F5>

