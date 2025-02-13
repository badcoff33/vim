" Vim resource file
"
" New Vim features are nicly tracked on this site:
"   https://www.arp242.net/vimlog/
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

let $VIMHOME = substitute(expand('<sfile>:p:h'), '\', '/', 'g')

let DirName = { dir -> empty(expand(dir)) ? "" : expand(dir) .. expand("/") }

filetype plugin on
filetype indent on

set autoread
set autowrite
set autowriteall
set backspace=indent,eol,start  " backspace and cursor keys wrap to previous/next line
set belloff=all
set clipboard=
set complete=.,w
set dictionary=spell
set diffopt=internal,algorithm:minimal,context:8,vertical,iwhite,filler,closeoff
set expandtab
set foldcolumn=0
set foldmethod=indent
set foldnestmax=1
set hidden
set history=200
set hlsearch
set ignorecase smartcase
set incsearch
set jumpoptions=stack
set keymodel=
set laststatus=2
set listchars=tab:>-,trail:.,extends:#
set magic
set messagesopt=hit-enter,history:100
set more
set mouse=a
set noerrorbells
set nofoldenable
set nojoinspaces
set norelativenumber numberwidth=2
set noshowfulltag
set nosplitbelow
set nosplitright
set noswapfile
set notimeout
set nottimeout
set nowildignorecase
set nowrap
set previewpopup=height:10,width:60,highlight:PopupNotification
set pumheight=7
set report=0
set ruler
set scrolljump=1
set scrolloff=12
set selection=exclusive
set selectmode=
set sessionoptions=buffers,tabpages,winsize
set shiftwidth=4
set shortmess-=S                " show match-count
set shortmess-=f                " long form for file info
set showmatch matchtime=1
set showtabline=1
set sidescroll=8
set sidescrolloff=3
set spelllang=en_us
set spelloptions=camel
set spellsuggest=best,10
set switchbuf=usetab,uselast    " Set behavior for commands ':cc', ':cn', 'cp', etc.
set tabstop=4
set tagcase=match
set termguicolors
set undodir=$TEMP
set undofile
set updatetime=500
set virtualedit=onemore,block   " makes selecting text more consistent
set visualbell
set whichwrap+=<,>,[,]          " specify keys that move to next/previous line
set wildcharm=<C-n>
set wildignore+=*.*~,*.o,TAGS
set wrapscan                    " wrap search at EOB or BOB

" Command line completion with popup menu
set wildmenu wildmode=full:lastused wildoptions=pum,fuzzy completeopt=menu
" Command line completion the old fashion way
"set nowildmenu wildmode=list:lastused,full wildoptions=fuzzy  completeopt=menu

execute 'set thesaurus=' .. $VIMHOME .. '/thesaurus/english.txt'

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

" More exact and easy to reach
nmap ' `

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" Move visual line up or down in buffer
vnoremap <C-j> :move '>+1<CR>==gv=gv
vnoremap <C-k> :move '<-2<CR>==gv=gv

" Surfing the quickfix matches
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>

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
let mapleader = " "
let maplocalleader = "S"

" fast forward: it takes two
nnoremap <expr> <Leader><Space> "/" .. nr2char(getchar()) .. nr2char(getchar()) .. "\n"

" Avoid other keyboard/terminal problems
nnoremap + g<C-]>
nnoremap <Leader>+ <C-t>

" Substitute command
nnoremap <Leader>s :%s/\C//cgI<C-b><Right><Right><Right>
vnoremap <Leader>s :s/\C//gI<Left><Left><Left><Left><Left><Left>

" Check indents
nnoremap <Leader><bar> <Cmd>set invcursorcolumn<CR>

" Quick access on current buffer's directory
nnoremap <Leader>e :edit <C-r>=DirName("%:h")<CR>
cnoremap <expr> <C-r>. DirName("%:h")

let g:ft_to_glob = { 'c':'*.[ch]', 'vim':'*.vim', 'py':'*.py$', 'cmake':'*cmake*' }
let LsFilter = { ft -> has_key(g:ft_to_glob, ft) ? g:ft_to_glob[ft] : '*.*'}
nnoremap <expr> <Leader>VD ':vimgrep /' .. expand("<cword>") .. '/ ' .. DirName("%:h") .. LsFilter(&ft)
nnoremap <Leader>VV :vimgrep /<C-R><C-w>/ %

" yank/paste clipoard: b/c most laptop keyboards suck
vnoremap <Leader>y "*y
nnoremap <Leader>y "*yiw
nnoremap <Leader>y "*yiw
nnoremap <Leader>Y "*yy
nnoremap <Leader>p <Cmd>set paste<CR>"*P<Cmd>set nopaste<CR>

" Move it!
inoremap <S-Up>    <Esc><C-w><Up>
inoremap <expr> <S-Down>  (winnr() == winnr('j')) ? "<Esc>:" : "<Esc><C-w><Down>"
inoremap <S-Left>  <Esc><C-w><Left>
inoremap <S-Right> <Esc><C-w><Right>
nnoremap <S-Up>    <C-w><Up>
nnoremap <expr> <S-Down>  (winnr() == winnr('j')) ? ":" : "<C-w><Down>"
nnoremap <S-Left>  <C-w><Left>
nnoremap <S-Right> <C-w><Right>
tnoremap <S-Up>    <C-w><Up>
tnoremap <expr> <S-Down>  (winnr() == winnr('j')) ? "<C-w>N:" : "<C-w>N<C-w><Down>"
tnoremap <S-Left>  <C-w><Left>
tnoremap <S-Right> <C-w><Right>

nnoremap <S-CR> :
inoremap <S-CR> <Esc>:
tnoremap <S-CR> <C-W>:

command! -nargs=0 IgnoreCase    :set   ignorecase nosmartcase
command! -nargs=0 CaseSensetive :set noignorecase nosmartcase
command! -nargs=0 SmartCase     :set   ignorecase   smartcase

augroup GroupVimrc
  autocmd!
  autocmd FocusLost * try | silent wall | catch /.*/ | endtry
  autocmd BufNewFile .vimrc execute ":0read " expand($VIMHOME .. "/templates/local_vimrc.vim")
augroup END

let g:term = &term
syntax on

" nice presentation of v:errors, filled by assert_* functions
command! -nargs=0 ShowLoggedAsserts for e in v:errors | echo e | endfor
command! -nargs=0 ClearLoggedAsserts let v:errors = []

" vim:foldmethod=marker:nofoldenable:
