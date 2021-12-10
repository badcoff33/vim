" Vim plugin file -- make access on job processes or terminal easier

command! -nargs=* -complete=file_in_path Job :call job#StartJob(<q-args>)
command! -nargs=0 ToggleJobOutput :call job#ToggleJobOutput()

