" Vim resource file
"
" Maintainer: Markus Prepens (markus dot prepens at googlemail dot com)

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

" limit numer of suggestions of z=
set spellsuggest=best,10

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
set switchbuf=useopen
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
set hlsearch

" Optional config: if 'smartcase' is active a case sensitive search with
" /\C<text> can be used on demand.
set ignorecase smartcase
"set noignorecase nosmartcase

set noswapfile                    " it's 2017, Vim.

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
set complete=.,w,b
set completeopt=menu
set pumheight=10

" Command line completion
set nowildmenu wildmode=list:longest
set wildignorecase
set wildignore=*.*~

set showtabline=1
set sessionoptions=buffers,curdir,tabpages

" Use this ':help' to have quick access to the Vim documentation.
set keywordprg=:help

" Customize cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-

" Write all files before any ':make' command
set autowrite

" Tune the diff feature for my needs.
set diffopt=context:3,vertical,iwhite,filler

" functions {{{

" Description: Make the actual window more obvious.
" Active 'cursorline' option in diff buffers overrules highlighting of
" differences. Buffers with 'diff' option shall not use 'cursorline'.
" Note: 'cursorline' may delay cursor movement in buffer with filetype 'c'.
" This behavior may be caused by Doxygen syntax highlighting.
function! s:TurnCursorLineOn()
  if g:use_sticky_cursorline !=0 && &diff == 0 && &buftype == ""
    set cursorline
  endif
endfunction

function! ToggleStickyCursorLine()
  if !exists("g:use_sticky_cursorline")
    let g:use_sticky_cursorline = 0
  endif
  if g:use_sticky_cursorline == 0
    let g:use_sticky_cursorline = 1
    set cursorline
    augroup ToggleStickyCursorline
      au!
      autocmd WinLeave * set nocursorline
      autocmd BufEnter,BufWinEnter,WinEnter * call s:TurnCursorLineOn()
    augroup END
  else
    let g:use_sticky_cursorline = 0
    set nocursorline
    augroup ToggleStickyCursorline
      au!
    augroup END
  endif
endfunction

" Description: Jump to last location. Check out :help line(). Function checks
" if the '" marker is valid. Jump to the mark, but don't change the jumplist
" when jumping within the current buffer (:help g').
function! RestoreCursor ()
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction

