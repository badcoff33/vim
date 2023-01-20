vim9script
# File plugin for C
#
# Description: A simple plugin to update Ctags files after a buffer write. To
# make use of it, a project specific command ':Update' needs to be entered to
# run any action after a buffer has been written.
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import autoload "run.vim"

var ctags_locked: bool
var ctags_job: job

ctags_locked = false

def g:CtagsTriggerUpdate()
    if job_status(ctags_job) != "run"
        ctags_locked = false
    endif
    if exists("g:ctags_options") && (ctags_locked == false)
        ctags_locked = true
        ctags_job = run.Run({cmd: 'ctags ' .. g:ctags_options, hidden: true})
    endif
enddef

augroup GroupeCtags
  autocmd!
  autocmd BufWritePost *.c,*.h call CtagsTriggerUpdate()
  autocmd BufWritePost *.cpp,*.hpp call CtagsTriggerUpdate()
augroup END

