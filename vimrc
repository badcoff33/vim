" Vim resource file
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on

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
set showcmd
set showmatch matchtime=1
set showtabline=1

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

if has ('jumpoptions')
  " New option is coming for Neovim/Vim
  set jumpoptions=stack
endif

if (has("termguicolors"))
  set termguicolors
  syntax on
endif

" Search: Some configuration for the search behavior.
set ignorecase smartcase
set incsearch
set hlsearch
set magic

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
set showfulltag
set completeopt=menu,noselect
set pumheight=7

" Command line completion
set wildoptions=tagfile
set nowildmenu wildmode=list:full
"set wildmenu
set wildignorecase
set wildignore+=*.*~,*.o,TAGS
" How to handle search for tags
set tagcase=followscs

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
let g:netrw_preview = 1

" Set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "s"

" Switch modes
vnoremap <F13> :
nnoremap <F13> :
vnoremap <F12> :
nnoremap <F12> :

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" "Enclose" `current` (visual) {selection}
vnoremap "<Space> c"<C-r>-"<Esc>
vnoremap '<Space> c'<C-r>-'<Esc>
vnoremap `<Space> c`<C-r>-`<Esc>
vnoremap (<Space> c(<C-r>-)<Esc>
vnoremap [<Space> c[<C-r>-]<Esc>
vnoremap {<Space> c{<C-r>-}<Esc>

" Terminals
tnoremap <Esc> <C-w>N
tnoremap <S-Ins> <C-w>"*

nnoremap <Leader>. :tjump /
nnoremap <Leader>e :edit <C-r>=expand("%:p:h")..g:psep<CR>
nnoremap <Leader>b :ls<CR>:buffer<Space>
nnoremap <Leader>f :find<Space>
nnoremap <Leader>m :sil make<Space><Up><CR>
nnoremap <Leader>M :sil make<Space><Up>
nnoremap <Leader>v :sil vimgrep<Space><Up><C-B><C-Right><C-Right><C-Right>
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>te :tabedit %<CR>
nnoremap <Leader>to :tabonly<CR>
nnoremap <Leader>tc :tabclose<CR>

nnoremap <A-+> 3<C-w>+3<C-w>>
nnoremap <A--> 3<C-w>-3<C-w><
nnoremap <C-w>0 <C-^>:bw#<Esc>

nnoremap <C-l> :cnewer<CR>
nnoremap <C-h> :colder<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>

nnoremap <A-Down> :cnext<CR>
nnoremap <A-Up> :cprev<CR>
nnoremap <A-Left> :bprevious<CR>
nnoremap <A-Right> :bnext<CR>

if executable("rg")
  " Using links? Ripgrep supports this by th option '--follow'
  set grepprg=rg\ --vimgrep\ -tc\ -tcpp\ -tcmake\ -g\ !cmake\ $*\ . 
  set grepformat=%f:%l:%c:%m
elseif executable("grep")
  set grepprg=grep\ -Hnr\ --exclude=cmake\ $* \.
  set grepformat=%f:%l:%m
endif
nnoremap <Leader>g :silent grep <C-r><C-w>

command! -nargs=1 -complete=dir WriteOptionsToDir :call writefile(['set grepprg='..escape(&grepprg, ' \'), 'set path='..&path], '<args>'..'/.vimrc', 'a')
command! -nargs=0 ReadOptions :execute "source" findfile(".vimrc", ";")
command! -nargs=0 EditOptions :execute "edit" findfile(".vimrc", ";")

nnoremap <Leader>r :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <Leader>r :s///gI<Left><Left><Left><Left>

nnoremap <S-down>  <C-w>j
nnoremap <S-up>    <C-w>k
nnoremap <S-left>  <C-w>h
nnoremap <S-right> <C-w>l

nnoremap <Leader><Leader> :nohlsearch<CR>
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

" command completion needs terminating backslash (sorry, Windows)
cnoremap <C-Space> <C-r>=g:psep<CR>
cnoremap <C-r>. <C-r>=expand("%:h")..g:psep<CR>

augroup init
  autocmd!
  autocmd VimResized * :wincmd =
  autocmd VimEnter * :runtime site.vim
  autocmd BufEnter * :if &ft !~ '^\(vim\|help\)$' | nnoremap <buffer> K g<C-]> | endif
augroup END

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
