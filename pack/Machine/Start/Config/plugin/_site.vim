" Use Umlaut keys in normal mode
scriptencoding utf-8

set langmap=ü/,Ü?,ö[,ä],Ö{,Ä}

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

if has('gui')
  colorscheme apollo
  "set guifont=Fira_Code:h11
  set guifont=Courier_Prime:h11
endif

" - Window using a Vim command
let g:fzf_layout = { 'window': 'enew' }

let g:rc = {
      \ 'C:\Users\prepensm\Documents\Workspaces\_':
      \ [ 'set path=.,Main,XcpBasicDrv,,',
      \   'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
      \   'let g:update_cmd = ["-R", "Main", "XcpBasicDrv"]',
      \   'StartUpdater',
      \   'let g:async_auto_quickfix=1',
      \   'compiler iar'
      \ ]
      \ }

