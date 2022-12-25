vim9script
# File plugin for C
#
# Description: Basically two major functions to support C projects.
#
# Thing A: A simple plugin to update Ctags files after a buffer write. To make
# use of it, a project specific command ':Update' needs to be entered to run
# any action after a buffer has been written.
#
# Thing B: Highlight functions and types, based on Ctags.
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import autoload "ctags.vim"

# def CtagsHighlightingCpl(a,l,p)
#     return filter(['both', 'functions', 'types'], 'v:val =~ a:a')
# endfun

#command! -complete=customlist,CtagsHighlightingCpl -nargs=1 CtagsHighlighting ctags.HighlightTags(<q-args>)
command! -nargs=1 CtagsHighlighting Ctags.HighlightTags(<q-args>)
command! -complete=file -nargs=* Ctags run.Run({'cmd':'ctags <args>','hidden':1})

augroup CTAGS
  autocmd!
  autocmd BufWritePost *.c,*.h ctags.Update()
augroup END
