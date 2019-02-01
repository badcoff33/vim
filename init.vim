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
set novisualbell
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
set switchbuf=usetab
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

" Command line completion
set wildmenu wildmode=full
"set nowildmenu wildmode=list,full
set wildignorecase
set wildignore=*.*~

set showtabline=1
set sessionoptions=buffers,tabpages,winsize

" Customize cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-

" Write all files before any ':make' command
set autowrite

" Tune the diff feature for my needs.
set diffopt=context:3,vertical,iwhite,filler

" If available, use GNU grep niceties for searching
if system('grep --version') =~# '^grep (GNU grep)'
  set grepprg=grep\ -HnRs\ --exclude='.git*'
endif

" plugin variables {{{

let g:netrw_use_errorwindow = 0
let g:netrw_liststyle = 0
let g:tagbar_left = 0
let g:tagbar_foldlevel = 1
let g:tagbar_width=60

" }}}

" commands {{{

command! -nargs=0 Welcome call welcome#open()

command! -nargs=0 ShowHiName call basic#HiName()
command! -nargs=0 ClipboardBuffer call basic#ClipboardBuffer()
command! -nargs=1 HighlightWord call basic#HighlightWord("<args>")
command! -nargs=0 ToggleStickyCursorline call basic#ToggleStickyCursorLine()
command! -nargs=0 ToggleStatusline call basic#ToggleStatusline()

command! -nargs=0 SwitchWorkspace call workspace#Switch()

command! -nargs=+ -complete=file Job :call runjob#StartJob(<q-args>)
command! -nargs=1 -complete=dir JobCwd :call runjob#SetCwd(<q-args>)

command! -nargs=0 WhitespaceCleanup call whitespace#Cleanup()
command! -nargs=0 WhitespaceMelt call whitespace#Melt()

command! -nargs=0 ShowUnsavedChanges call vimdiff#UnsavedChanges()
command! -nargs=* -complete=dir TwoDirDiff call vimdiff#TwoDirDiff(<f-args>)

command! -nargs=0 OneMoreThing call onemorething#NewEntry()
command! -nargs=0 ShowOneMoreThing call onemorething#ShowFile()

command! -nargs=1 Wipe bufdo if expand("%") =~ '.*<args>.*' | bw | endif | bprevious

" }}} commands

" autocommands {{{

augroup init
  " clear group in case file sourced several times
  autocmd!

  " How to handle multiple windows?
  autocmd VimResized * wincmd =

  autocmd BufReadPost * call basic#RestoreCursor()

  autocmd BufWritePre *.c,*.h :WhitespaceCleanup
  autocmd BufWritePre *.py    :WhitespaceCleanup

  autocmd VimEnter,ColorScheme * highlight HighlightWordGroup gui=underline

  " read file templates (according to :help template)
  autocmd BufNewFile  .workspace.vim 0r ~/vimfiles/templates/workspace.vim

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

" }}} autocommands

" mappings {{{

" Set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "+"

nnoremap <up> <C-w>k
nnoremap <down> <C-w>j
nnoremap <left> <C-w>h
nnoremap <right> <C-w>l

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
else
  tnoremap <Esc> <C-w>N
endif

" surround visual selection with ", ', (, [
vnoremap <Leader>" c"<C-R>-"<Esc>
vnoremap <Leader>' c'<C-R>-'<Esc>
vnoremap <Leader>` c`<C-R>-`<Esc>
vnoremap <Leader>( c(<C-R>-)<Esc>
vnoremap <Leader>[ c[<C-R>-]<Esc>

" Try this!
inoremap <Ins> <Esc>
inoremap <C-Space> <Esc>

inoremap <f1> <Esc>:
nnoremap <f1> :
nnoremap <f4> :cnext<CR>
nnoremap <S-f4> :cprevious<CR>
nnoremap <f6> :bprevious<CR>
nnoremap <S-f6> :bnext<CR>

nnoremap <Leader>h :HighlightWord <C-r><C-w><CR>
nnoremap <Leader>c :ClipboardBuffer<CR>
nnoremap <Leader>w :WhitespaceMelt<CR>

nnoremap <Leader>o :OneMoreThing<CR>
nnoremap <Leader>O :ShowOneMoreThing<CR>
nnoremap <Leader>l :ToggleStatusline<CR>

nnoremap <Leader>e :edit <C-r>=expand("%:p:h")<CR>\
nnoremap <Leader>E :Vexplore <C-r>=expand("%:p:h")<CR><CR>20<C-w><bar>
nnoremap <Leader>b :buffer<Space>
nnoremap <Leader>m :sil make
nnoremap <Leader>g :sil grep
nnoremap <Leader>t :sil TagbarToggle<CR>

nnoremap <Leader><C-]> :tjump /

nnoremap <Leader>R :%s/\<<C-r><C-w>\>//c<Left><Left>
nnoremap <Leader>r :.,$s/\<<C-r><C-w>\>//c<Left><Left>

" put current word in register '*' 
nnoremap <C-Insert> "*yiw

nnoremap <Leader>n :set invhlsearch<CR>
nnoremap <Leader>s :setlocal invspell<CR>

nnoremap <BS> :call basic#ToggleQuickfix()<CR>

if has("win32") || has("win64")
  nnoremap <Leader>X :silent execute "!start explorer  " . expand ("%:p:h")<CR>
  nnoremap <Leader>x :silent execute "!start cmd /k cd " . expand ("%:p:h")<CR>
endif

cnoremap <C-CR> <C-r>=expand("%:p:h")<CR>\

" }}} mappings

" load local site file for machine dependent configs
runtime site.vim

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
