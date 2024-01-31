vim9script
# Vim plugin interface

import autoload "run.vim"
import autoload "utils.vim"
import autoload "torchlight.vim"

def MakeCallback()
    torchlight.TorchlightUpdate()
enddef

def MakeStart(cmd: string)
    torchlight.TorchlightClearAll()
    run.RunStart({
        cmd: &makeprg .. " " .. cmd,
        callback: MakeCallback
    })
enddef

augroup GroupMake
    autocmd!
augroup END

command! -complete=file -nargs=* Make MakeStart(<q-args>)

utils.Map('nnoremap', '<Leader>m', ':<C-u>Make<Space><Up>')

