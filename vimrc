" Vim resource file
"
" New Vim features are nicly tracked on this site:
"   https://www.arp242.net/vimlog/
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on

set termguicolors
set clipboard=unnamed
set selection=inclusive
set mouse=a
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
set report=0
set ruler
set showmatch matchtime=1
set showtabline=1
set shortmess-=f " long form for file info
set shortmess+=S " Yes, search count please
set laststatus=2

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

set backup
execute 'set backupdir=' . getenv('LOCALAPPDATA') . '\vim\backup'
set wildignore+=*/backup/*

set undofile
execute 'set undodir=' . getenv('LOCALAPPDATA') . '\vim\undo'
set wildignore+=*/undo/*

" Insert mode completion
set complete=.,w
set noshowfulltag
set completeopt=menu

set pumheight=7

" Command line completion
set nowildmenu
set wildoptions=tagfile
set wildmode=full
set wildignorecase
set wildignore+=*.*~,*.o,TAGS
" How to handle search for tags
set tagcase=match

" Tune the diff feature for my needs.
set diffopt=internal,algorithm:minimal,context:8,vertical,iwhite,filler
" When starting in 'diff' mode, go full screen.
if &diff
  set columns=999 lines=999
endif

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
imap <S-Right> <Esc><S-Right>
imap <S-Left> <Esc><S-Left>
imap <S-Up> <Esc><S-Up>
imap <S-Down> <Esc><S-Down>

" To map <Esc> to exit terminal-mode: >
tnoremap <Esc> <C-\><C-n>

" To simulate |i_CTRL-R| in terminal-mode: >
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

tnoremap <S-Right> <C-\><C-n><C-w>l
tnoremap <S-Left>  <C-\><C-n><C-w>h
tnoremap <S-Up>    <C-\><C-n><C-w>k
tnoremap <S-Down>  <C-\><C-n><C-w>j

" "Enclose" `current` (visual) {selection}
vnoremap <Space>" c"<C-r>-"<Esc>
vnoremap <Space>' c'<C-r>-'<Esc>
vnoremap <Space>` c`<C-r>-`<Esc>
vnoremap <Space>( c(<C-r>-)<Esc>
vnoremap <Space>[ c[<C-r>-]<Esc>
vnoremap <Space>{ c{<C-r>-}<Esc>

nnoremap <A-+> 3<C-w>+3<C-w>>
nnoremap <A--> 3<C-w>-3<C-w><

nnoremap + :cnext<CR>zz
nnoremap - :cprevious<CR>zz

" By default, <c-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> :diffupdate<cr>:redraw!<cr>

let PathSep = { -> has('unix')?'/':'\' }

" set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "s"

inoremap <C-c> <C-c>:nohlsearch<CR>
nnoremap <C-c> :nohlsearch<CR>

let g:ft2regex = { 'c':'\.[ch]$', 'vim':'vim', 'py':'\.py$', 'cmake':'\(\.cmake\|CMakeLists.txt\)' }
let LsFilter = { ft -> has_key(g:ft2regex, ft) ? g:ft2regex[ft] : ''}
nnoremap <expr> <Leader>b ':filter /' . LsFilter(&ft) . '/ ls<CR>:buffer '

nnoremap <Leader>f :find<Space>*
nnoremap <Leader>t :tjump<Space>/
nnoremap <Leader>g :silent grep<Space>
nnoremap <Leader>+ :tabnew<CR>
nnoremap <Leader>- :tabclose<CR>
nnoremap <expr> <Leader>e ':edit ' . expand("%:p:h") . PathSep()
nnoremap <expr> <Leader>v ':edit '.$USERPROFILE.PathSep().'vimfiles'.PathSep()
nnoremap <leader>m :<C-u>Make<up>

" --- toggle options
nnoremap <Leader>oh :set invhlsearch hlsearch?<CR>
nnoremap <Leader>os :setlocal invspell spell?<CR>
nnoremap <Leader>ow :setlocal invwrap<CR>
nnoremap <Leader>og :set grepprg=<C-r>=escape(&grepprg, ' ')<CR>

" --- quick replace command
nnoremap <Leader>r :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <Leader>r :s///gI<Left><Left><Left><Left>

" --- quickfix
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cc :cclose<CR>
nnoremap <Leader>cl :clist<CR>

" --- command line completion
cnoremap <C-r>. <C-r>=expand("%:h")<CR>

command! -nargs=0 CleanUpBuffers      :bufdo if bufname('%')=='' | bd! | endif
command! -nargs=0 IgnoreCaseSensetive :set   ignorecase nosmartcase
command! -nargs=0 CaseSensetive       :set noignorecase nosmartcase
command! -nargs=0 SmartCase           :set   ignorecase  smartcase

" Description: Jump to last location. Check out :help line(). Function checks
" if the '" marker is valid. Jump to the mark, but don't change the jumplist
" when jumping within the current buffer (:help g').
function! RestoreCursor ()
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g`\""
  endif
endfunction

" Description: Some minor extensions to run ripgrep or Windows own findstr.
" Ironically, because this set 'grepprg', right now grep iteslf is not used.
" Most of the time I work On Windows only.

let g:rg_glob_patterns = {
      \ 'c': '-g *.[ch]',
      \ 'cpp': '-g *.[ch]',
      \ 'vim': '-g *.vim',
      \ 'asm': '-g *.850',
      \ 'py': '-g *.py',
      \ 'cmake': '-g *.cmake -g CMakeLists.txt',
      \ }

let g:findstr_glob_patterns = {
      \ 'c': '*.c *.h',
      \ 'cpp': '*.c* *.h*',
      \ 'vim': '*vimrc *.vim',
      \ 'asm': '*.s *.asm *.850',
      \ 'py': '*.py',
      \ 'cmake': '*.cmake CMakeLists.txt'
      \ }

let RgGlob = {ft -> has_key(g:rg_glob_patterns, ft) ? g:rg_glob_patterns[ft] : '-g *.*'}
let FindstrGlob = {ft -> has_key(g:findstr_glob_patterns, ft) ? g:findstr_glob_patterns[ft] : '*.*'}

if executable("rg")
  " Using links? Ripgrep supports this by th option '--follow'
  set grepprg=rg\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  nnoremap <expr> <Leader>g ':silent grep ' . RgGlob(&ft) . ' ' . expand('<cword>')
elseif executable("findstr")
  set grepprg=findstr\ /S\ /N
  set grepformat=%f:%l:%m
  nnoremap <expr> <Leader>g ':silent grep ' . expand('<cword>') . ' ' . FindstrGlob(&ft)
elseif executable("grep")
  set grepprg=grep\ -Hnr\ --exclude=cmake\ $* \.
  set grepformat=%f:%l:%m
endif

if executable("rg")
  " find any file
  command! -nargs=+ Glob :term rg --files -g <args> .
else
  command! -nargs=+ Glob :term dir /S /B <args>
endif

augroup init
  autocmd!
  autocmd BufReadPost  * call RestoreCursor()
  autocmd BufEnter     * if &pvw | setlocal nonu nornu | endif
  autocmd TerminalOpen * setlocal nonumber norelativenumber foldcolumn=0
  autocmd VimEnter     * runtime plugins.vim
  autocmd VimResized   * wincmd =
  " Reload changed buffers. Command rely on 'autoread'. FocusedGained works only on same terminals
  autocmd FocusGained * :checktime
augroup END

" vim:sw=2:tw=78:nocindent:foldmethod=marker:nofen:
