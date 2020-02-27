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
set noswapfile
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
set wildignore+=*.*~,*.o,TAGS

" Tune the diff feature for my needs.
set diffopt=internal,context:3,vertical,iwhite,filler

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

" Switch Vim modes
inoremap <C-Space> <Esc>
inoremap <Char-0xDF> <Esc>
nnoremap <Leader><Space> :

inoremap <C-Tab> <Esc>gt
nnoremap <C-Tab> gt

" Terminals
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-Space> <C-\><C-n>
  tnoremap <C-w> <C-\><C-n><C-w>
  tnoremap <C-Tab> <C-\><C-n>gt
  autocmd BufEnter term://* startinsert
  autocmd TermOpen term://* startinsert
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

nnoremap <A-.> g<C-]>
inoremap <A-.> <Esc>g<C-]>
nnoremap <A-,> <C-t>
inoremap <A-,> <Esc><C-t>

inoremap <S-up>    <Esc><C-w>k
inoremap <S-down>  <Esc><C-w>j
inoremap <S-left>  <Esc><C-w>h
inoremap <S-right> <Esc><C-w>l
nnoremap <S-up>    <C-w>k
nnoremap <S-down>  <C-w>j
nnoremap <S-left>  <C-w>h
nnoremap <S-right> <C-w>l
nnoremap <CS-Up>   <C-w>3+
nnoremap <CS-Down> <C-w>3-

nnoremap <C-.> :cnext<CR>
nnoremap <C-,> :cprevious<CR>

nnoremap <silent> <Leader>g :let @/="<C-r><C-w>"<CR>:sil grep <C-r><C-w><CR>
nnoremap <Leader>G :sil grep<Space><Up>

nnoremap <Leader>r :%s/\C\<\>//c<Left><Left><Left><Left><Left>
vnoremap <Leader>r :s/\C\<\>//c<Left><Left><Left><Left><Left>

" Keys '[' and ']' is hard to reach on some non-english keyboards. Here is a way to
" record a macro with those keys and make macro playback easy as possible.
nnoremap <Leader><left> :let @x=input("Go back ('[[', '[s', '[d'): ", "")<CR>
nnoremap <Leader><right> :let @y=input("Go forward (']]', ']s', ']d'): ", "")<CR>
nnoremap <A-left> @x
vnoremap <A-left> @x
nnoremap <A-right> @y
vnoremap <A-right> @y
let @x = "{"
let @y = "}"

nnoremap <Leader>n :nohlsearch<CR>
nnoremap <Leader>N :set invhlsearch<CR>
nnoremap <Leader>s :setlocal invspell<CR>

" surround visual selection with double quote ("), quote ('), backtick (`),
" parentheses (), braces {} and brackets []
vnoremap <CR> <ESC>:call basic#SurroundSelection()<CR>

nnoremap <Leader>h :HighlightWord <C-r><C-w><CR>
nnoremap <Leader>w :WhitespaceMelt<CR>
nnoremap <Leader>l :ToggleStatusline<CR>
nnoremap <S-Tab>   :ToggleQuickfix<CR>
nnoremap <Leader>t :PopupTerminal<CR>

command! -nargs=0 ShowHiName               :call basic#HiName()
command! -nargs=1 HighlightWord            :call basic#HighlightWord("<args>")
command! -nargs=0 ToggleStickyCursorline   :call basic#ToggleStickyCursorLine()
command! -nargs=0 PopupTerminal            :call basic#PopupTerminal()
command! -nargs=0 ToggleStatusline         :call basic#ToggleStatusline()
command! -nargs=0 ToggleQuickfix           :call basic#ToggleQuickfix()
command! -nargs=0 WhitespaceMelt           :call whitespace#Melt()
command! -nargs=0 WhitespaceClenup         :call whitespace#Cleanup()
command! -nargs=0 ShowUnsavedChanges       :call vimdiff#UnsavedChanges()
command! -nargs=* -complete=dir TwoDirDiff :call vimdiff#TwoDirDiff(<f-args>)
command! -nargs=1 -complete=dir Cd         :call sessions#Start(<q-args>)
command! -nargs=1 -complete=help Help      :call basic#OpenFloatingHelp(<q-args>)

cabbrev %% <C-r>=expand("%:p:h")<CR>

augroup init
  autocmd!
  autocmd VimResized  *         :wincmd =
  autocmd BufReadPost *         :call basic#RestoreCursor()
  autocmd BufWritePre *.cc,*.hh :call whitespace#Cleanup()
  autocmd BufWritePre *.c,*.h   :call whitespace#Cleanup()
  autocmd BufWritePre *.py      :call whitespace#Cleanup()
  autocmd BufWritePre *.vim     :call whitespace#Cleanup()
augroup END

if has('nvim')
  set winhighlight=Normal:Normal
endif

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
