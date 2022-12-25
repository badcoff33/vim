" Vim resource file
"
" New Vim features are nicly tracked on this site:
"   https://www.arp242.net/vimlog/
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on

set belloff=all
set clipboard=
set expandtab
set history=200
set keymodel=
set mouse=a
set noerrorbells
set more
set norelativenumber numberwidth=2
set noswapfile
set novisualbell
set nowrap
set report=0
set ruler
set selection=inclusive
set selectmode=
set shiftwidth=2
set shortmess-=S " Yes, search count please
set shortmess-=f " long form for file info
set showmatch matchtime=1
set showtabline=1
set tabstop=2
set termguicolors

" limit number of suggestions of z=
set spellsuggest=best,10
set spelllang=en_us,de_de
set spelloptions=camel

" Read changed files automatically if they are changed in the background
set autoread

" Allow modified files to flip in background, without a write.
set hidden

" Set behavior for commands ':cc', ':cn', 'cp', etc.
set switchbuf=useopen,uselast

" keep cursor line away from the upper and lower window border
set scrolloff=2
set scrolljump=1

" make vertical scrolling more smooth
set sidescroll=8
set sidescrolloff=3

" window behavior
set nosplitbelow
set splitright
set equalalways

" folding
set foldmethod=indent
set foldnestmax=1
set nofoldenable

" Write all files before any ':make' command
set autowrite

" timer configuration for key sequences
set notimeout
set nottimeout

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start
set whichwrap+=<,>,[,]

" makes selecting text more consistent (at least for me)
set virtualedit=onemore,block

" Search: Some configuration for the search behavior.
set ignorecase smartcase
set incsearch
set hlsearch
set magic
set wrapscan

