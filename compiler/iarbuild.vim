" Vim compiler file
" Compiler:   IAR build
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" -----------------------------------------------------------------------------------
"
" Example: IAR compile warning output
"
"   C:\Daten\Renesas\RL78\F2x\RL78_SAN_Sample_Code_v1.01\san\common\common_RL78.c(314) : Warning[Pa082]: undefined behavior: the order of volatile accesses is undefined in this statement
"   C:\Daten\Renesas\RL78\F2x\RL78_SAN_Sample_Code_v1.01\san\common\common_RL78.c(331) : Warning[Pa082]: undefined behavior: the order of volatile accesses is undefined in this statement vecttbl.c
"   C:\Daten\Renesas\RL78\F2x\RL78_SAN_Sample_Code_v1.01\prj_iar\src\smc_gen\r_bsp\mcu\rl78_f23\vecttbl.c(39) : Remark[Ta026]: Place located consts so that the __near data pointer can access them
"   C:\Daten\Renesas\RL78\F2x\RL78_SAN_Sample_Code_v1.01\prj_iar\src\smc_gen\r_bsp\mcu\rl78_f23\vecttbl.c(41) : Remark[Ta026]: Place located consts so that the __near data pointer can access them __interrupt static void r_wdt_interrupt(void)
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

set makeprg=iarbuild

" single line
"set errorformat=\"%f\"\\,%l\ %m

" multiline
set errorformat=%E%f(%l)\ :\ Error%m,%Z%m
set errorformat+=%W%f(%l)\ :\ Warning%m,%Z%m
set errorformat+=%W%f(%l)\ :\ Fatal\ Error%m,%Z%m
set errorformat+=%Wielftool\ warning%m,%Z%m
set errorformat+=%EError[.*],%Z%m
