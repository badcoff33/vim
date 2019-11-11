" Vim plugin interface

" commands

command! -nargs=0 Welcome call welcome#open()

command! -nargs=0 ShowHiName             :call basic#HiName()
command! -nargs=1 HighlightWord          :call basic#HighlightWord("<args>")
command! -nargs=0 ToggleStickyCursorline :call basic#ToggleStickyCursorLine()
command! -nargs=0 ToggleStatusline       :call basic#ToggleStatusline()

command! -nargs=0 SwitchWorkspace  :call workspace#Switch()

command! -nargs=+ -complete=file Job    :call runjob#StartJob(<q-args>)
command! -nargs=1 -complete=dir JobCwd  :call runjob#SetCwd(<q-args>)

command! -nargs=0 WhitespaceCleanup :call whitespace#Cleanup()
command! -nargs=0 WhitespaceMelt    :call whitespace#Melt()

command! -nargs=0 ShowUnsavedChanges        :call vimdiff#UnsavedChanges()
command! -nargs=* -complete=dir TwoDirDiff  :call vimdiff#TwoDirDiff(<f-args>)

augroup plugin
  
  " clear group in case file sourced several times
  autocmd!

  autocmd BufReadPost * call basic#RestoreCursor()

  autocmd BufWritePre *.cpp,*.C :WhitespaceCleanup
  autocmd BufWritePre *.c,*.h   :WhitespaceCleanup
  autocmd BufWritePre *.py      :WhitespaceCleanup

augroup END

