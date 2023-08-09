vim9script
# File plugin for C
#
# Description: A simple plugin to update Ctags files after a buffer write. To
# make use of it, a project specific command ':Update' needs to be entered to
# run any action after a buffer has been written.
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import autoload "run.vim"

var ctags_job: job

def g:CtagsTriggerUpdate()
    var ctags_options: string

    if job_status(ctags_job) == "run" || !exists("g:ctags_options")
        return
    endif

    if type(g:ctags_options) == v:t_string
        ctags_options = g:ctags_options
    elseif type(g:ctags_options) == v:t_list
        ctags_options = join(g:ctags_options, " ")
    else
        echoerr "unknown type of g:ctags_options"
        return
    endif

    ctags_job = run.RunStart({cmd: 'ctags ' .. ctags_options, background: true})
    if job_status(ctags_job) != "run"
        echoerr "check ctags options"
    endif
enddef

augroup GroupeCtags
    autocmd!
    autocmd BufWritePost *.c,*.h call CtagsTriggerUpdate()
    autocmd BufWritePost *.cpp,*.hpp call CtagsTriggerUpdate()
augroup END

defcompile

