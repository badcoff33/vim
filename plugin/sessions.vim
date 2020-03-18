" Desccription: Remember Vim's last session per directry
" A session is storedin a .session file in each working directory.
" Here is the interface defined:

command! -nargs=1 -complete=dir Cd         :call sessions#Start(<q-args>)

