" Vim resource file
"
" New Vim features are nicly tracked on this site:
"   https://www.arp242.net/vimlog/
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

let g:vim_home = expand('<sfile>:p:h')

let DirName = { dir -> empty(expand(dir)) ? "" : expand(dir) .. expand("/") }

filetype plugin on
filetype indent on

set autoread
set autowrite
set autowriteall
set belloff=all
set clipboard=
set expandtab
set fillchars=eob:\ ,vert:\|
set hidden
set history=200
set jumpoptions=stack
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
set visualbell
set nowrap
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
set signcolumn=no
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
set scrolloff=12
set scrolljump=1

" make vertical scrolling more smooth
set sidescroll=8
set sidescrolloff=3

" split window behavior
set nosplitbelow
set nosplitright

" folding
set foldcolumn=0
set foldmethod=indent
set foldnestmax=1
set nofoldenable

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start
" specify keys that move to next/previous line
set whichwrap+=<,>,[,]

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

if v:true
    " Command line completion with popup menu
    set wildmenu wildmode=full:lastused wildoptions=pum,tagfile,fuzzy
else
    " Command line completion the old fashion way
    set nowildmenu wildmode=longest:list,full wildoptions=tagfile,fuzzy
endif
set nowildignorecase
set wildignore+=*.*~,*.o,TAGS
set wildcharm=<C-n>

" How to handle search for tags
set tagcase=match

" Tune the diff feature for my needs.
set diffopt=internal,algorithm:minimal,context:8,vertical,iwhite,filler,closeoff
" When starting in 'diff' mode, go full screen.
if &diff
  set columns=999 lines=999
endif

" close special windows
nnoremap <Esc> <Cmd>helpclose<CR><C-w>z

" Consistent cursor movement
noremap! <A-Left> <Home>
noremap! <A-Right> <End>
nnoremap <A-Left> <Home>
nnoremap <A-Right> <End>
xnoremap <A-Left> 0
xnoremap <A-Right> $

" By every next or prev match, expand fold
nnoremap n nzv
nnoremap N Nzv

" Yank more consistent to D and dd commands
nnoremap Y y$

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" Line bubbling, key mapping leant to scrolling keys C-e C-y
nnoremap <C-j> :move .+1<CR>==
vnoremap <C-j> :move '>+1<CR>==gv=gv
vnoremap <C-k> :move '<-2<CR>==gv=gv
nnoremap <C-k> :move .-2<CR>==

" Surfing the quickfix matches
nnoremap <Leader>+ :cfirst<CR>
nnoremap + :cnext<CR>
nnoremap - :cprevious<CR>

" By default, <C-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> <Cmd>nohlsearch<CR><Cmd>diffupdate<CR><Cmd>redraw!<CR>:checktime<CR>
imap <C-l> <Esc><C-l>

" Survival mappings
inoremap <C-BS> <C-w>
inoremap <C-Del> <C-o>dw
cnoremap <C-BS> <C-w>
cnoremap <C-Del> <C-Right><C-w>

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
let mapleader = "s"
let maplocalleader = "S"

" Make leader accessible in insert and normal mode
imap <C-z> <Esc><Leader>
nmap <C-z> <Leader>

" Substitute command
nnoremap <Leader>s :%s/\C//cgI<C-b><Right><Right><Right>
vnoremap <Leader>s :s/\C//gI<Left><Left><Left><Left><Left><Left>

nnoremap <Leader><Tab> :tabnew<CR>

" Check indents
nnoremap <Leader>. <Cmd>set invcursorcolumn<CR>

" Quick access on current buffer's directory
nnoremap <Leader>e :edit <C-r>=DirName("%:h")<CR>
cnoremap <expr> <C-r>. DirName("%:h")

let g:ft_to_glob = { 'c':'*.[ch]', 'vim':'*.vim', 'py':'*.py$', 'cmake':'*cmake*' }
let LsFilter = { ft -> has_key(g:ft_to_glob, ft) ? g:ft_to_glob[ft] : '*.*'}
nnoremap <expr> <Leader>V ':vimgrep /' .. expand("<cword>") .. '/ ' .. DirName("%:h") .. LsFilter(&ft)
nnoremap <Leader>v :vimgrep /<C-R><C-w>/ %

" yank/paste clipoard: b/c most laptop keyboards suck
vnoremap <Leader>y "*y
nnoremap <Leader>y "*yiw
nnoremap <Leader>y "*yiw
nnoremap <Leader>Y "*yy
nnoremap <Leader>p <Cmd>set paste<CR>"*P<Cmd>set nopaste<CR>

" Move it!
inoremap <S-Up>    <Esc><C-w><Up>
inoremap <S-Down>  <Esc><C-w><Down>
inoremap <S-Left>  <Esc><C-w><Left>
inoremap <S-Right> <Esc><C-w><Right>
nnoremap <S-Up>    <C-w><Up>
nnoremap <S-Down>  <C-w><Down>
nnoremap <S-Left>  <C-w><Left>
nnoremap <S-Right> <C-w><Right>
tnoremap <S-Up>    <C-w><Up>
tnoremap <S-Down>  <C-w><Down>
tnoremap <S-Left>  <C-w><Left>
tnoremap <S-Right> <C-w><Right>

command! -nargs=0 IgnoreCase    :set   ignorecase nosmartcase
command! -nargs=0 CaseSensetive :set noignorecase nosmartcase
command! -nargs=0 SmartCase     :set   ignorecase   smartcase

augroup GroupVimrc
  autocmd!
  autocmd FocusLost * try | silent wall | catch /.*/ | endtry
augroup END

let g:term = &term
syntax on

" vim:foldmethod=marker:nofoldenable:
"

