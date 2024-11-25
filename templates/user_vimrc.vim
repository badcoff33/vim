vim9script
#
#                                            ######\  ##\ ##\
#                                           ##  __##\ \__|## |
#   #######\   ######\  ##\  ##\  ##\       ## /  \__|##\ ## | ######\
#   ##  __##\ ##  __##\ ## | ## | ## |      ####\     ## |## |##  __##\
#   ## |  ## |######## |## | ## | ## |      ##  _|    ## |## |######## |
#   ## |  ## |##   ____|## | ## | ## |      ## |      ## |## |##   ____|
#   ## |  ## |\#######\ \#####\####  |      ## |      ## |## |\#######\
#   \__|  \__| \_______| \_____\____/       \__|      \__|\__| \_______|
#

# Living with QWERTZ keyboards
set langmap=ö[,ä],Ö{,Ä},ü/,Ü?

# set wildoptions+=fuzzy

g:rst_style = 0

# set guifont=Cascadia\ Code:h11 linespace=2
# set guifont=JuliaMono:h11 linespace=3
# set guifont=Courier\ Prime:h12 linespace=2
set guifont=Rec_Mono_Semicasual:h12
set linespace=2

Blinky stay
#Blinky flash
#Blinky off

if &term == "builtin_gui"
  colorscheme blaubeere
else
  colorscheme apollo
endif

g:netrw_use_errorwindow = 0
g:netrw_wiw = 1
g:netrw_banner = 0
g:netrw_browse_split = 0
g:netrw_altv = 1
g:netrw_cursor = 3
g:netrw_list_hide = '.*\.swp$'
