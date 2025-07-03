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
set completeopt=menuone
set dictionary=spell
set diffopt=internal,algorithm:minimal,context:9999,vertical,iwhite,filler,closeoff
if has("patch-9.1.1243")
  set diffopt+=inline:word
endif
set expandtab
set foldcolumn=1
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
set scrolloff=4
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
set updatetime=2000
set virtualedit=onemore,block   " makes selecting text more consistent
set visualbell
set whichwrap+=<,>,[,]          " specify keys that move to next/previous line
set wildchar=<Tab>
set wildcharm=<Tab>
set wildignore+=*.*~,*.o,TAGS
set wildmenu wildmode=full:lastused "set nowildmenu wildmode=list:lastused,full
set wildoptions=pum,fuzzy
set wrapscan                    " wrap search at EOB or BOB

if has("win32") || has("win64")
    " a fix for :! with redirection (see zip.vim)
    set shellxquote=
    set shellquote=
endif

execute 'set thesaurus=' .. $VIMHOME .. '/thesaurus/english.txt'

" Do not clutter registers
nnoremap x "_x
nnoremap X "_X

" Consistent cursor movement
noremap! <A-Left> <Home>
noremap! <A-Right> <End>
nnoremap <A-Left> <Home>
nnoremap <A-Right> <End>
xnoremap <A-Left> 0
xnoremap <A-Right> $

" Context aware movement
nnoremap <expr> <A-Down> (&diff) ? "]czz" : (&ft == "help") ? ":call search('[\\*}\|][a-zA-Z-_:]\\+[\\*\\|]', 'W')<CR>" :  ":call feedkeys(']]')<CR>"
nnoremap <expr> <A-Up>   (&diff) ? "[czz" : (&ft == "help") ? ":call search('[\\*}\|][a-zA-Z-_:]\\+[\\*\\|]', 'bW')<CR>" : ":call feedkeys('[[')<CR>"

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
" Overrule default behaviour of Ctrl-W_q (close Vim if last window)
nnoremap <C-w>q :botright copen<CR>
nnoremap <C-w><C-q> :close<CR>

" By default, <C-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> <Cmd>nohlsearch<CR><Cmd>diffupdate<CR><Cmd>redraw!<CR>:checktime<CR>
imap <C-l> <Esc><C-l>

" CUA survival mappings
inoremap <C-BS> <C-w>
inoremap <C-Del> <C-o>dw
cnoremap <C-BS> <C-w>
cnoremap <C-Del> <C-Right><C-w>
nnoremap <C-Ins> "*yiw
inoremap <C-Ins> <C-o>"*yiw

" Type a word, press below key sequence and "Enclose" `current` (word), {bang}
" there you go!
inoremap <C-s>" <C-o>cb"<C-r>""
inoremap <C-s>' <C-o>cb'<C-r>"'
inoremap <C-s>` <C-o>cb`<C-r>"`
inoremap <C-s>) <C-o>cb(<C-r>")
inoremap <C-s>] <C-o>cb[<C-r>"]
inoremap <C-s>} <C-o>cb{<C-r>"}
inoremap <C-s><C-s>" <C-o>cB"<C-r>""
inoremap <C-s><C-s>' <C-o>cB'<C-r>"'
inoremap <C-s><C-s>` <C-o>cB`<C-r>"`
inoremap <C-s><C-s>) <C-o>cB(<C-r>")
inoremap <C-s><C-s>] <C-o>cB[<C-r>"]
inoremap <C-s><C-s>} <C-o>cB{<C-r>"}
" Open and close pairs
inoremap ^" ""<Left>
inoremap ^' ''<Left>
inoremap ^( ()<Left>
inoremap ^[ []<Left>
inoremap ^{ {}<Left>

" Leader key mappings
let mapleader = " "
let maplocalleader = "s"

" fast forward: it takes two
nnoremap <expr> <Leader><Space> "/" .. nr2char(getchar()) .. nr2char(getchar()) .. "\n"

" Substitute command
nnoremap <Leader>s :%s/\C//cgI<C-b><Right><Right><Right>
vnoremap <Leader>s :s/\C//gI<Left><Left><Left><Left><Left><Left>

" Check indents
nnoremap <Leader><bar> <Cmd>set invcursorcolumn<CR>

" Quick access on current buffer's directory
nnoremap <Leader>e :edit <C-r>=DirName("%:h")<CR>
cnoremap <expr> <C-r>. DirName("%:h")
nnoremap <expr> <Leader>d ":edit " .. DirName("%:h") .. "<CR>"
nnoremap <expr> <Leader>D ":Open " .. DirName('%:h') .. "<CR>"

let g:ft_to_glob = { 'c':'*.[ch]', 'vim':'*.vim', 'py':'*.py$', 'cmake':'*cmake*' }
let LsFilter = { ft -> has_key(g:ft_to_glob, ft) ? g:ft_to_glob[ft] : '*.*'}
nnoremap <expr> <Leader>* ':vimgrep /' .. expand("<cword>") .. '/ ' .. DirName("%:h") .. LsFilter(&ft)

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

" Bsic terminal mappings
tnoremap <Esc>     <C-w>N
tnoremap <C-Tab>   <C-w>gt
tnoremap <C-S-Tab>   <C-w>gT

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
