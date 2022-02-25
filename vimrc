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

" limit number of suggestions of z=
set spellsuggest=best,10
set spelllang=en_us,de_de
if exists('&spelloptions')
  set spelloptions=camel
endif

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

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" Yank more consistent to D and dd commands
nnoremap Y y$

" replace current inner word with one key press
nnoremap <BS> ciw

" Window movement
nnoremap <S-Right> <C-w>l
nnoremap <S-Left> <C-w>h
nnoremap <S-Up> <C-w>k
nnoremap <S-Down> <C-w>j
imap     <S-Right> <Esc><S-Right>
imap     <S-Left> <Esc><S-Left>
imap     <S-Up> <Esc><S-Up>
imap     <S-Down> <Esc><S-Down>
tnoremap <S-Right> <C-\><C-n><C-w>l
tnoremap <S-Left>  <C-\><C-n><C-w>h
tnoremap <S-Up>    <C-\><C-n><C-w>k
tnoremap <S-Down>  <C-\><C-n><C-w>j

" To map <Esc> to exit terminal-mode: >
tnoremap <Esc> <C-\><C-n>

" Line bubbling
nnoremap <A-j> <cmd>move .+1<CR>==
nnoremap <A-k> <cmd>move .-2<CR>==
vnoremap <A-j> :move '>+1<CR>==gv=gv
vnoremap <A-k> :move '<-2<CR>==gv=gv

nnoremap <A-+> 3<C-w>+3<C-w>>
nnoremap <A--> 3<C-w>-3<C-w><

nnoremap <A-o> :bprevious<CR>
nnoremap <A-i> :bnext<CR>

nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>
nnoremap n nzzzv
nnoremap N Nzzzv

" By default, <c-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> :nohlsearch<cr>:diffupdate<cr>:redraw!<cr>
imap <C-l> <Esc><C-l>

let PathSep = { -> has('unix')?'/':'\' }

""" make use of german keys
set langmap=ü/,Ü?,ö],Ö[,ä},Ä{

" set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "+"

" "Enclose" `current` (visual) {selection}
vnoremap <Leader>" c"<C-r>-"<Esc>
vnoremap <Leader>' c'<C-r>-'<Esc>
vnoremap <Leader>` c`<C-r>-`<Esc>
vnoremap <Leader>( c(<C-r>-)<Esc>
vnoremap <Leader>[ c[<C-r>-]<Esc>
vnoremap <Leader>{ c{<C-r>-}<Esc>

" "Enclose" `current` (word) {bang}!
nnoremap <Leader>" ciw"<C-r>-"<Esc>
nnoremap <Leader>' ciw'<C-r>-'<Esc>
nnoremap <Leader>` ciw`<C-r>-`<Esc>
nnoremap <Leader>( ciw(<C-r>-)<Esc>
nnoremap <Leader>[ ciw[<C-r>-]<Esc>
nnoremap <Leader>{ ciw{<C-r>-}<Esc>

let g:ft2regex = { 'c':'\.[ch]$', 'vim':'vim', 'py':'\.py$', 'cmake':'\(\.cmake\|CMakeLists.txt\)' }
let LsFilter = { ft -> has_key(g:ft2regex, ft) ? g:ft2regex[ft] : ''}
nnoremap <expr> <Leader>b ':filter /'..LsFilter(&ft)..'/ ls<CR>'

""" quick note taking
nnoremap <expr> <Leader>n ":edit "..strftime("~/Documents/Notes/note-%d-%m-%y.txt".."<CR>:setfiletype markdown<CR>")

""" toggle options
nnoremap <Leader>oh :set invhlsearch hlsearch?<CR>
nnoremap <Leader>os :setlocal invspell spell?<CR>
nnoremap <Leader>op :setlocal invpaste paste?<CR>
nnoremap <Leader>ow :setlocal invwrap<CR>
nnoremap <Leader>og :set grepprg=<C-r>=escape(&grepprg, ' ')<CR>

""" replace command
nnoremap <Leader>r :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <Leader>r :s///gI<Left><Left><Left><Left>

""" quickfix
nnoremap <Leader>c :clist!<CR>

""" command line
cnoremap <expr> <C-r>. expand("%:h")..PathSep()
cnoremap <expr> <C-r>, $USERPROFILE..PathSep()..'vimfiles'..PathSep()
cabbrev <expr> E 'edit '..expand("%:p:h")..PathSep()
cabbrev <expr> V 'edit '..$USERPROFILE..PathSep()..'vimfiles'..PathSep()

command! -nargs=0 IC :set   ignorecase nosmartcase
command! -nargs=0 CS :set noignorecase nosmartcase
command! -nargs=0 SC :set   ignorecase  smartcase

" Description: Some minor extensions to run ripgrep or Windows own findstr.
" Ironically, because this set 'grepprg', right now grep iteslf is not used.
" Most of the time I work On Windows only.

let g:rg_glob_patterns = {
      \ 'c': '-g *.[ch]',
      \ 'cpp': '-g *.[ch]',
      \ 'vim': '-g *.vim -g *vimrc',
      \ 'asm': '-g *.850',
      \ 'py': '-g *.py',
      \ 'cmake': '-g *.cmake -g CMakeLists.txt',
      \ }

let g:findstr_glob_patterns = {
      \ 'c': '*.c *.h',
      \ 'cpp': '*.c* *.h*',
      \ 'vim': '*vimrc *.vim',
      \ 'asm': '*.s *.asm *.850',
      \ 'py': '*.py',
      \ 'cmake': '*.cmake CMakeLists.txt'
      \ }

let RgGlob = {ft -> has_key(g:rg_glob_patterns, ft) ? g:rg_glob_patterns[ft] : '-g *.*'}
let FindstrGlob = {ft -> has_key(g:findstr_glob_patterns, ft) ? g:findstr_glob_patterns[ft] : '*.*'}

if executable("rg")
  " Using links? Ripgrep supports this by th option '--follow'
  set grepprg=rg\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  nnoremap <expr> <Leader>g ':silent grep ' . RgGlob(&ft) . ' ' . expand('<cword>')
elseif executable("findstr")
  set grepprg=findstr\ /S\ /N
  set grepformat=%f:%l:%m
  nnoremap <expr> <Leader>g ':silent grep ' . expand('<cword>') . ' ' . FindstrGlob(&ft)
endif

if executable("rg")
  " find any file
  command! -nargs=+ Glob :term rg --files -g <args> .
else
  command! -nargs=+ Glob :term dir /S /B <args>
endif

augroup init
  autocmd!
  autocmd BufReadPost  * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd BufEnter     * if &pvw | setlocal nonu nornu | endif
  autocmd TerminalOpen * setlocal signcolumn=no nonumber norelativenumber foldcolumn=0
  autocmd VimEnter     * runtime plugins.vim
  autocmd VimResized   * wincmd =
  " Reload changed buffers. Command rely on 'autoread'. FocusedGained works only on same terminals
  autocmd FocusGained * :checktime
augroup END

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
