" Vim resource file
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on

" Even on Windows, this works best
behave xterm
set clipboard=

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set history=200
set belloff=all
set novisualbell
set noerrorbells
set noswapfile
set hlsearch
set laststatus=2
set ruler
set showcmd
set showmatch matchtime=1
set showtabline=1

" limit number of suggestions of z=
set spellsuggest=best,10
set spelllang=en_us
if exists('&spelloptions')
  set spelloptions=camel
endif

" Read changed files automatically if they are changed in the background
set autoread

" Allow modified files to flip in background, without a write.
set hidden

" Use open buffer when commands like ":cc", ":cn", "cp", etc. were used
set switchbuf=useopen

" keep cursor line away from the upper and lower window border
set scrolloff=2
set scrolljump=1

" make vertical scrolling more smooth
set sidescroll=8
set sidescrolloff=3

" window behavior
set splitbelow
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
" keep indent level when Ctrl-U is pressed
set backspace=eol,start,indent

if has ('jumpoptions')
  " New option is coming for Neovim/Vim
  set jumpoptions=stack
endif

if (has("termguicolors"))
  set termguicolors
  syntax on
endif

" Search: Some configuration for the search behavior.
set incsearch
if has('nvim')
  set inccommand=nosplit
endif
set magic

" Optional config: if 'smartcase' is active a case sensitive search with
" /\C<text> can be used on demand.
set noignorecase nosmartcase

let s = split(&runtimepath, ',')
for d in s
  if isdirectory(d . '/backup')
    set backup
    execute 'set backupdir=' . d . '/backup'
    set wildignore+=*/backup/*
    break
  endif
endfor

for d in s
  if isdirectory(d . '/undo')
    set undofile
    execute 'set undodir=' . d . '/undo'
    set wildignore+=*/undo/*
    break
  endif
endfor

" Insert mode completion
set complete=.,w
if !has('nvim')
  set completeopt=menu
else
  set showfulltag
  set completeopt=menu
endif
set pumheight=10
if has('nvim')
  set pumblend=10
endif

" Command line completion
if has ('nvim')
  set wildmenu
  set wildoptions=pum,tagfile
  set wildmode=full " works best with 'completeopt'=menu
else
  set wildoptions=tagfile
  set nowildmenu wildmode=full
  "set wildmenu
endif
set wildignorecase
set wildignore+=*.*~,*.o,TAGS
" How to handle search for tags
set tagcase=smart

" Tune the diff feature for my needs.
set diffopt=internal,algorithm:minimal,context:3,vertical,iwhite,filler
" When starting in 'diff' mode, go full screen.
if &diff
  set columns=999 lines=999
endif

if has('unix')
  let g:psep = '/'
else
  let g:psep = '\'
endif

" Netrw variables
let g:netrw_use_errorwindow = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "s"

" Switch to normal mode 
inoremap <C-Enter> <Esc>

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" Enclose current visual selection
vnoremap <Leader>" c"<C-r>-"<Esc>
vnoremap <Leader>' c'<C-r>-'<Esc>
vnoremap <Leader>` c`<C-r>-`<Esc>
vnoremap <Leader>( c(<C-r>-)<Esc>
vnoremap <Leader>[ c[<C-r>-]<Esc>
vnoremap <Leader>{ c{<C-r>-}<Esc>

autocmd TerminalOpen * :nnoremap <buffer> <CR> :cbuffer<CR>:bwipe<CR>

inoremap <expr> <C-Space> pumvisible() ? "\<C-]>" : "\<C-x>\<C-]>"
inoremap <C-S-Space> <C-p>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <C-tab> <C-v><tab>
" Terminals
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-w> <C-\><C-n><C-w>
elseif has('terminal')
  tnoremap <Esc> <C-w>N
  tnoremap <S-Ins> <C-w>"*
endif

nnoremap <Leader>s :wa<CR>
nnoremap <Leader>e :edit <C-r>=expand("%:p:h")..g:psep<CR>
nnoremap <Leader>x :terminal ++close explorer <C-r>=expand("%:p:h")<CR><CR>
nnoremap <Leader>b :buffer<Space>
nnoremap <Leader>f :find<Space>
nnoremap <Leader>m :sil make<Space><Up><CR>
nnoremap <Leader>M :sil make<Space><Up>
nnoremap <Leader>v :sil vimgrep<Space><Up><C-B><C-Right><C-Right><C-Right>
nnoremap <Leader>X :set columns=999 lines=999<CR>
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>te :tabedit %<CR>
nnoremap <Leader>to :tabonly<CR>
nnoremap <Leader>tc :tabclose<CR>

nnoremap <C-l> :cnewer<CR>
nnoremap <C-h> :colder<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>
nnoremap <f4> :cnext<CR>
nnoremap <S-f4> :cprevious<CR>
nnoremap <C-f4> :cfirst<CR>

nnoremap <A-.> :tjump /<C-r><C-w>
nnoremap <A-,> :cnext<CR>
nnoremap <A-S-,> :cprev<CR>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

if executable("rg")
  " Using links? Ripgrep supports this by th option '--follow'
  set grepprg=rg\ --vimgrep\ -tc\ -tcpp\ -tcmake\ -g\ !cmake\ $*\ . 
  set grepformat=%f:%l:%c:%m
elseif executable("grep")
  set grepprg=grep\ -Hnr\ --exclude=cmake\ $* \.
  set grepformat=%f:%l:%m
endif
nnoremap <Leader>g :silent grep <C-r><C-w>

command! -nargs=1 -complete=file WriteOptions :call writefile(['set grepprg='..escape(&grepprg, ' \'), 'set path='..&path], '<args>', 'a')

nnoremap <Leader>r :%s/\C\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>r :s/\C\<\>//g<Left><Left><Left><Left><Left>

" Keys '[' and ']' is hard to reach on some non-english keyboards. Here is a way to
" record a macro with those keys and make macro playback easy as possible.
nnoremap <C-S-left> :let @x=input("Go back ('[[', '[s', '[d'): ", "")<CR>
nnoremap <C-S-right> :let @y=input("Go forward (']]', ']s', ']d'): ", "")<CR>
nnoremap <S-left> @x
vnoremap <S-left> @x
nnoremap <S-right> @y
vnoremap <S-right> @y
let @x = "{"
let @y = "}"

nnoremap <Leader><Leader> :nohlsearch<CR>
nnoremap <Leader>oh :set invhlsearch hlsearch?<CR>
nnoremap <Leader>oi :set invignorecase ignorecase?<CR>
nnoremap <Leader>os :setlocal invspell spell?<CR>
nnoremap <Leader>og :set grepprg=<C-r>=escape(input("set greprg:", &grepprg), ' ')<CR><CR>

" command completion needs terminating backslash (sorry, Windows)
cnoremap <C-CR> \
cnoremap <C-r>. <C-r>=expand("%:h")..g:psep<CR>
if has('nvim')
cnoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
cnoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
endif

augroup init
  autocmd!
  autocmd VimResized * :wincmd =
  autocmd VimEnter   * :runtime site.vim
  autocmd BufEnter   * :if &ft !~ '^\(vim\|help\)$' | nnoremap <buffer> K g<C-]> | endif
  if has('nvim')
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 350)
  endif
augroup END

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
