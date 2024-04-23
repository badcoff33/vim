" Vim compiler file
" Compiler:   Greenhills - Compiler
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" Description: Use build.cmd to re-route STDERR to STDOUT. The script includes
" the gbuild call as this one: `gbuild %* 2>&1`
"
" Example: A Greenhills Warning
"   C:\Daten\Common_3P\iar_rl78\2.1.1\rl78\bin\iccrl78.exe  --silent C:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\Config_RLIN30\Config_RLIN30.c -DDEBUGGING_ENABLED -DDEVICE=RL78_F24 -DRL78_SafetyLib -DUSE_DEVICE_RL78_F2X=4 -D__FAR_MODEL__ -IC:\Daten\Common_3P\iar_rl78\2.1.1\rl78\bin\..\inc -IC:\Daten\Common_3P\iar_rl78\2.1.1\rl78\bin\..\inc\c -IC:\Daten\Common_3P\iar_rl78\2.1.1\rl78\bin\..\inc\cpp -IC:\Daten\Common_3P\iar_rl78\2.1.1\rl78\bin\..\lib -IC:\Gitlab\rl78_sl\source\common -IC:\Gitlab\rl78_sl\source\eval_board_support\common\include -IC:\Gitlab\rl78_sl\source\eval_board_support\port -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\Config_RLIN30 -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\general -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\r_bsp -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\r_bsp\board\generic_rl78_f24 -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\r_bsp\mcu\all -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\r_bsp\mcu\rl78_f24 -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\r_bsp\mcu\rl78_f24\register_access\iccrl -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\r_config -IC:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\r_pincfg -IC:\Gitlab\rl78_sl\source\safetyLib -IC:\Gitlab\rl78_sl\source\san\common -IC:\Gitlab\rl78_sl\source\san\SAN-RLF2-0202 -IC:\Gitlab\rl78_sl\source\san\SAN-RLF2-0700 -IC:\Gitlab\rl78_sl\source\san\SAN-RLF2-0701 -IC:\Gitlab\rl78_sl\source\san\SAN-RLF2-1500 -IC:\Gitlab\rl78_sl\source\san\SM-Clock-Monitor -IC:\Gitlab\rl78_sl\source\consistency --debug --calling_convention=v2 --double=64 --core=s3 --code_model=far --near_const_location=rom0 --dlib_config=DLib_Config_Normal.h -e --char_is_signed --no_cse --no_unroll --no_inline --no_code_motion --no_tbaa --no_cross_call --no_scheduling --no_clustering --data_model=far --source_encoding=utf8 --utf8_text_in --dependencies=ns source\eval_board_support\CMakeFiles\EvalBoardSupport.dir\smc_gen\Config_RLIN30\Config_RLIN30.o.d -o source\eval_board_support\CMakeFiles\EvalBoardSupport.dir\smc_gen\Config_RLIN30\Config_RLIN30.o
"
"     #error
"      ^
"   "C:\Gitlab\rl78_sl\source\eval_board_support\smc_gen\r_config\r_bsp_config.h",113  Fatal error[Pe035]:
"             #error directive:
"   Fatal error detected, aborting.

"set makeprg=ninja

" multi-line
set errorformat=%W\"%f\"%\\,%l\ \ Warning%m,%C\ %m,%-Z%m
set errorformat+=%E\"%f\"%\\,%l\ \ Error%m,%C\ %m,%-Z%m
set errorformat+=%E\"%f\"%\\,%l\ \ Fatal\ error%m,%C\ %m,%-Z%m

" single-line
"set errorformat+=\"%f\"\\,%l\ \ %m
