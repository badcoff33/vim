" Vim plugin interface

command! -nargs=0 OpenWorkspaceList      :call workspace#OpenListFile()

command! -nargs=0 ShowHiName             :call basic#HiName()
command! -nargs=1 HighlightWord          :call basic#HighlightWord("<args>")
command! -nargs=0 ToggleStickyCursorline :call basic#ToggleStickyCursorLine()
command! -nargs=0 ToggleStatusline       :call basic#ToggleStatusline()

command! -nargs=0 WhitespaceCleanup :call whitespace#Cleanup()
command! -nargs=0 WhitespaceMelt    :call whitespace#Melt()

command! -nargs=0 ShowUnsavedChanges        :call vimdiff#UnsavedChanges()
command! -nargs=* -complete=dir TwoDirDiff  :call vimdiff#TwoDirDiff(<f-args>)

augroup plugin
  autocmd!
  autocmd BufReadPost *         :call basic#RestoreCursor()
  autocmd BufWritePre *.cpp,*.C :WhitespaceCleanup
  autocmd BufWritePre *.c,*.h   :WhitespaceCleanup
  autocmd BufWritePre *.py      :WhitespaceCleanup
augroup END
