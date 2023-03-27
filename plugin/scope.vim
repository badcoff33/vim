
augroup GroupScope
    au!
    au CursorHold *.vim call scope#PopupScope()
    au CursorHold *.c,*.h call scope#PopupScope()
    au CursorHold *.py call scope#PopupScope()
    au CursorHold *.markdown,*.md,*.txt call scope#PopupScope()
augroup END

