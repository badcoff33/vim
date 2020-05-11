
" done
command! -nargs=* StartJob :call async_make#start(<q-args>)
command! -nargs=* Jobs     :call async_make#jobs()
command! -nargs=* StopJob  :call async_make#stop(<q-args>)
