vim9script
import autoload "torchlight.vim"

augroup GroupTL
    autocmd!
    autocmd TextChanged * torchlight.TorchlightChanged()
    autocmd QuickFixCmdPre make torchlight.TorchlightClearAll()
    autocmd QuickFixCmdPost make torchlight.TorchlightInCurrentBuf()
    autocmd BufEnter * torchlight.TorchlightInCurrentBuf()
augroup END

