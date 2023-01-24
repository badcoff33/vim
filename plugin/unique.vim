vim9script
# Vim plugin interface

import autoload "unique.vim"

augroup GroupUnique
    au!
    au BufAdd     * unique.GetUniqueName()
    au BufNew     * unique.GetUniqueName()
    au BufWipeout * unique.GetUniqueName()
    au BufDelete  * unique.GetUniqueName()
augroup END

