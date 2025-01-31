vim9script

import autoload "unique.vim"

augroup GroupUniqueP
    au!
    au BufEnter     * unique.GetUniqueName()
augroup END
