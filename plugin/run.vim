command! -complete=file -nargs=* Ctags call run#run({'cmd':'ctags <args>','hidden':1})
command! -complete=file -nargs=* Make call run#run({'cmd':'make <args>', 'hidden':0})
command! -complete=file -nargs=* Rg call run#run({'cmd':'rg --vimgrep <args>', 'hidden':0, 'regexp':&grepformat})
