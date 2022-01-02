set langmap=ü/,Ü?,ö[,ä],Ö{,Ä}

inoremap <C-Space> <Esc>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

let g:rc = {
      \ 'RL78EVA': [
      \   'cd c:\users\prepensm\documents\workspaces\_',
      \   'set path=main,xcpbasicdrv,mcur5f10agf,sbcata663431,IAR/inc,,',
      \   'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
      \   'command! -nargs=0 CtagsCommand Ctags -R main xcpbasicdrv mcur5f10agf sbcata663431 IAR\\inc\\*F10AGF*.h',
      \   'compiler iar'
      \ ],
      \ 'VIM':[
      \   'cd ~\vimfiles',
      \   'set path=pack/**,colors,after/**,,'
      \ ]
      \ }

set guifont=fira_code:h12
colorscheme little_monster
