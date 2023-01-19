vim9script
# File plugin for C
#
# Description: A simple plugin to update Ctags files after a buffer write. To
# make use of it, a project specific command ':Update' needs to be entered to
# run any action after a buffer has been written.
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import autoload "run.vim"

def RunUpdate(tid: number)
    CtagsUpdate
enddef

def Update()
  if exists(":CtagsUpdate") == 2
      timer_start(1000, "RunUpdate", {'repeat': 1})
  endif
enddef

augroup CTAGS
  autocmd!
  autocmd BufWritePost *.c,*.h ctags.Update()
  autocmd BufWritePost *.cpp,*.hpp ctags.Update()
augroup END

command! -complete=file -nargs=* Ctags run.Run({cmd: 'ctags <args>', hidden: true})
