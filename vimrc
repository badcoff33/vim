" Vim resource file
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on

" Even on Windows, this works best
behave xterm

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set history=200
set visualbell
set noerrorbells
set viminfo='50,<1000,s100,:100

" limit number of suggestions of z= 
set spellsuggest=best,10
set spelllang=en_us

" Read changed files automatically if they are changed in the background
set autoread

" Allow modified files to flip in background, without a write.
set hidden

" keep cursor line away from the upper and lower window border
set scrolloff=3
set scrolljump=1

" make vertical scrolling more smooth
set sidescroll=8
set sidescrolloff=3

" window behavior
set nosplitbelow
set splitright
set noequalalways

" folding
set foldmethod=indent
set foldnestmax=1
set nofoldenable

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
set gdefault

" Optional config: if 'smartcase' is active a case sensitive search with
" /\C<text> can be used on demand.
set ignorecase smartcase
"set noignorecase nosmartcase

set noswapfile

let s = split(&runtimepath, ',')
for d in s
  if isdirectory(d . '/backup')
    set backup
    execute 'set backupdir=' . d . '/backup'
    break
  endif
endfor

for d in s
  if isdirectory(d . '/undo')
    set undofile
    execute 'set undodir=' . d . '/undo'
    break
  endif
endfor

" Configured content and style of the statusline
set laststatus=2
set ruler
set showcmd
set showmatch matchtime=1

" Insert mode completion
set complete=.,w
set completeopt=menu
set pumheight=10
if has('nvim')
  set pumblend=10
endif

" Command line completion
if has ('nvim')
  set wildmenu wildmode=full wildoptions=pum,tagfile
else
  set nowildmenu wildmode=list:lastused,full wildoptions=tagfile
endif
set wildignorecase
set wildignore=*.*~

set showtabline=1
set sessionoptions=buffers,tabpages,winsize

" Write all files before any ':make' command
set autowrite

" Tune the diff feature for my needs.
set diffopt=context:3,vertical,iwhite,filler

if exists('+shellslash')
  if &shellslash
    let g:psep = '/'
  else
    let g:psep = '\'
  endif
else
  let g:psep = '/'
endif

" plugin variables 

let g:netrw_use_errorwindow = 0
let g:netrw_liststyle = 0

" commands

command! -nargs=1 Wipe bufdo if expand("%") =~ '.*<args>.*' | bw | endif | bprevious

" autocommands 

augroup init
  autocmd!
  autocmd VimResized * wincmd =
  " load local site file for machine dependent configs
  autocmd VimEnter * runtime site.vim
augroup END

" mappings 

" Set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "s"

" increment/decrement numbers blockwise 
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" surround visual selection with double quote ("), quote ('), backtick (`),
" parentheses (), braces {} and brackets []
nnoremap <Leader>" bi"<Esc>ea"<Esc>
nnoremap <Leader>' bi'<Esc>ea'<Esc>
nnoremap <Leader>` bi`<Esc>ea`<Esc>
nnoremap <Leader>( bi(<Esc>ea)<Esc>
nnoremap <Leader>[ bi[<Esc>ea]<Esc>
" Complete opening char
imap <C-CR> <Esc>bbyle"0pi<right>

" Switch Vim modes
inoremap <C-Space> <Esc>
inoremap <Ins> <Esc>

" Terminals
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-Space> <C-\><C-n>
  tnoremap <C-w> <C-\><C-n><C-w>
  autocmd BufEnter term://* startinsert
  autocmd TermOpen term://* startinsert
elseif has('terminal')
  tnoremap <Esc> <C-w>N
  tnoremap <C-Space> <C-w>N
endif

xmap <F2> <Esc><F2>
nnoremap <F2> :edit <C-r>=expand("%:p:h").g:psep<CR>
cnoremap <F2> <C-r>=expand("%:p:h").g:psep<CR>

xmap <F3> <Esc><f3>
nnoremap <F3> :buffer<Space>

xmap <F4> <Esc><F4>
nnoremap <F4> :find<Space>

inoremap <F7> <Esc>:sil make<Space><Up><CR>
nnoremap <F7> :sil make<Space><Up><CR>
nnoremap <C-F7> :sil make<Space><Up>

nnoremap <F12> :cnext<CR> 
nnoremap <S-F12> :cprevious<CR>

nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabclose<CR>

nnoremap <silent> <Leader>g :let @/="<C-r><C-w>"<CR>:silent grep <C-r><C-w><CR>
nnoremap <Leader>G :silent grep<Space>

nnoremap <Leader>r :%s/\<<C-r><C-w>\>//c<Left><Left>
vnoremap <Leader>r :s/\<<C-r><C-w>\>//c<Left><Left>

nnoremap <A-.> :tjump <C-r><C-w><CR>
nnoremap <A-,> :pop<CR>

nnoremap <C-Insert> "*yiw
vnoremap <C-Del> "*x
vnoremap <C-insert> "*y
nnoremap <S-Insert> "*P
cnoremap <S-Insert> <C-r>*

nnoremap <Leader>n :nohlsearch<CR>
nnoremap <Leader>N :set invhlsearch<CR>
nnoremap <Leader>s :setlocal invspell<CR>

if has("win32") || has("win64")
  nnoremap <Leader>X :silent execute "!start explorer  " . expand ("%:p:h")<CR>
  nnoremap <Leader>x :silent execute "!start cmd /k cd " . expand ("%:p:h")<CR>
endif


" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
