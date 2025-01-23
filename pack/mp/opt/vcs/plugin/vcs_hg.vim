vim9script

import autoload "vcs_hg.vim" as hg

command! -nargs=* -complete=customlist,hg.CompleteHg Hg hg.Execute(<q-args>)

# Uncomment when testing
defcompile
