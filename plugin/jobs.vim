" Vim plugin file

command! -nargs=* -complete=file_in_path RunBg :call jobs#run_bg(<q-args>)
command! -nargs=* -complete=file_in_path Run :call jobs#run(<q-args>)
command! -nargs=0 Jobs :call jobs#jobs()
command! -nargs=1 Stop :call jobs#stop(<q-args>)