" Description: A context sensitve file movement function.
function! FastForwardAndRewind(direction)
  if a:direction == "fastforward"
    if &diff
      normal ]czz
    elseif &filetype == "diff"
      execute search('^\(diff\|@@\)','W')
    elseif &filetype == "help"
      execute search('^[0-9\.]\+\s\+[A-Z]\+.*\*[a-z-]\+\*','W')
		elseif &filetype == "markdown"
			execute search('^#\+\s\+','W')
    else
      normal ]]
    endif
  elseif a:direction == "rewind"
    if &diff
      normal [czz
    elseif &filetype == "diff"
      execute search('^\(diff\|@@\)','bW')
    elseif &filetype == "help"
      execute search('^[0-9\.]\+\s\+[A-Z]\+.*\*[a-z-]\+\*','bW')
		elseif &filetype == "markdown"
			execute search('^#\+\s\+','bW')
    else
      normal [[
    endif
  endif
endfunction

function! HiName()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  echo synIDattr(synidtrans, "name")
endfunction

" Description: My splash screen (with one-liner Vim script in it)
function! Welcome()
  let l:welcome_text_file = '~/Documents/welcome.txt'
  if filereadable(expand(l:welcome_text_file))
    execute 'edit ' . l:welcome_text_file
    nmap <buffer> <CR> 0y$:<C-r>"<CR>
  endif
endfunction

" Description: Create or move to buffer ClipboardTxt, start to write text,
" switch to another application and copy the clipboard, filled with
" ClipboardTxt.
function! ClipboardBuffer()
  if bufexists("ClipboardTxt")
    buffer ClipboardTxt
  else
    edit ClipboardTxt
    setlocal buftype=nofile
    autocmd FocusLost clipboard.txt  normal gg"*yG
  endif
endfunction

function! HighlightWord(word)
  if !exists("s:thisHighlightWord")
    let s:thisHighlightWord = ""
  endif
  echo s:thisHighlightWord
  if a:word != s:thisHighlightWord
    let s:thisHighlightWord = a:word
    execute ":match HighlightWordGroup /\\<" . a:word . "\\>/"
  else
    let s:thisHighlightWord = ""
    match none
  endif
endfunction

" }}}

" plugin variables {{{

" customize Netrw
let g:netrw_use_errorwindow = 0
let g:netrw_liststyle = 1

" }}}

" commands {{{

command! -nargs=0 Welcome                call Welcome()
command! -nargs=0 SwitchWorkspace        call workspace#Switch()
command! -nargs=0 ShowHiName             call HiName()
command! -nargs=0 ToggleStickyCursorline call ToggleStickyCursorLine()

command! -nargs=0 WhitespaceCleanup   call whitespace#Cleanup()
command! -nargs=0 WhitespaceMelt      call whitespace#Melt()

command! -nargs=0 ShowUnsavedChanges  call vimdiff#UnsavedChanges()
command! -nargs=0 ToggleVimdiff       call vimdiff#Toggle()
command! -nargs=0 VimdiffFileContext  call vimdiff#FileContext()
command! -nargs=0 TwoDirDiff          call vimdiff#TwoDirDiff()

command! -complete=file -nargs=+ SCRun call shellcommand#Run([<f-args>])
command! -nargs=0 SCBuffer             call shellcommand#ShowBuffer()

" }}}

" autocommands {{{

augroup init
  " clear group in case file sourced several times
  autocmd!

  " How to handle multiple windows?
  autocmd VimResized * wincmd =

  autocmd BufReadPost * call RestoreCursor()

  autocmd BufWritePre *.c,*.h :WhitespaceCleanup
  autocmd BufWritePre *.py    :WhitespaceCleanup
  autocmd VimEnter,ColorScheme * highlight HighlightWordGroup gui=underline

  " read file templates (according to :help template)
  autocmd BufNewFile  workspace.vim  0r $LOCALAPPDATA/nvim/templates/workspace.vim
  autocmd BufNewFile  *.c            0r $LOCALAPPDATA/nvim/templates/file.c
  autocmd BufNewFile  *.h            0r $LOCALAPPDATA/nvim/templates/file.h

augroup END

" }}}

" mappings {{{

" Set leader and localleader keys, that works best for me
let mapleader=" "
let maplocalleader="-"

" surround visual selection with ", ', (, [
vnoremap <Leader>" c"<C-R>-"<Esc>
vnoremap <Leader>' c'<C-R>-'<Esc>
vnoremap <Leader>` c`<C-R>-`<Esc>
vnoremap <Leader>( c(<C-R>-)<Esc>
vnoremap <Leader>[ c[<C-R>-]<Esc>

nnoremap <BS> :<C-f>i
vnoremap <BS> :

" remove overwritten mapping
if exists("win32") || exists("win64")
  silent! vunmap <C-X>
endif

" Try this! Use <C-V><Tab> to insert a real tab
inoremap <C-Space> <Esc>

" extend abbreviation
inoremap <C-Tab> <C-]>

" Indent and re-select visual block
nnoremap <Leader>R :%s/<C-r><C-w>//c<Left><Left>
nnoremap <Leader>r :.,$s/<C-r><C-w>//c<Left><Left>

nnoremap <Leader>h :call HighlightWord("<C-r><C-w>")<CR>
nnoremap <Leader>tn :$tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>

nnoremap <Leader>c  :call ClipboardBuffer()<CR>
nnoremap <Leader>dt :ToggleVimdiff<CR>
nnoremap <Leader>du :wa <BAR> diffupdate<CR>
nnoremap <Leader>do :VimdiffFileContext<CR>
nnoremap <Leader>db :ShowUnsavedChanges<CR>

nnoremap <Leader><Space> :WhitespaceMelt<CR>

" Mappings for the forgotten Umlaute keys
" use command :ascii or 'ga' on the character you like to find the code

nnoremap <char-252> :set invhlsearch<CR>
nnoremap <char-220> :set invrelativenumber<CR>
nnoremap <char-246> [
vnoremap <char-246> [
nnoremap <char-228> ]
vnoremap <char-228> ]
nnoremap <char-214> ?
nnoremap <char-196> /

nnoremap <silent> <A-left> :call FastForwardAndRewind("rewind")<cr>
nnoremap <silent> <A-right> :call FastForwardAndRewind("fastforward")<cr>
if has('nvim')
  nnoremap <silent> <A-.> :tj <C-r><C-w><CR>
  nnoremap <silent> <A-,> :pop<CR>
endif
inoremap <C-Tab> <C-x><C-]>
nnoremap <C-Insert> "*yiw

nnoremap <A-k> :cprevious<CR>zz
nnoremap <A-j> :cnext<CR>zz

nnoremap <F1>    :execute "botright copen " . max([ &lines/2, 10 ])<CR>
nnoremap <F2>    :if &bt == 'quickfix' <bar> wincmd p <bar> endif <bar> cclose<cr>
nnoremap <F3>    :find<Space>
nnoremap <F4>    :cnext<CR>zz
nnoremap <S-F4>  :cprev<CR>zz
nnoremap <F12>   :tjump /
nnoremap <F5>    :SCRun<Space>
nnoremap <F6>    :Welcome<CR>
nnoremap <S-F5>  :SCBuffer<CR>

nnoremap <F7>      :silent make<space><up><CR>
nnoremap <C-F7>    :silent make<space><up>
nnoremap <Leader>m :silent make<space><up><CR>
nnoremap <Leader>M :silent make<space><up>

nnoremap <f8>       :silent grep <C-r><C-w><CR>
nnoremap <Leader>g  :silent grep <C-r><C-w>
nnoremap <Leader>G  :silent grep<Space>

nnoremap <F11>  :TagbarOpen<CR>

" check my spelling
nnoremap <Leader>se :setlocal spell spelllang=en_us<CR>
nnoremap <Leader>sg :setlocal spell spelllang=de_de<CR>
nnoremap <Leader>so :setlocal nospell<CR>

" run Vims own grep on files directories
nnoremap <Leader>1 :wall<CR> :vimgrep //j <C-r>=simplify(fnameescape(expand("%:p:h")) . "\\*." . &filetype)<CR><C-b><C-Right><Right><Right>
nnoremap <Leader>2 :wall<CR> :vimgrep //j <C-r>=simplify(fnameescape(expand("%:p:h")) . "\\..\\**\\*." . &filetype)<CR><C-b><C-Right><Right><Right>

if has("win32") || has("win64")
  nnoremap <Leader>X :silent execute "!start explorer  " . expand ("%:p:h")<CR>
  nnoremap <Leader>x :silent execute "!start cmd /k cd " . expand ("%:p:h")<CR>
endif

cabbrev <expr> \\ expand("%:p:h")
cnoremap <A-.> <C-r>=expand("%:p:h")<CR>

" }}}

" Save when Neovim's losing or gaining focus
augroup ginit
  " clear group in case file sourced several times
  autocmd!
  " write all buffers when loosing focus
  autocmd FocusLost * :silent! wall
  " Reload changed buffers. Command rely on option 'autoread'
  autocmd FocusGained * :checktime
augroup END

colorscheme breeze
syntax on

" vim:sw=2:tw=0:nocindent:foldmethod=marker
