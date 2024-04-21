" #####################################################################
"
"                                            ######\  ##\ ##\
"                                           ##  __##\ \__|## |
"   #######\   ######\  ##\  ##\  ##\       ## /  \__|##\ ## | ######\
"   ##  __##\ ##  __##\ ## | ## | ## |      ####\     ## |## |##  __##\
"   ## |  ## |######## |## | ## | ## |      ##  _|    ## |## |######## |
"   ## |  ## |##   ____|## | ## | ## |      ## |      ## |## |##   ____|
"   ## |  ## |\#######\ \#####\####  |      ## |      ## |## |\#######\
"   \__|  \__| \_______| \_____\____/       \__|      \__|\__| \_______|
"
" ... CHANGE AS REQUIRED
" #####################################################################


" Options for the Ctags executable
let g:ctags_options = [ "-R", "." ]

" for plugin/rg.vim
let g:rg_paths = [ "." ]
let g:rg_excludes = [ "Build" ]

" Look-up path for :find, 'gf' and friends
set path=**,.,,

" case-sensitive tag search
set tagcase=match

" Set compiler (sets 'errorformat') and 'makeprg'
compiler gcc
set makeprg=make

augroup GroupLocal
    au!
    " Remember last state of work
    autocmd VimLeave * mksession! .session
augroup END
