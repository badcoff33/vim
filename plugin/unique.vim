vim9script

import autoload "unique.vim"

augroup GroupUnique
    au!
    au BufAdd     * unique.GetUniqueName()
augroup END

