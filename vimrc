" Vim resource file
"
" New Vim features are nicly tracked on this site:
"   https://www.arp242.net/vimlog/
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

let g:vim_home = expand('<sfile>:p:h')

let AppendSep = { p -> empty(p) ? "" : p .. expand("/") }

filetype plugin on
filetype indent on

set autoread
set autowrite
set belloff=all
set clipboard=
set expandtab
set hidden
set history=200
set keymodel=
set laststatus=2
set listchars=tab:>-,trail:.,extends:#
set more
set mouse=a
set noerrorbells
set nojoinspaces
set norelativenumber numberwidth=2
set noswapfile
set notimeout
set nottimeout
set novisualbell
set nowrap
set report=0
set updatetime=300
set ruler
set selection=exclusive
set selectmode=
set shiftwidth=4
set shortmess-=S " Yes, search count please
set shortmess-=f " long form for file info
set showmatch matchtime=1
set showtabline=1
set signcolumn=yes
set tabstop=4
set termguicolors

" limit number of suggestions of z=
set spellsuggest=best,10
set spelllang=en_us
set spelloptions=camel

" Set behavior for commands ':cc', ':cn', 'cp', etc.
set switchbuf=usetab,uselast

" keep cursor line away from the upper and lower window border
set scrolloff=0
set scrolljump=1

" make vertical scrolling more smooth
set sidescroll=8
set sidescrolloff=3

" split window behavior
set nosplitbelow
set nosplitright

" folding
set foldmethod=indent
set foldnestmax=1
set nofoldenable

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start
"set whichwrap+=<,>,[,]

" makes selecting text more consistent (at least for me)
set virtualedit=onemore,block

" Search: Some configuration for the search behavior.
set ignorecase smartcase
set incsearch
set hlsearch
set magic
set wrapscan

set undofile
execute 'set undodir=' .. getenv('TEMP')

" Insert mode completion
set complete=.,w
set noshowfulltag
set completeopt=menu

set pumheight=7

" Command line completion
set wildmenu
set wildoptions=pum,tagfile ",fuzzy
set wildmode=full:lastused
set nowildignorecase
set wildignore+=*.*~,*.o,TAGS
" How to handle search for tags
set tagcase=match

" Tune the diff feature for my needs.
set diffopt=internal,algorithm:minimal,context:8,vertical,iwhite,filler,closeoff
" When starting in 'diff' mode, go full screen.
if &diff
    set columns=999 lines=999
endif
command! ShowChanges vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Switching modes
imap jj <Esc>

" expand abbrevs
imap <C-Space> <C-]>
cnoremap <C-Space> <C-]>

set wildcharm=<Tab>
cmap <C-N> <Tab>       " works with 'wildcharm'

" close special windows
nnoremap <Esc> <Cmd>helpclose<CR><Cmd>cclose<CR>

" Consistent cursor movement
noremap! <A-Left> <Home>
noremap! <A-Right> <End>
nnoremap <A-Left> <Home>
nnoremap <A-Right> <End>
vnoremap <A-Left> 0
vnoremap <A-Right> $

" Alternative keys to delete words in insert mode
inoremap <C-BS> <C-o>db
inoremap <C-Del> <C-o>de
cnoremap <C-BS> <C-w>
cnoremap <C-Del> <C-Right><C-w>

" By every next or prev match, expand fold
nnoremap n nzv
nnoremap N Nzv

" Yank more consistent to D and dd commands
nnoremap Y y$

" Clipboard
vnoremap <C-CR> "+y
map <C-CR>      "+yiw
map <S-CR>      "+gP
cmap <S-CR>     <C-R>+

" Resizing window
let GrowWin = { -> "3wincmd + | 5wincmd >" }
let ShrinkWin = { -> winnr("j")==winnr() ? "5wincmd <" : "3wincmd - | 5wincmd <" }
nnoremap <A-+> :<C-r>=GrowWin()<CR><CR>
nnoremap <A--> :<C-r>=ShrinkWin()<CR><CR>

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" To map <Esc> to exit terminal-mode: >
tnoremap <Esc>       <C-\><C-n>

" Line bubbling, key mapping leant to scrolling keys C-e C-y
nnoremap <A-e> :move .-2<CR>==
vnoremap <A-e> :move '<-2<CR>==gv=gv
nnoremap <A-y> :move .+1<CR>==
vnoremap <A-y> :move '>+1<CR>==gv=gv

nnoremap <A-o> :bprevious<CR>
nnoremap <A-i> :bnext<CR>

