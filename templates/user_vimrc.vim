"    ____     ___ __    __      _____  ____  _        ___
"   |    \   /  _]  |__|  |    |     ||    || |      /  _]
"   |  _  | /  [_|  |  |  |    |   __| |  | | |     /  [_
"   |  |  ||    _]  |  |  |    |  |_   |  | | |___ |    _]
"   |  |  ||   [_|  `  '  |    |   _]  |  | |     ||   [_
"   |  |  ||     |\      /     |  |    |  | |     ||     |
"   |__|__||_____| \_/\_/      |__|   |____||_____||_____|

inoremap jj <Esc>
nnoremap ü ?
nnoremap ö /
nnoremap <C-w><C-z> <C-w>_<C-w><bar>
nnoremap <C-w>C :helpclose<CR>:cclose<CR>
nnoremap <C-w>. :setlocal invwinfixbuf<CR>

nnoremap <Leader>$g :setlocal invspell spelllang=de<cr>:setlocal spell?<CR>
nnoremap <Leader>$e :setlocal invspell spelllang=en<cr>:setlocal spell?<CR>
nnoremap <Leader>+ :tabnew<cr>
nnoremap <A-.> g<C-]>
nnoremap <A-,> <C-t>

"set guifont=Cascadia\ Code:h11 linespace=2 renderoptions=
"set guifont=Fantasque\ Sans\ Mono:h13 linespace=3 renderoptions=
set guifont=Rec\ Mono\ Duotone:h12 linespace=0 renderoptions=
set winaltkeys=no
set norelativenumber
set foldcolumn=1

if &readonly
  " Vim called in read-only mode '-R'
  set laststatus=0
endif

augroup GroupUser
  au!
  au BufEnter,BufCreate *.rst,*.md inoremap <buffer> <C-z>q <Esc>gw(i
  au BufEnter,BufCreate *.rst,*.md inoremap <buffer> <C-z>p <C-r>*
  au BufEnter,BufCreate *.rst,*.md vnoremap <buffer> <C-z>y "*y
  au BufEnter,BufCreate *.c,*.h setlocal fo-=cr
augroup END

" Vim's own packages
"packadd nohlsearch
"packadd hlyank

packadd track
packadd blinkonyank

let g:notes_home_dir = "C:\\Users\\prepensm\\OneDrive\\ -\\ Webasto\\ Group\\Dokumente\\Notes"
let g:notes_todo_file = g:notes_home_dir .. "\\todo.markdown"
let g:notes_diary_file = "~\\diary"
nnoremap <Leader>n :<C-u>Notes<Space>
nnoremap <Leader>N :<C-u>Notes diary<CR>A
packadd notes


augroup GroupVcsUser
  autocmd!
  autocmd BufEnter *.c,*.h,*.txt,*.cmake nnoremap <buffer> <A-x>d :VcsVimdiff<CR>
  autocmd BufEnter *.c,*.h,*.txt,*.cmake nnoremap <buffer> <A-x>i :VcsFileInfo<CR>
augroup END
packadd vcs

packadd easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Blinky stay
Blinky flash
"Blinky off

if &term == "builtin_gui"
  colorscheme apollo
else
  colorscheme feuerwerk
endif

let g:rst_style = 0
let g:rst_fold_enabled = 1
let g:netrw_use_errorwindow = 0
let g:netrw_wiw = 1
let g:netrw_banner = 1
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_cursor = 0
let g:netrw_list_hide = '.*\.swp$'
let g:netrw_liststyle = 0


let g:netrw_decompress = { ".7z": "7z x", ".zip": "unzip"}
let g:netrw_compress = "zip"

augroup GroupNetrwAdd
  autocmd!
  " autocmd WinLeave * let g:netrw_chgwin=winnr()
augroup END

function! TabPanel()
  let str = $"({g:actual_curtabpage})"
  for b in tabpagebuflist(g:actual_curtabpage)
    let str ..= "\n  " .. fnamemodify(bufname(b), ':t')
  endfor
  return str
endfunction
set tabpanel=%!TabPanel()
set tabpanelopt=align:left,columns:30
set showtabpanel=1

set showtabline=0

defcompile
