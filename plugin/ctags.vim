" File plugin for C
"
" Description: Basically two major functions to support C projects.
"
" Thing A: A simple plugin to update Ctags files after a buffer write. To make
" use of it, a project specific command ':Update' needs to be entered to run
" any action after a buffer has been written.
"
" Thing B: Highlight functions and types, based on Ctags.
"
" Maintainer: markus prepens (markus dot prepens at gmail dot com)

function! HighlightTagsCompletion(A,L,P)
    return filter(['both', 'functions', 'types'], 'v:val =~ a:A')
endfun

command! -complete=customlist,HighlightTagsCompletion -nargs=1
      \ HighlightTags
      \ call ctags#HighlightTags(<q-args>)

command! -nargs=0 StartUpdater :let g:updater_timer_id = timer_start(5000, 'ctags#UpdaterCallback', {'repeat': -1})
command! -nargs=0 StopUpdater  :call timer_stop(g:updater_timer_id)

augroup ctags
  autocmd!
  autocmd BufWritePost *.c :let g:updater_run_it = 1
  autocmd BufWritePost *.h :let g:updater_run_it = 1
augroup END
