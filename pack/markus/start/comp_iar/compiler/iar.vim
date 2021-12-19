" Vim compiler file
" Compiler:   IAR
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" Example: IAR compile warning output
"
"   __interrupt static void r_wdt_interrupt(void)
"   ^
" "C:\Daten\BSP\StartRL78\applilet3_src\r_cg_wdt_user.c",51  Warning[Pa031]: IAR
"           keyword "__interrupt" used with IAR extended language disabled
"

set makeprg=make

" single line
"set errorformat=\"%f\"\\,%l\ %m

" multiline
set errorformat=%E\"%f\"\\,%l\ \ Error%m,%C%m,%Z
set errorformat+=%E\"%f\"\\,%l\ \ Fatal\ error%m,%C%m,%Z
set errorformat+=%W\"%f\"\\,%l\ \ Warning%m,%C%m,%Z
