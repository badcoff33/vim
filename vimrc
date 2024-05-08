" Vim resource file
"
" New Vim features are nicly tracked on this site:
"   https://www.arp242.net/vimlog/
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

let g:vim_home = expand('<sfile>:p:h')

let AppendSep = { dir -> empty(dir) ? "" : dir .. expand("/") }

filetype plugin on
filetype indent on

set autoread
set autowrite
set autowriteall
set belloff=all
set clipboard=
set expandtab
set fillchars=eob:\ ,
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
set nopaste
set report=0
set updatetime=300
set ruler
set selection=exclusive
set selectmode=
set sessionoptions=buffers,tabpages,winsize
set shiftwidth=4
set shortmess-=S " Yes, search count please
set shortmess-=f " long form for file info
set showmatch matchtime=1
set showtabline=1
set signcolumn=yes
set tabstop=4
set termguicolors

" limit number of suggestions of z=
set dictionary=spell
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
set nowrapscan

set undofile
execute 'set undodir=' .. getenv('TEMP')

" Insert mode completion
set complete=.,w
set noshowfulltag
set completeopt=menu,longest
set pumheight=7

" Command line completion
set wildmenu
set wildoptions=pum,tagfile
set wildmode=full:lastused
set nowildignorecase
set wildignore+=*.*~,*.o,TAGS
" Mapping for text/abbrev completions
set wildcharm=<C-n>
cmap <Tab> <C-n>
cmap <S-Space> <C-]>

" How to handle search for tags
set tagcase=match

" Tune the diff feature for my needs.
set diffopt=internal,algorithm:minimal,context:8,vertical,iwhite,filler,closeoff
" When starting in 'diff' mode, go full screen.
if &diff
    set columns=999 lines=999
endif

" close special windows
nnoremap <Esc> <Cmd>helpclose<CR><Cmd>cclose<CR><C-w>z

" Consistent cursor movement
noremap! <A-Left> <Home>
noremap! <A-Right> <End>
nnoremap <A-Left> <Home>
nnoremap <A-Right> <End>
xnoremap <A-Left> 0
xnoremap <A-Right> $
" yank/paste clipoard: b/c most laptop keyboards suck
vnoremap <C-CR> "*y
nnoremap <C-CR> "*yiw
nnoremap <A-CR> "*P
cnoremap <A-CR> <C-r>*

" By every next or prev match, expand fold
nnoremap n nzv
nnoremap N Nzv

" Yank more consistent to D and dd commands
nnoremap Y y$

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

" Line bubbling, key mapping leant to scrolling keys C-e C-y
nnoremap <A-e> :move .-2<CR>==
vnoremap <A-e> :move '<-2<CR>==gv=gv
nnoremap <A-y> :move .+1<CR>==
vnoremap <A-y> :move '>+1<CR>==gv=gv

" Surfing the quickfix matches
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>
nnoremap + :cnext<CR>
nnoremap - :cprevious<CR>
" Surfing the tag stack
nnoremap <A-k> g<C-]>zz
nnoremap <A-j> <C-t>zz

" By default, <C-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> <Cmd>nohlsearch<CR><Cmd>diffupdate<CR><Cmd>redraw!<CR>:checktime<CR>
imap <C-l> <Esc><C-l>

" Kill whitespace after abbrev expansion
" Example:  iabbrev () ()<Left><C-r>=AbbrevKiller(getchar(0))<CR>
let AbbrevKiller = { c ->  nr2char(c) =~ '\s' ? '' : nr2char(c) }

cnoreabbrev <expr> vimgrep  (getcmdtype() ==# ':' && getcmdline() =~# '^vimgrep') ? 'silent vimgrep ' .. expand('<cword>') .. ' **' : 'vimgrep'
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> make  (getcmdtype() ==# ':' && getcmdline() =~# '^make')  ? 'silent make'  : 'make'
cnoreabbrev <expr> T  (getcmdtype() ==# ':' && getcmdline() =~# '^T')  ? 'tjump'  : 'T'
cnoreabbrev <expr> F  (getcmdtype() ==# ':' && getcmdline() =~# '^F')  ? 'find'  : 'F'
cnoreabbrev <expr> E  (getcmdtype() ==# ':' && getcmdline() =~# '^E')  ? ('edit ' .. expand("%:h") .. expand("/"))  : 'E'
cnoreabbrev <expr> B  (getcmdtype() ==# ':' && getcmdline() =~# '^B')  ? 'buffer'  : 'B'

" Type a word, press below key sequence and "Enclose" `current` (word), {bang}
" there you go!
inoremap <C-s>" <C-o>b"<C-o>e<Right>"
inoremap <C-s>' <C-o>b'<C-o>e<Right>'
inoremap <C-s>` <C-o>b`<C-o>e<Right>`
inoremap <C-s>) <C-o>b(<C-o>e<Right>)
inoremap <C-s>] <C-o>b[<C-o>e<Right>]
inoremap <C-s>} <C-o>b{<C-o>e<Right>}
nmap <C-s> i<C-s>

" Leader key mappings
let mapleader = " "
let maplocalleader = "s"

" Substitute command
nnoremap <Leader>s :%s/\V//gI<Left><Left><Left><Left>
vnoremap <Leader>s :s/\V//gI<Left><Left><Left><Left>

" Check indents
nnoremap <Leader>. <Cmd>set invcursorcolumn<CR>

" Quick access on current buffer's directory
nnoremap <Leader>e :edit <C-r>=AppendSep(expand("%:h"))<CR>
cnoremap <expr> <C-r>. expand("%:h") .. expand("/")

let g:ft_to_glob = { 'c':'*.[ch]', 'vim':'*.vim', 'py':'*.py$', 'cmake':'*cmake*' }
let LsFilter = { ft -> has_key(g:ft_to_glob, ft) ? g:ft_to_glob[ft] : '*.*'}
nnoremap <expr> <Leader>g ':vimgrep /' .. expand("<cword>") .. '/ ' .. AppendSep(expand("%:h")) .. LsFilter(&ft)

command! -nargs=0 IC :set   ignorecase nosmartcase
command! -nargs=0 CS :set noignorecase nosmartcase
command! -nargs=0 SC :set   ignorecase  smartcase

augroup GroupVimrc
  autocmd!
  autocmd FocusLost * try | silent wall | catch /.*/ | endtry
augroup END

let g:term = &term
syntax on

" vim:foldmethod=marker:nofoldenable:
