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
set novisualbell
set noerrorbells
set noswapfile
set nohlsearch
set laststatus=2
set ruler
set showcmd
set showmatch matchtime=1
set showtabline=1

" limit number of suggestions of z=
set spellsuggest=best,10
set spelllang=en_us

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
" keep indent level when Ctrl-U is pressed
set backspace=eol,start,indent

" Search: Some configuration for the search behavior.
set incsearch
if has('nvim')
  set inccommand=split
endif
set magic

" Optional config: if 'smartcase' is active a case sensitive search with
" /\C<text> can be used on demand.
set ignorecase smartcase
"set noignorecase nosmartcase

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
else
  set nowildmenu
  set wildoptions=tagfile
endif
set wildmode=full
set wildignorecase
set wildignore+=*.*~,*.o,TAGS

" Tune the diff feature for my needs.
set diffopt=internal,context:3,vertical,iwhite,filler
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

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" Enclose current visual selectino
vnoremap <Leader>" c"<C-r>-"
vnoremap <Leader>' c'<C-r>-'
vnoremap <Leader>´ c´<C-r>-´
vnoremap <Leader>( c(<C-r>-)
vnoremap <Leader>[ c[<C-r>-]
vnoremap <Leader>{ c{<C-r>-}

" Switch Vim modes
inoremap jj <Esc>

" Terminals
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-Space> <C-\><C-n>
  tnoremap <C-w> <C-\><C-n><C-w>
elseif has('terminal')
  tnoremap <Esc> <C-w>N
  tnoremap <C-Space> <C-w>N
endif

nnoremap <Leader>e :edit <C-r>=expand("%:p:h").g:psep<CR>
nnoremap <Leader>b :buffer<Space>
nnoremap <Leader>f :find<Space>
nnoremap <Leader>m :sil make<Space><Up><CR>
nnoremap <Leader>M :sil make<Space><Up>
nnoremap <Leader>v :sil vimgrep<Space><Up><C-B><C-Right><C-Right><C-Right>
nnoremap <Leader>x :set columns=999 lines=999<CR>

nnoremap <C-Tab>n :tabnew<CR>
nnoremap <C-Tab>o :tabonly<CR>
nnoremap <C-Tab>c :tabclose<CR>

nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>

nnoremap <silent> <Leader>g :let @/="<C-r><C-w>"<CR>:sil grep <C-r><C-w><CR>
nnoremap <Leader>G :sil grep<Space><Up>

nnoremap <Leader>r :%s/\C\<\>//g<Left><Left><Left><Left><Left>
nnoremap <Leader>R :%s/\C\<<C-r><C-w>\>//g<Left><Left>
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

nnoremap <Leader>n :nohlsearch<CR>
nnoremap <Leader>oh :set invhlsearch<CR>
nnoremap <Leader>os :setlocal invspell<CR>

cabbrev %% <C-r>=expand("%:h")<CR>

augroup init
  autocmd!
  autocmd VimResized * :wincmd =
  autocmd VimEnter   * :runtime site.vim
  autocmd BufEnter   * :if &ft !~ '^\(vim\|help\)$' | nnoremap <buffer> K g<C-]> | endif
augroup END

if has('nvim')
  set winhighlight=Normal:Normal
endif

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
