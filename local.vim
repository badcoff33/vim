set langmap=ü/,Ü?,ö[,ä],Ö{,Ä}

inoremap <C-Space> <Esc>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

let g:rc = { 'C:\Users\prepensm\Documents\Workspaces\_':
         \    [ 'set path=Main,XcpBasicDrv,McuR5F10AGF,,',
         \      'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
         \      'command! -nargs=0 CtagsCommand Ctags -R Main XcpBasicDrv McuR5F10AGF ..\\..\\BSP\\RL78\\IAR\\copy_inc_ior5f10agf',
         \      'compiler iar'
         \    ]
         \ }

if exists("g:GuiLoaded") && (g:GuiLoaded == 1)
  GuiFont! Fira\ Code
endif

set guifont=Fira_Code:h12
  colorscheme little_monster