" Abbreviations {{{
cnoreabbrev <expr> vimgrep  (getcmdtype() ==# ':' && getcmdline() =~# '^vimgrep')  ? 'silent vimgrep'  : 'vimgrep'
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> make  (getcmdtype() ==# ':' && getcmdline() =~# '^make')  ? 'silent make'  : 'make'

" Kill whitespace after abbrev expansion
" Example:  iabbrev () ()<Left><C-r>=Killer(getchar(0))<CR>
let Killer = { c ->  nr2char(c) =~ '\s' ? '' : nr2char(c) }

" }}}

cnoremap <expr> <C-r>~ expand("~/")
cnoremap <expr> <C-r>v expand("~/vimfiles/")
cnoremap <expr> <C-r>d expand("%:h") .. expand("/")
cabbrev <expr> ~ expand("~/")
cabbrev <expr> v expand("~/vimfiles/")
cabbrev <expr> . expand("%:h") .. expand("/")

cmap <C-BS> <C-w>
cmap <C-Del> <C-Right><C-w>

" Surfing the quickfix matches
nnoremap <C-j> <cmd>cnext<CR>
nnoremap <C-k> <cmd>cprevious<CR>

" Move between windows - This is boring {{{
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l
nnoremap <A-k> <C-w>k
nnoremap <A-j> <C-w>j
inoremap <A-h> <Esc><C-w>h
inoremap <A-l> <Esc><C-w>l
inoremap <A-k> <Esc><C-w>k
inoremap <A-j> <Esc><C-w>j
tnoremap <A-h> <Esc><C-w>h
tnoremap <A-l> <Esc><C-w>l
tnoremap <A-k> <Esc><C-w>k
tnoremap <A-j> <Esc><C-w>j
" }}}

" By default, <C-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> <Cmd>nohlsearch<CR><Cmd>diffupdate<CR><Cmd>redraw!<CR><Cmd>checktime<CR>
imap <C-l> <Esc><C-l>

" Type a word, press below key sequence and "Enclose" `current` (word) {bang}!
inoremap <C-s>" <C-o>B"<Esc>ea"
inoremap <C-s>' <C-o>B'<Esc>ea'
inoremap <C-s>` <C-o>B`<Esc>ea`
inoremap <C-s>) <C-o>B(<Esc>ea)
inoremap <C-s>] <C-o>B[<Esc>ea]
inoremap <C-s>} <C-o>B{<Esc>ea}

" Leader key mappings {{{
let mapleader = " "
let maplocalleader = "!"

" toggle options
let OptStr = { opt -> opt .. "=" .. eval("&" .. opt) .. " " }
nnoremap <Leader>oF <cmd>set wildoptions+=fuzzy<CR><cmd>call g:OneLinePopup(OptStr("wildoptions"))<CR>
nnoremap <Leader>of <cmd>set wildoptions-=fuzzy<CR><cmd>call g:OneLinePopup(OptStr("wildoptions"))<CR>
nnoremap <Leader>os <cmd>setlocal invspell<CR><cmd>:call g:OneLinePopup(OptStr("spell") .. OptStr("spelllang"))<CR>
nnoremap <Leader>op <cmd>setlocal invpaste<CR><cmd>call g:OneLinePopup(OptStr("paste"))<CR>
nnoremap <Leader>or <cmd>setlocal invrelativenumber<CR>
nnoremap <Leader>ow <cmd>setlocal invwrap<CR>
nnoremap <Leader>ol <cmd>setlocal invlist<CR><cmd>call g:OneLinePopup(OptStr("list") .. OptStr("listchars"))<CR>
nnoremap <Leader>og :<C-u>set grepprg=<C-r>=escape(&grepprg, ' ')<CR>

" Substitute command
nnoremap <Leader>s :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <Leader>s :s///gI<Left><Left><Left><Left>

nnoremap <Leader>b :buffer<Space>
nnoremap <Leader>e :call g:OneLinePopup(getcwd())<CR>:edit <C-r>=AppendSep(expand("%:h"))<CR>
nnoremap <Leader>v :edit <C-r>=expand("~/vimfiles/")<CR>
nnoremap <Leader>f :find<Space>*
nnoremap <Leader>d <cmd>bdelete<CR>

" Leader-t space
nnoremap <Leader>tt <Cmd>tab split<CR>
nnoremap <Leader>tn <Cmd>tabnew<CR>
nnoremap <Leader>tc <Cmd>tabclose<CR>

" Leader-c space
nnoremap <silent> <Leader>c- <Cmd>colder<CR>
nnoremap <silent> <Leader>c+ <Cmd>cnewer<CR>
nnoremap <Leader>cn <Cmd>cnext<CR>
nnoremap <Leader>cN <Cmd>cprevious<CR>
nnoremap <Leader>cc <Cmd>cc<CR>
nnoremap <Leader>cf <Cmd>cfirst<CR>
nnoremap <Leader>cl <Cmd>clast<CR>

let g:ft_to_glob = { 'c':'*.[ch]$', 'vim':'*.vim', 'py':'*.py$', 'cmake':'*cmake*' }
let LsFilter = { ft -> has_key(g:ft_to_glob, ft) ? g:ft_to_glob[ft] : '*.*'}
nnoremap <expr> <Leader>g ':silent vimgrep /' .. expand("<cword>") .. '/ ' .. AppendSep(expand("%:h")) .. LsFilter(&ft)

" }}}

command! -nargs=0 IC :set   ignorecase nosmartcase
command! -nargs=0 CS :set noignorecase nosmartcase
command! -nargs=0 SC :set   ignorecase  smartcase

augroup GroupVimrc " {{{
  autocmd!
  autocmd FocusLost * try | silent wall | catch /.*/ | endtry
  autocmd BufNewFile .vimrc execute "0read" g:vim_home.."\\templates\\local_vimrc"
  autocmd DirChanged global if filereadable(".vimrc") | call g:OneLinePopup("local .vimrc") | endif
  autocmd WinNew * if (&buftype == "help") | wincmd T | endif
augroup END " }}}

let g:term = &term
syntax on

" vim:foldmethod=marker:nofoldenable:

