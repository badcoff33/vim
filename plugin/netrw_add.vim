" Customize NETRW

" Variables
let g:netrw_special_syntax = 1
let g:netrw_use_errorwindow = 0
let g:netrw_wiw = 1
let g:netrw_banner = 1
let g:netrw_bannerbackslash = 0
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_cursor = 5
let g:netrw_list_hide = '.*\.swp$'

augroup GroupNetrwAdd
  autocmd!
  autocmd WinLeave * let g:netrw_chgwin=winnr()
augroup END
