" Netrw variables
let g:netrw_use_errorwindow = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_preview = 1

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

let g:dircfg =
      \ {
      \ 'HVH1x0_2_0': [
      \   'command! -nargs=0 CtagsCommand Ctags -R C_Application C_CDD C_AUTOSAR/Sources C:/Daten/Common_3P/comp_SBC_UJA116x/1.3.1',
      \   'nnoremap <C-CR> :<C-u>Rg -tc -tcmake <C-r><C-w> . C:/Daten/Common_3P/comp_SBC_UJA116x/1.3.1<CR>',
      \   'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
      \   'set path=C_AUTOSAR/**,C_Application/**,C_CDD/**,C_HvUnit/**,,',
      \   'set tagcase=match',
      \   'compiler ghs'
      \  ],
      \ 'RL78_data_flash': [
      \   'command! -nargs=0 CtagsCommand Ctags -R main xcpbasicdrv mcur5f10agf sbcata663431 NvmDriver',
      \   'nnoremap <C-CR> :<C-u>Rg -tc -tcmake <C-r><C-w> .',
      \   'set path=main,xcpbasicdrv,mcur5f10agf,sbcata663431,NvmDriver,NvmDriver/**,,',
      \   'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
      \   'set relativenumber',
      \   'compiler iar'
      \ ],
      \ 'RL78_evaluation': [
      \   'command! -nargs=0 CtagsCommand Ctags -R main xcpbasicdrv mcur5f10agf sbcata663431',
      \   'nnoremap <C-CR> :<C-u>Rg -tc -tcmake <C-r><C-w> .',
      \   'set path=main,xcpbasicdrv,mcur5f10agf,sbcata663431,,',
      \   'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
      \   'set relativenumber',
      \   'compiler iar'
      \ ],
      \ 'VIM':[
      \   'cd ~\vimfiles',
      \   'set path=pack/**,colors,after/**,,',
      \   'set relativenumber'
      \ ]}

""" WORDY

" Define your own ring of dictionaries, overriding the default one in your .vimrc:
let g:wordy#ring = [
  \ 'weak',
  \ ['being', 'passive-voice', ],
  \ 'business-jargon',
  \ 'weasel',
  \ 'puffery',
  \ ['problematic', 'redundant', ],
  \ 'adjectives',
  \ 'adverbs'
  \ ]

" You can navigate the ring with the following commands:
" :NextWordy
" :PrevWordy