set backup
execute 'set backupdir=' . getenv('LOCALAPPDATA') . '\vim\backup'
set wildignore+=*/backup/*

set undofile
execute 'set undodir=' . getenv('LOCALAPPDATA') . '\vim\undo'
set wildignore+=*/undo/*

" Insert mode completion
set complete=.,w
set noshowfulltag
set completeopt=menu

set pumheight=7

" Command line completion
set wildmenu
set wildoptions=pum,tagfile
set wildmode=full
set wildignorecase
set wildignore+=*.*~,*.o,TAGS
" How to handle search for tags
set tagcase=match

" Tune the diff feature for my needs.
set diffopt=internal,algorithm:minimal,context:8,vertical,iwhite,filler
" When starting in 'diff' mode, go full screen.
if &diff
  set columns=999 lines=999
endif
command! ShowChanges vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Switch to normal mode with special keys
inoremap <Ins> <Esc>
inoremap <k0> <Esc>
inoremap <C-Space> <Esc>

" Use the minus key for something useful
nnoremap - :

" Replace current inner word with one key press
nnoremap <BS> ciw

" Yank more consistent to D and dd commands
nnoremap Y y$

" Resizing window
let GrowWin = { -> "3wincmd + | 5wincmd >" }
let ShrinkWin = { -> winnr("j")==winnr() ? "5wincmd <" : "3wincmd - | 5wincmd <" }
nnoremap <A-+> :<C-r>=GrowWin()<CR><CR>
nnoremap <A--> :<C-r>=ShrinkWin()<CR><CR>

" Yank word under cursor
nnoremap <C-Insert> yiw

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" To map <Esc> to exit terminal-mode: >
tnoremap <Esc>       <C-\><C-n>
tnoremap <LeftMouse> <C-\><C-n>

" Line bubbling, key mapping leant to scrolling keys C-e C-y
nnoremap <A-y> <cmd>move .+1<CR>==
nnoremap <A-e> <cmd>move .-2<CR>==
vnoremap <A-y> :move '>+1<CR>==gv=gv
vnoremap <A-e> :move '<-2<CR>==gv=gv

nnoremap <A-o> :bprevious<CR>
nnoremap <A-i> :bnext<CR>

nnoremap <silent> + <cmd>FF<CR>
nnoremap <silent> - <cmd>FR<CR>

" command line abbreviations
cnoremap <expr> <A-.> expand("%:h")..g:slash
cnoremap <expr> <A-,> $USERPROFILE..g:slash..'vimfiles'..g:slash
cnoreabbrev <expr> vimgrep  (getcmdtype() ==# ':' && getcmdline() =~# '^vimgrep')  ? 'silent vimgrep'  : 'vimgrep'
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> make  (getcmdtype() ==# ':' && getcmdline() =~# '^make')  ? 'silent make'  : 'make'

" Living with QWERTZ keyboards
execute "set langmap+=\<Char-196>}"
execute "set langmap+=\<Char-246>["
execute "set langmap+=\<Char-228>]"
execute "set langmap+=\<Char-214>{"

nnoremap <C-j> <cmd>cnext<CR>
nnoremap <C-k> <cmd>cprevious<CR>
" Living with QWERTZ keyboards
nnoremap <Char-252> <cmd>cnext<CR>
nnoremap <Char-220> <cmd>cprevious<CR>

" By default, <c-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> :nohlsearch<cr>:diffupdate<cr>:redraw!<cr>
imap <C-l> <Esc><C-l>

" Type a word, press below key sequence and "Enclose" `current` (word) {bang}!
inoremap <C-s>" <C-o>b"<Esc>ea"
inoremap <C-s>' <C-o>b'<Esc>ea'
inoremap <C-s>` <C-o>b`<Esc>ea`
inoremap <C-s>) <C-o>b(<Esc>ea)
inoremap <C-s>] <C-o>b[<Esc>ea]
inoremap <C-s>} <C-o>b{<Esc>ea}

let g:vim_home = expand('<sfile>:p:h')
let g:slash = exists('&shellslash') ? '\' : '/'

" set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "!"

" quick note taking
nnoremap <expr> <Leader>n ":drop "..strftime("~/Documents/Notes/note-%d-%m-%y.txt".."<CR>:setfiletype markdown<CR>")

" toggle options
nnoremap <Leader>os <cmd>setlocal invspell spell?<CR>
nnoremap <Leader>op <cmd>setlocal invpaste paste?<CR>
nnoremap <Leader>or <cmd>setlocal invrelativenumber<CR>
nnoremap <Leader>ow <cmd>setlocal invwrap<CR>
nnoremap <Leader>og :<C-u>set grepprg=<C-r>=escape(&grepprg, ' ')<CR>

" CUA tag movement
nnoremap <A-right> g<C-]>
nnoremap <A-left> <C-t>

" Substitute command
nnoremap <Leader>s :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <Leader>s :s///gI<Left><Left><Left><Left>

" commands
nnoremap <Leader>e :edit <C-r>=expand("%:h")..g:slash<CR>
nnoremap <Leader>f :find *
nnoremap <Leader>b :buffer<Space>
nnoremap <Leader>t :tjump /

" quickfix
function! s:ToggleQuickfix()
  let is_open = v:false
  windo if &buftype== "quickfix" | let is_open = v:true | endif
  if is_open == v:false
    if winnr("$") == 1 && &columns >= 140
      vert copen
      wincmd =
      wincmd H
      wincmd l
    else
      botright copen
    endif
  else
    if (winnr("$") == 1) && (&buftype=="quickfix")
      buffer #
    else
      cclose
      wincmd p
    endif
  endif
endfunction
nnoremap <Leader>q <cmd>call <SID>ToggleQuickfix()<CR>
nnoremap <Leader>c :clist!<CR>

" zoom current buffer in seperate tab
nnoremap <Leader><Tab> <cmd>tabnew<CR>

let g:ft2glob = { 'c':'*.[ch]$', 'vim':'*.vim', 'py':'*.py$', 'cmake':'*cmake*' }
let LsFilter = { ft -> has_key(g:ft2glob, ft) ? g:ft2glob[ft] : '*.*'}
nnoremap <expr> <Leader>v ':silent vimgrep /'..expand("<cword>")..'/ '..expand("%:h")..g:slash..LsFilter(&ft)

command! -nargs=0 IC :set   ignorecase nosmartcase
command! -nargs=0 CS :set noignorecase nosmartcase
command! -nargs=0 SC :set   ignorecase  smartcase

augroup vimrc
  autocmd!
  " Reload changed buffers. :checktime relies on 'autoread'.
  autocmd WinEnter        *    checktime

  " Choose color theme dependent on term type
  autocmd VimEnter        *    execute "colorscheme "..( (&term == "builtin_gui") ? "twotone" : "apollo" )

  " Popup quickfix window after make with errros
  " autocmd QuickFixCmdPost make botright cwindow
augroup END

let g:term = &term
syntax on

runtime plugins.vim

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:

