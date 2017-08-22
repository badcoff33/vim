" Vim plugin file

" Tune the diff feature for my needs.
set diffopt=context:3,vertical,iwhite,filler

"Taken from Vims help file diff.txt:
command! ShowUnsavedChanges vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

command! -nargs=0 ToggleVimdiff      call vimdiff#Toggle()
command! -nargs=0 VimdiffFileContext call vimdiff#FileContext()

