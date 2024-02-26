vim9script
# File plugin for C
#
# Description: Torchlight - spot on errors, warnings, infos
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import autoload "torchlight.vim"

command! -nargs=0 TorchlightClear call torchlight#TorchlightClearAll()

# defcompile

