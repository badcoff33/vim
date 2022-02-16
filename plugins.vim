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

let g:dircfg = {
      \ 'HVH1x0_2_0_SW_Development': [
      \   'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
      \   'set path=C_AUTOSAR/**,C_Application/**,C_CDD/**,C_HvUnit/**,,',
      \   'set tagcase=match',
      \   'compiler ghs', 'compiler rg'
      \ ],
      \ 'RL78EVA': [
      \   'set path=main,xcpbasicdrv,mcur5f10agf,sbcata663431,IAR/inc,,',
      \   'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
      \   'command! -nargs=0 CtagsCommand Ctags -R main xcpbasicdrv mcur5f10agf sbcata663431',
      \   'compiler iar'
      \ ],
      \ 'VIM':[
      \   'cd ~\vimfiles',
      \   'set path=pack/**,colors,after/**,,'
      \ ]
      \ }
