command! -complete=file -nargs=* Make call run#Run({'cmd':'make <args>'})
command! -complete=file -nargs=* Rg call run#Run({'cmd':'rg --vimgrep <args>'})
command! -complete=file -nargs=* Ctags call run#Run({'cmd':'ctags <args>','hidden':1})
