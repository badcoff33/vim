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
set sessionoptions=buffers,curdir,localoptions,globals,tabpages,winsize

" Write all files before any ':make' command
set autowrite

" Tune the diff feature for my needs.
set diffopt=context:3,vertical,iwhite,filler

if has('unix')
  let g:psep = '/'
else
  let g:psep = '\'
endif

" Netrw variables
let g:netrw_use_errorwindow = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
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

nnoremap <F5> :call basic#PopupTerminal()<CR>
inoremap <F5> <Esc>:call basic#PopupTerminal()<CR>

inoremap <F7> <Esc>:sil make<Space><Up><CR>
nnoremap <F7> :sil make<Space><Up><CR>
nnoremap <C-F7> :sil make<Space><Up>

imap <F8> <Esc><F8>
nnoremap <F8> :sil vimgrep /\C<C-r><C-w>/j *.<C-r>=&filetype<CR>

imap <f11> <Esc><f11>
nnoremap <f11> :tabnew<CR>
imap <S-f11> <Esc><S-f11>
nnoremap <S-f11> :tabclose<CR>

imap <F12> <Esc><F12>
nnoremap <F12> :ToggleQuickfix<CR>

nnoremap <A-.> :tjump<Space>
inoremap <A-.> <Esc>:tjump<Space>
nnoremap <C-.> g<C-]>
inoremap <C-.> <Esc>g<C-]>
nnoremap <C-,> <C-t>
inoremap <C-,> <Esc><C-t>

nnoremap <A-y> "*yiw
vnoremap <A-x> "*x
vnoremap <A-y> "*y
nnoremap <A-p> "*P
vnoremap <A-p> "*P
cnoremap <A-p> <C-r>*

nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>

nnoremap <silent> <Leader>g :let @/="<C-r><C-w>"<CR>:silent grep <C-r><C-w><CR>
nnoremap <Leader>G :silent grep<Space>

nnoremap <Leader><Space> :clist<CR>

nnoremap <Leader>r :%s/\<<C-r><C-w>\>//c<Left><Left>
vnoremap <Leader>r :s/\<<C-r><C-w>\>//c<Left><Left>

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

command! -nargs=0 ShowHiName               :call basic#HiName()
command! -nargs=1 HighlightWord            :call basic#HighlightWord("<args>")
command! -nargs=0 ToggleStickyCursorline   :call basic#ToggleStickyCursorLine()
command! -nargs=0 ToggleStatusline         :call basic#ToggleStatusline()
command! -nargs=0 ToggleQuickfix           :call basic#ToggleQuickfix()
command! -nargs=0 WhitespaceMelt           :call whitespace#Melt()
command! -nargs=0 WhitespaceClenup         :call whitespace#Cleanup()
command! -nargs=0 ShowUnsavedChanges       :call vimdiff#UnsavedChanges()
command! -nargs=* -complete=dir TwoDirDiff :call vimdiff#TwoDirDiff(<f-args>)
command! -nargs=1 -complete=dir Cd         :call spaces#Start(<q-args>)

" surround visual selection with double quote ("), quote ('), backtick (`),
" parentheses (), braces {} and brackets []
vnoremap <Leader>% <ESC>:call basic#SurroundSelection()<CR>

nnoremap <Leader>h   :HighlightWord <C-r><C-w><CR>
nnoremap <Leader>w   :WhitespaceMelt<CR>
nnoremap <Leader>l   :ToggleStatusline<CR>

augroup init
  autocmd!
  autocmd VimResized  *         :wincmd =
  autocmd BufReadPost *         :call basic#RestoreCursor()
  autocmd BufWritePre *.cc,*.hh :call whitespace#Cleanup()
  autocmd BufWritePre *.c,*.h   :call whitespace#Cleanup()
  autocmd BufWritePre *.py      :call whitespace#Cleanup()
  autocmd BufWritePre *.vim     :call whitespace#Cleanup()
augroup END

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
