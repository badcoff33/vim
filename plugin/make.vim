" Vim plugin file

command! -nargs=* -complete=file_in_path Start :call jobs#start(<q-args>)
command! -nargs=0 Jobs :call jobs#jobs()
command! -nargs=1 Stop :call jobs#stop(<q-args>)
