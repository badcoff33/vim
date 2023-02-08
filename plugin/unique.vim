vim9script

import autoload "unique.vim"

augroup GroupUnique
    au!
    au BufEnter     * unique.GetUniqueName()
augroup END

