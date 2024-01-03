" Desccription: Enhance Vim's diff capabilities
" the interfaces for the new functions are defined here.

" taken from the Vim doc
command! -nargs=0 ShowUnsavedChanges :call diff#UnsavedChanges()

" compare two enitre directory trees against each other
command! -nargs=0 CompareDirs :call diff#CompareDirs()
