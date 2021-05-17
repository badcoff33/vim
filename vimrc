" Vim resource file
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on
syntax on
if exists('&termguicolors')
  set termguicolors
endif

set clipboard=autoselect
set selection=inclusive
set keymodel=
set selectmode=

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set history=200
set belloff=all
set novisualbell
set noerrorbells
set noswapfile
set laststatus=2
set report=0
set ruler
set showmatch matchtime=1
set showtabline=1
set showcmd
set shortmess-=f " long form for file info
set shortmess-=S " Yes, search count please

" limit number of suggestions of z=
set spellsuggest=best,10
set spelllang=en_us,de_de
if exists('&spelloptions')
  set spelloptions=camel
endif

" Read changed files automatically if they are changed in the background
set autoread

" Allow modified files to flip in background, without a write.
set hidden

" Set behavior for commands ':cc', ':cn', 'cp', etc.
set switchbuf=useopen,uselast

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

" Search: Some configuration for the search behavior.
set ignorecase smartcase
set incsearch
set hlsearch
set magic

" first elementis users home of Vim files
let g:vim_home = split(&runtimepath, ',')[0]

if isdirectory(g:vim_home .. '/backup')
  set backup
  execute 'set backupdir=' .. g:vim_home .. '/backup'
  set wildignore+=*/backup/*
endif

if isdirectory(g:vim_home .. '/undo')
  set undofile
  execute 'set undodir=' .. g:vim_home .. '/undo'
  set wildignore+=*/undo/*
endif

" Insert mode completion
set complete=.,w
set showfulltag
set completeopt=menu,preview
set pumheight=7

" Command line completion
set wildoptions=tagfile
set nowildmenu wildmode=full
"set wildmenu wildmode=full
set wildignorecase
set wildignore+=*.*~,*.o,TAGS
" How to handle search for tags
set tagcase=followscs

" Tune the diff feature for my needs.
set diffopt=internal,algorithm:minimal,context:8,vertical,iwhite,filler
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
let g:netrw_preview = 1

" Switch modes
inoremap <S-Space> <Esc>
tnoremap <Esc> <C-w>N
tnoremap <S-Space> <C-w>N

" yank current word -- CUA style
nnoremap <C-Ins> "+yiw

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" Window movement
nnoremap <S-Right> <C-w>l
nnoremap <S-Left> <C-w>h
nnoremap <S-Up> <C-w>k
nnoremap <S-Down> <C-w>j
tnoremap <S-Right> <C-w>l
tnoremap <S-Left> <C-w>h
tnoremap <S-Up> <C-w>k
tnoremap <S-Down> <C-w>j

" "Enclose" `current` (visual) {selection}
vnoremap "<Space> c"<C-r>-"<Esc>
vnoremap '<Space> c'<C-r>-'<Esc>
vnoremap `<Space> c`<C-r>-`<Esc>
vnoremap (<Space> c(<C-r>-)<Esc>
vnoremap [<Space> c[<C-r>-]<Esc>
vnoremap {<Space> c{<C-r>-}<Esc>

" Set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "s"
" By default, <c-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> :nohlsearch<cr>:diffupdate<cr>:redraw!<cr>

let g:ft2regex = { 
      \ 'c':'\.[ch]$', 
      \ 'vim':'\.vim', 
      \ 'py':'\.py$', 
      \ 'cmake':'\(\.cmake\|CMakeLists.txt\)',
      \ }
let LsFilter = { ft -> has_key(g:ft2regex, ft) ? g:ft2regex[ft] : ''}
nnoremap <expr> <Leader>B ':filter /' .. LsFilter(&ft) .. '/ ls<CR>:buffer '
nnoremap <Leader>b :ls +<CR>:buffer<Space>
nnoremap <Leader>f :find<Space>
nnoremap <expr> <Leader>e ':edit ' .. expand("%:p:h") .. g:psep
nnoremap <Leader>m :sil make<Space><Up><CR>
nnoremap <Leader><C-m> :sil make<Space><Up>
nnoremap <expr> <Leader>v ':edit' g:vim_home
nnoremap <Leader>g <cmd>silent grep <C-r><C-w><CR>
nnoremap <Leader>G :silent grep <C-r><C-w>
nnoremap <Leader>+ :tabnew<CR>
nnoremap <Leader>- :tabclose<CR>
nnoremap <Leader>c <C-^>:bw#<Esc>

" Terminal
tnoremap <S-Ins> <C-w>"*

nnoremap <A-+> 3<C-w>+3<C-w>>
nnoremap <A--> 3<C-w>-3<C-w><

nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>

nnoremap <A-Down> :cnext<CR>
nnoremap <A-Up> :cprev<CR>
nnoremap <A-Left> :bprevious<CR>
nnoremap <A-Right> :bnext<CR>

" Insert mode: map all functions keys to normal mode mappinng
imap <F1> <Esc><F1>
imap <F2> <Esc><F2>
imap <F3> <Esc><F3>
imap <F4> <Esc><F4>
imap <F5> <Esc><F5>
imap <F6> <Esc><F6>
imap <F7> <Esc><F7>
imap <F8> <Esc><F8>
imap <F9> <Esc><F9>
imap <F10> <Esc><F10>
imap <F11> <Esc><F11>
imap <F12> <Esc><F12>
imap <F13> <Esc><F13>

if executable("rg")
  " Using links? Ripgrep supports this by th option '--follow'
  set grepprg=rg\ --vimgrep\ -g\ !cmake\ $*\ . 
  set grepformat=%f:%l:%c:%m
  let g:ft2rg_glob = { 'c':'-g *.[ch]', 'vim':'-g *.vim', 'asm': '-g *.850',
        \ 'py':'-g *.py', 'cmake':'-g *.cmake -g CMakeLists.txt',
        \ }
  let RgGlob = { ft -> has_key(g:ft2rg_glob, ft) ? g:ft2rg_glob[ft] : '-g *.*' }
  nnoremap <expr> <Leader>g ':silent grep ' .. RgGlob(&ft) .. ' ' .. expand('<cword>')
elseif executable("grep")
  set grepprg=grep\ -Hnr\ --exclude=cmake\ $* \.
  set grepformat=%f:%l:%m
endif

command! -nargs=1 -complete=file WriteOptionsToDir :call writefile(['set grepprg='..escape(&grepprg, ' \'), 'set path='..&path], '<args>'..'/.vimrc', 'a')
command! -nargs=0 ReadOptions :execute "source" findfile(".vimrc", ";")
command! -nargs=0 EditOptions :execute "edit" findfile(".vimrc", ";")

nnoremap <Leader>r :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <Leader>r :s///gI<Left><Left><Left><Left>

nnoremap <Leader>oh :set invhlsearch hlsearch?<CR>
nnoremap <Leader>oi :set invignorecase ignorecase?<CR>
nnoremap <Leader>om :set invsmartcase smartcase?<CR>
nnoremap <Leader>os :setlocal invspell spell?<CR>
nnoremap <Leader>og :set grepprg=<C-r>=escape(input("set greprg:", &grepprg), ' ')<CR><CR>

command! -nargs=0 CleanUpBuffers :bufdo if bufname('%')=='' | bd! | endif

command! -nargs=0 IgnoreCaseSensetive :set   ignorecase nosmartcase
command! -nargs=0 CaseSensetive       :set noignorecase nosmartcase
command! -nargs=0 SmartCase           :set   ignorecase  smartcase

command! -nargs=0 ReadOnly :setlocal nomodifiable readonly
command! -nargs=0 LastSession :execute 'source '..$TMP..'/'..sha256(getcwd())..'.vim'

" command completion needs terminating backslash (sorry, Windows)
cnoremap <C-Space> <C-r>=g:psep<CR>
cnoremap <C-r>. <C-r>=expand("%:h")..g:psep<CR>

augroup init
  autocmd!
  autocmd VimResized * wincmd =
  autocmd VimLeavePre * execute 'mksession! '..$TMP..'/'..sha256(getcwd())..'.vim'
  autocmd BufEnter * if &ft !~ '^\(vim\|help\)$' | nnoremap <buffer> K g<C-]> | endif
  autocmd TerminalOpen * setlocal nonumber norelativenumber foldcolumn=0
  autocmd TerminalOpen * vnoremap <buffer> <CR> "ty:cexpr split('<C-r>t','\r')<CR>
  autocmd TerminalOpen * nnoremap <buffer> <CR> :cexpr getline('.')<CR><C-w>p
augroup END

" run an optional, machine-dependent script here. May set plugin vars before the
" plugins gets sourced.
runtime site.vim

" vim:ft=vim
