" Vim plugin file

command! -nargs=* -complete=file_in_path Start :call jobs#Start(<q-args>)
command! -nargs=* -complete=file_in_path Run   :call jobs#Run(<q-args>)
command! -nargs=0 CloseTerm :call jobs#CloseTermWindows()
command! -nargs=1 Stop      :call jobs#Stop(<q-args>)
