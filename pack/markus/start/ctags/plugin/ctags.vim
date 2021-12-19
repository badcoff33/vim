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

function! CtagsHighlightingCpl(a,l,p)
    return filter(['both', 'functions', 'types'], 'v:val =~ a:a')
endfun

command! -complete=customlist,CtagsHighlightingCpl -nargs=1 CtagsHighlighting call ctags#HighlightTags(<q-args>)

command! -nargs=0 RunCtags  :let g:ctags_timer_id = timer_start(5000, 'ctags#ExecuteCtags', {'repeat': 1})
command! -nargs=0 StopCtags :autocmd! ctags

augroup ctags
  autocmd!
  autocmd BufWritePost *.c :RunCtags
  autocmd BufWritePost *.h :RunCtags
augroup END
