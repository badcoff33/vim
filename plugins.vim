vim9script

# My own stuff
nnoremap <A-CR> :FindFile<space>

# FZF
nnoremap <silent> <F3> <cmd>Buffers<CR>
imap <F3> <Esc><F3>
nnoremap <silent> <F2> <cmd>Files<CR>
imap <F2> <Esc><F2>

# NETRW variables
g:netrw_use_errorwindow = 0
g:netrw_banner = 0
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

g:dircfg_functions = [
 "Dircfg_Hvh",
 "Dircfg_T01",
 "Dircfg_T02",
 "Dircfg_RL78",
 "Dircfg_Vim",
 "Dircfg_TEST"
]

def g:Dircfg_Hvh()
  command! -nargs=0 CtagsCommand Ctags -R C_Application C_CDD C_AUTOSAR/Sources C:/Daten/Common_3P/comp_SBC_UJA116x/1.3.1
  set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*
  set path=C_AUTOSAR/**,C_Application/**,C_CDD/**,C_HvUnit/**,,
  set tagcase=match
  compiler ghs
enddef

def g:Dircfg_T01()
  command! -nargs=0 CtagsCommand Ctags -R NvmDriverT01 Software
  command! -nargs=* Make call run#run({"cmd": "make <args>", "hidden": 0, "notify": 1, "cwd": "Software"})
  set path=Software,Software\**,NvmDriverT01,NvmDriverT01/**,,
  set relativenumber
  compiler iar
  let g:rg_paths = ["Software", "NvmDriverT01"]
  let g:rg_excludes = ["NvmDriverT02"]
enddef

def g:Dircfg_T02()
  command! -nargs=0 CtagsCommand Ctags -R NvmDriverT02 Software
  command! -nargs=* Make call run#run({"cmd": "make <args>", "hidden": 0, "notify": 1, "cwd": "Software"})
  set path=Software,Software\**,NvmDriverT02,NvmDriverT02/**,,
  set relativenumber
  compiler iar
  let g:rg_paths = ["Software", "NvmDriverT01"]
  let g:rg_excludes = ["NvmDriverT02"]
enddef

def g:Dircfg_C234()
  g:rg_excludes = ["html"]
  g:rg_paths = ["C234_Beta_5_17_2022", "workspace_5_17_2022"]
enddef

def g:Dircfg_RL78()
  command! -nargs=0 CtagsCommand Ctags -R main xcpbasicdrv mcur5f10agf sbcata663431
  set path=main,xcpbasicdrv,mcur5f10agf,sbcata663431,,
  set grepprg=rg\ --vimgrep\ -g\ !Debug\ -g\ *.[ch]\ $*
  set relativenumber
  compiler iar
enddef

def g:Dircfg_Vim()
  cd ~\vimfiles
  set path=pack/**,colors,after/**,,
  set relativenumber
enddef





# g:dircfg =
#        {
#        'HVH1x0_2_0': [
#          'command! -nargs=0 CtagsCommand Ctags -R C_Application C_CDD C_AUTOSAR/Sources C:/Daten/Common_3P/comp_SBC_UJA116x/1.3.1',
#          'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
#          'set path=C_AUTOSAR/**,C_Application/**,C_CDD/**,C_HvUnit/**,,',
#          'set tagcase=match',
#          'compiler ghs'
#         ],
#        'RL78_DF_T01': [
#          'command! -nargs=0 CtagsCommand Ctags -R NvmDriverT01 Software',
#          'command! -nargs=* Make call run#run({"cmd":"make <args>", "hidden":0, "notify":1, "cwd":"Software"})',
#          'nnoremap <Leader>G :Rg -tc <C-r><C-w> Software NvmDriverT01',
#          'nmap <Leader>g <Leader>G<CR>',
#          'set path=Software,Software\**,NvmDriverT01,NvmDriverT01/**,,',
#          'set grepprg=rg\ --vimgrep\ -g\ !Debug\ -g\ !NvmDriverT02\ -g\ *.[ch]\ $*',
#          'set relativenumber',
#          'compiler iar'
#        ],
#        'RL78_DF_T02': [
#          'command! -nargs=0 CtagsCommand Ctags -R NvmDriverT02 Software',
#          'command! -nargs=* Make call run#run({"cmd":"make <args>", "hidden":0, "notify":1, "cwd":"Software"})',
#          'nnoremap <Leader>G :Rg -tc <C-r><C-w> Software NvmDriverT02',
#          'nmap <Leader>g <Leader>G<CR>',
#          'set path=Software,Software\**,NvmDriverT02,NvmDriverT02/**,,',
#          'set grepprg=rg\ --vimgrep\ -g\ !Debug\ -g\ !NvmDriverT01\ -g\ *.[ch]\ $*',
#          'set relativenumber',
#          'compiler iar'
#        ],
#        'RL78_evaluation': [
#          'command! -nargs=0 CtagsCommand Ctags -R main xcpbasicdrv mcur5f10agf sbcata663431',
#          'set path=main,xcpbasicdrv,mcur5f10agf,sbcata663431,,',
#          'set grepprg=rg\ --vimgrep\ -g\ !Debug\ -g\ *.[ch]\ $*',
#          'set relativenumber',
#          'compiler iar'
#        ],
#        'VIM': [
#          'cd ~\vimfiles',
#          'set path=pack/**,colors,after/**,,',
#          'set relativenumber'
#        ]}

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

