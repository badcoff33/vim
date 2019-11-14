" local site file 
"
" Description: Vim file surced at the end of init.vim

colorscheme breeze
let g:welcome_text_file = '~/Dokumente/welcome.md'

" Use Umlaut keys in normal mode 
scriptencoding utf-8
scriptencoding 

nnoremap <F3> :CtrlPBuffer<CR>
nnoremap <C-F3> :CtrlPMRUFiles<CR>
nnoremap <S-F3> :CtrlPTag<CR>
let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  

if has ('nvim')
  let g:floaterm_position='center'
  let g:floaterm_winblend=10
  noremap  <silent> <F5> :FloatermToggle<CR>i
  noremap! <silent> <F5> <Esc>:FloatermToggle<CR>i
  tnoremap <silent> <F5> <C-\><C-n>:FloatermToggle<CR>
else
  noremap  <silent> <F5> :terminal<CR>
endif

if has('gui')
  set guioptions=!gt

  set guicursor=n-v:block-Cursor/lCursor-blinkon0
  set guicursor+=ve:ver35-Cursor-blinkon0
  set guicursor+=o:hor50-Cursor-blinkon0
  set guicursor=c:ver25-Cursor/lCursor-blinkon0
  set guicursor+=i-ci:ver25-Cursor/lCursor-blinkon0
  set guicursor+=r-cr:hor20-Cursor/lCursor-blinkon0
  set guicursor+=sm:block-Cursor-blinkon0

  set mousemodel=popup
  if has ('nvim')
    set mousefocus
  endif

  nmap <Leader>1 :set guifont=Courier\ New:h10<CR>
  nmap <Leader>2 :set guifont=Courier\ New:h11<CR>
  nmap <Leader>3 :set guifont=Courier\ New:h12<CR>
endif

" vim:ft=vim:fenc=latin1
