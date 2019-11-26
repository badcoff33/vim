" Vim resource file
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on

" Even on on Windows, this works best
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
  set nowildmenu wildmode=list,full wildoptions=tagfile
endif
set wildignorecase
set wildignore=*.*~

set showtabline=1
set sessionoptions=buffers,tabpages,winsize

" Write all files before any ':make' command
set autowrite

" Tune the diff feature for my needs.
set diffopt=context:3,vertical,iwhite,filler

" plugin variables 

let g:netrw_use_errorwindow = 0
let g:netrw_liststyle = 0

" commands

command! -nargs=1 Wipe bufdo if expand("%") =~ '.*<args>.*' | bw | endif | bprevious

" autocommands 

augroup init
  " clear group in case file sourced several times
  autocmd!

  " How to handle multiple windows?
  autocmd VimResized * wincmd =

  autocmd VimEnter,ColorScheme * highlight HighlightWordGroup gui=underline

augroup END

" Save when Neovim's losing or gaining focus
augroup ginit
  " clear group in case file sourced several times
  autocmd!
  " write all buffers when loosing focus
  autocmd FocusLost * :silent! wall
  " Reload changed buffers. Command rely on option 'autoread'
  autocmd FocusGained * :checktime
augroup END

" mappings 

" Set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "s"

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-z> <C-\><C-n>
elseif has('terminal')
  tnoremap <Esc> <C-w>N
endif

if exists("win32") || exists("win64")
  " decrement visual selected nummbers
  silent! vunmap <C-x>
endif

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
inoremap <Ins> <Esc>
inoremap <C-Space> <Esc>
nnoremap <C-Space> :

nnoremap <F4> :cnext<CR> 
nnoremap <S-F4> :cprevious<CR>

inoremap <F7> <Esc>:sil make<Space><Up><CR>
nnoremap <F7> :sil make<Space><Up><CR>
nnoremap <C-F7> :sil make<Space><Up>

nnoremap <F12> :tjump <C-r><C-w><CR>
nnoremap <C-F12> :tjump /

nnoremap + :cnext<CR> 
nnoremap - :cprevious<CR>

nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabclose<CR>

nnoremap <Leader>e :edit <C-r>=expand("%:p:h")<CR>
nnoremap <Leader>b :buffer<Space>
nnoremap <Leader>f :find<Space>

nnoremap <silent> <Leader>g :let @/="<C-r><C-w>"<CR>:silent grep <C-r><C-w><CR>
nnoremap <Leader>G :silent grep<Space>

nnoremap <Leader>r :%s/\<<C-r><C-w>\>//c<Left><Left>
vnoremap <Leader>r :s/\<<C-r><C-w>\>//c<Left><Left>

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

cnoremap <C-CR> <C-r>=expand("%:p:h")<CR>

" load local site file for machine dependent configs
runtime site.vim

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
