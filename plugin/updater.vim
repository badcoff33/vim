" Description: A simple plugin to trigger Ctags regeneration or other tasks
" that take place after a buffer write. To make use of it, a project specific
" vimrc needs to set the command :Update to run any action after any buffer has
" been written.

command! -nargs=0 StartUpdater :let g:updater_timer_id = timer_start(1000, '<SID>UpdaterCb', {'repeat': -1})
command! -nargs=0 StopUpdater  :call timer_stop(g:updater_timer_id)

let g:updater_run_it = get(g:, 'updater_run_it', 0)

function! s:UpdaterCb(tid)
  if exists(':Update') && a:tid == g:updater_timer_id
    if g:updater_run_it
      Update
      let g:updater_run_it = 0
    endif
  endif
endfunction

augroup updater
  autocmd!
  autocmd BufWritePost * :let g:updater_run_it = 1
augroup END
