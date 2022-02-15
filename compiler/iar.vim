" Vim compiler file
" Compiler:   IAR
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" -----------------------------------------------------------------------------------
"
" Example: IAR compile warning output
"
"   __interrupt static void r_wdt_interrupt(void)
"   ^
" "C:\Daten\BSP\StartRL78\applilet3_src\r_cg_wdt_user.c",51  Warning[Pa031]: IAR
"           keyword "__interrupt" used with IAR extended language disabled
"
"
" -----------------------------------------------------------------------------------
"
" Example: IAR linker error output
"
"     IAR ELF Linker V4.21.1.2409/W32 for RL78
"     Copyright 2011-2021 IAR Systems AB.
"  Error[Li005]: no definition for "_BRD_PIN_DBG1_SET_HIGH" [referenced from C:\Us
"            ers\prepensm\Documents\Workspaces\_\Debug\Obj\McuR5F10AGF\McuR5F10AGF
"            _ADC.o]
"  Error[Li005]: no definition for "_BRD_PIN_DBG1_SET_LOW" [referenced from C:\Use
"            rs\prepensm\Documents\Workspaces\_\Debug\Obj\McuR5F10AGF\McuR5F10AGF_
"            ADC.o]
"

set makeprg=make

" single line
"set errorformat=\"%f\"\\,%l\ %m

" multiline
set errorformat=%E\"%f\"\\,%l\ \ Error%m,%C%m,%Z
set errorformat+=%E\"%f\"\\,%l\ \ Fatal\ error%m,%C%m,%Z
set errorformat+=%W\"%f\"\\,%l\ \ Warning%m,%C%m,%Z
