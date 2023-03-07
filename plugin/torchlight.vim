vim9script
import autoload "torchlight.vim"

augroup GroupTorchlight
    autocmd!
    # autocmd TextChanged * torchlight.TorchlightChanged()
    autocmd QuickFixCmdPre make torchlight.TorchlightClearAll()
    autocmd WinEnter * torchlight.TorchlightUpdate()
    autocmd BufWinEnter * torchlight.TorchlightUpdate()
augroup END

