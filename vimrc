" Vim resource file
"
" New Vim features are nicly tracked on this site:
"   https://www.arp242.net/vimlog/
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on

set termguicolors
set clipboard=unnamed
set selection=inclusive
set mouse=a
set keymodel=
set selectmode=

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set history=200
set belloff=all
set novisualbell
set noerrorbells
set noswapfile
set report=0
set ruler
set showmatch matchtime=1
set showtabline=1
set shortmess-=f " long form for file info
set shortmess-=S " Yes, search count please
set laststatus=2
set relativenumber numberwidth=2

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
inoremap <C-Space> <C-o>

" Yank more consistent to D and dd commands
nnoremap Y y$

" replace current inner word with one key press
nnoremap <BS> ciw

" Yank word under cursor
nnoremap <C-Insert> yiw

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" next/prev match, expand fold and recenter
nnoremap n nzzzv
nnoremap N Nzzzv

" To map <Esc> to exit terminal-mode: >
tnoremap <Esc>       <C-\><C-n>
tnoremap <LeftMouse> <C-\><C-n>

" Line bubbling
nnoremap <A-j> <cmd>move .+1<CR>==
nnoremap <A-k> <cmd>move .-2<CR>==
vnoremap <A-j> :move '>+1<CR>==gv=gv
vnoremap <A-k> :move '<-2<CR>==gv=gv

nnoremap <A-o> :bprevious<CR>
nnoremap <A-i> :bnext<CR>

" command line
cnoremap <expr> <A-.> expand("%:h")..g:path_sep
cnoremap <expr> <A-,> $USERPROFILE..g:path_sep..'vimfiles'..g:path_sep
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> make  (getcmdtype() ==# ':' && getcmdline() =~# '^make')  ? 'silent make'  : 'make'

" Expand abbreviations (without trailing space)
imap <C-CR> <C-]>
cmap <C-CR> <C-]>

nnoremap <char-228> :cnext<cr>
nnoremap <char-246> :cprev<cr>

" By default, <c-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> :nohlsearch<cr>:diffupdate<cr>:redraw!<cr>
imap <C-l> <Esc><C-l>

" Type a word, press below key squence and "Enclose" `current` (word) {bang}!
inoremap <A-Space>" <C-o>db"<C-r>-"
inoremap <A-Space>' <C-o>db'<C-r>-'
inoremap <A-Space>` <C-o>db`<C-r>-`
inoremap <A-Space>) <C-o>db(<C-r>-)
inoremap <A-Space>] <C-o>db[<C-r>-]
inoremap <A-Space>} <C-o>db{<C-r>-}

let g:vim_home = expand('<sfile>:p:h')
let g:path_sep = has('unix') ? '/' : '\'

" set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "+"

""" quick note taking
nnoremap <expr> <Leader>n ":drop "..strftime("~/Documents/Notes/note-%d-%m-%y.txt".."<CR>:setfiletype markdown<CR>")

""" toggle options
nnoremap <Leader>oh :set invhlsearch hlsearch?<CR>
nnoremap <Leader>os :setlocal invspell spell?<CR>
nnoremap <Leader>op :setlocal invpaste paste?<CR>
nnoremap <Leader>ow :setlocal invwrap<CR>
nnoremap <Leader>og :set grepprg=<C-r>=escape(&grepprg, ' ')<CR>

""" CUA tag movement
nnoremap <A-right> g<C-]>
nnoremap <A-left> <C-t>

""" replace command
nnoremap <Leader>r :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <Leader>r :s///gI<Left><Left><Left><Left>

""" commands
nnoremap <Leader>e :edit <C-r>=expand("%:h")..g:path_sep<CR>
nnoremap <Leader>f :find *
nnoremap <Leader>b :buffer<Space>
nnoremap <Leader><C-]> :tjump /

""" quickfix
nnoremap <Leader>c :clist!<CR>
nnoremap <Leader>q :botright copen<CR>
nnoremap <Leader>Q :cclose<CR>

""" zoom current buffer in seperate tab
nnoremap <Leader>t :tabedit %<CR>
nnoremap <Leader>x :tabclose<CR>

""" command line abbreviations
let g:ft2regex = { 'c':'\.[ch]$', 'vim':'vim', 'py':'\.py$', 'cmake':'\(\.cmake\|CMakeLists.txt\)' }
let LsFilter = { ft -> has_key(g:ft2regex, ft) ? g:ft2regex[ft] : ''}
cabbrev <expr> B 'filter /'..LsFilter(&ft)..'/ ls<CR>'

command! -nargs=0 IC :set   ignorecase nosmartcase
command! -nargs=0 CS :set noignorecase nosmartcase
command! -nargs=0 SC :set   ignorecase  smartcase

augroup init
  autocmd!
  " Reload changed buffers. Command rely on 'autoread'. FocusedGained works
  " only on same terminals
  autocmd BufEnter        *    checktime
  autocmd BufEnter        *    if &pvw | setlocal nonu nornu | endif
  autocmd VimEnter        *    execute "colorscheme "..( (&term == "builtin_gui") ? "twotone" : "apollo" )
  autocmd QuickFixCmdPost make botright cwindow
  autocmd QuickFixCmdPost grep botright copen
augroup END

let g:term = &term
syntax on

runtime plugins.vim

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:

