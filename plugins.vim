vim9script

# FZF
g:fzf_colors = {
  'fg':      ['fg', 'Normal'],
  'bg':      ['bg', 'Normal'],
  'hl':      ['fg', 'Comment'],
  'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  'hl+':     ['fg', 'Statement'],
  'info':    ['fg', 'PreProc'],
  'border':  ['fg', 'Ignore'],
  'prompt':  ['fg', 'Conditional'],
  'pointer': ['fg', 'Exception'],
  'marker':  ['fg', 'Keyword'],
  'spinner': ['fg', 'Label'],
  'header':  ['fg', 'Comment']
}

# NETRW variables
g:netrw_use_errorwindow = 0
g:netrw_banner = 1
g:netrw_liststyle = 3
g:netrw_browse_split = 0
g:netrw_altv = 1
g:netrw_winsize = 25
g:netrw_preview = 1

# EASYALIGN
# Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
# Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

# DIRCFG

g:config_functions = [
 "Config_Hvh",
 "Config_T01",
 "Config_T02",
 "Config_T0X",
 "Config_RL78_AAE",
 "Config_RL78_AGF",
 "Config_Vim",
 "Config_C234",
 "Config_FUSA"
]

def g:Config_FUSA()
  command! -nargs=0 UpdateCtags Ctags -R Software
  set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*\ Software
  set path=Software/**,,
  set tagcase=match
  compiler ghs
  g:rg_paths = ["Software", "Build\\Fusa", "\\Daten\\Tools\\MCAL_SPAL\\ASR_RH850_F1KM_42.06.00"]
  g:rg_excludes = ["Build"]
enddef

def g:Config_Hvh()
  command! -nargs=0 UpdateCtags Ctags -R C_Application C_CDD C_AUTOSAR/Sources C:/Daten/Common_3P/comp_SBC_UJA116x/1.3.1
  set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*
  set path=C_AUTOSAR/**,C_Application/**,C_CDD/**,C_HvUnit/**,,
  set tagcase=match
  compiler ghs
enddef

def g:Config_T01()
  command! -nargs=0 UpdateCtags Ctags -R NvmDriverT01 DemoAppT01
  set path=DemoAppT01,DemoAppT01/**,NvmDriverT01,NvmDriverT01/**,,
  compiler iar
  g:rg_paths = ["DemoAppT01", "NvmDriverT01"]
  g:rg_excludes = ["NvmDriverT02", "DemoAppT02"]
enddef

def g:Config_T02()
  command! -nargs=0 UpdateCtags Ctags -R NvmDriverT02 DemoAppT02
  set path=DemoAppT02,DemoAppT02/**,NvmDriverT02,NvmDriverT02/**,,
  compiler iar
  g:rg_paths = ["DemoAppT02", "NvmDriverT02"]
  g:rg_excludes = ["NvmDriverT01", "DemoAppT01"]
enddef

def g:Config_T0X()
  command! -nargs=0 UpdateCtags Ctags -R NvmDriverT02 NvmDriverT01 DemoUscT0X
  set path=DemoUscT0X,DemoUscT0X/**,NvmDriverT02,NvmDriverT02/**,NvmDriverT01,NvmDriverT01/**,,
  compiler iar
  g:rg_paths = ["DemoUscT0X", "NvmDriverT02", "NvmDriverT01"]
  g:rg_excludes = ["DemoAppT02", "DemoAppT01"]
enddef

def g:Config_C234()
  set path=C234_Beta_5_17_2022/**,workspace_5_17_2022/**,,
  g:rg_excludes = ["html"]
  g:rg_paths = ["C234_Beta_5_17_2022", "workspace_5_17_2022"]
enddef

def g:Config_RL78_AAE()
  command! -nargs=0 UpdateCtags Ctags -R main xcpbasicdrv mcur5f10aae sbcata663X31 "c:\Program Files (x86)\IAR Systems\Embedded Workbench 8.5\rl78\inc\ior5f10aae.h" "c:\Program Files (x86)\IAR Systems\Embedded Workbench 8.5\rl78\inc\ior5f10aae_ext.h"
  set path=main,xcpbasicdrv,mcur5f10aae,sbcata663X31,,
  g:rg_paths = ["main", "mcur5f10aae", "xcpbasicdrv", "sbcata663X31"]
  g:rg_excludes = ["Debug"]
  set relativenumber
  compiler iar
enddef

def g:Config_RL78_AGF()
  command! -nargs=0 UpdateCtags Ctags -R main xcpbasicdrv mcur5f10agf sbcata663431
  set path=main,xcpbasicdrv,mcur5f10agf,sbcata663431,,
  set grepprg=rg\ --vimgrep\ -g\ !Debug\ -g\ *.[ch]\ $*
  set relativenumber
  compiler iar
enddef

def g:Config_Vim()
  cd ~\vimfiles
  set path=pack/**,colors,after/**,,
  set relativenumber
enddef

# WORDY

# Define your own ring of dictionaries, overriding the default one in your .vimrc:
g:wordy#ring = [
   'weak',
   ['being', 'passive-voice', ],
   'business-jargon',
   'weasel',
   'puffery',
   ['problematic', 'redundant', ],
   'adjectives',
   'adverbs'
   ]

# You can navigate the ring with the following commands:
# :NextWordy
# :PrevWordy

