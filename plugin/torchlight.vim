vim9script
import autoload "torchlight.vim"

command -nargs=0 TlUpdate torchlight.TorchlightUpdate()
command -nargs=0 TlClear torchlight.TorchlightClearAll()

augroup GroupTL
    autocmd!
    autocmd InsertLeave * torchlight.TorchlightEdit()
    autocmd QuickFixCmdPre make torchlight.TorchlightClearAll()
    autocmd QuickFixCmdPost make torchlight.TorchlightUpdate()
    autocmd BufEnter * torchlight.TorchlightInCurrentBuf()
augroup END

