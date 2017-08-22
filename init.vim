" Neovim resource file
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
set viminfo='50,<1000,s100,:50

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
set foldcolumn=2
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
set completeopt=menu,longest
set pumheight=10

" Command line completion
set nowildmenu wildmode=list:full
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
      normal ]c
    elseif &filetype == "diff"
      execute search('^\(diff\|@@\)','W')
    elseif &filetype == "help"
      execute search('^[0-9\.]\+\s\+[A-Z]\+.*\*[a-z-]\+\*','W')
    else
      normal ]]
    endif

  elseif a:direction == "rewind"

    if &diff
      normal [c
    elseif &filetype == "diff"
      execute search('^\(diff\|@@\)','bW')
    elseif &filetype == "help"
      execute search('^[0-9\.]\+\s\+[A-Z]\+.*\*[a-z-]\+\*','bW')
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

function! Hello()

  let l:hello_text_file = '~/Documents/hello.txt'

  if filereadable(expand(l:hello_text_file))
    execute 'edit ' . l:hello_text_file
    nmap <buffer> <CR> 0y$:<C-r>"<CR>
  endif

endfunction

function! HighlightWord(word)

  if !exists("s:thisHighlightWord")
    let s:thisHighlightWord = ""
  endif
  echo s:thisHighlightWord
  if a:word != s:thisHighlightWord
    let s:thisHighlightWord = a:word
    execute ":match MyMatchGroup /\\<" . a:word . "\\>/"
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

command! -nargs=0 Hello call Hello()
command! -nargs=0 ShowHiName call HiName()
command! -nargs=0 WhitespaceCleanup call whitespace#Cleanup()
command! -nargs=0 WhitespaceMelt call whitespace#Melt()
command! -nargs=0 ShowUnsavedChanges call vimdiff#UnsavedChanges()
command! -nargs=0 ToggleVimdiff call vimdiff#Toggle()
command! -nargs=0 VimdiffFileContext call vimdiff#FileContext()
command! -complete=file -nargs=+ SCRun call shellcommand#Run([<f-args>])
command! -nargs=0 SCBuffer call shellcommand#ShowBuffer()

" }}}

" autocommands {{{

augroup Init

  autocmd!

  " How to handle multiple windows?
  autocmd VimResized * wincmd =

  autocmd BufReadPost * call RestoreCursor()

  autocmd BufWritePre *.c,*.h :WhitespaceCleanup
  autocmd BufWritePre *.py    :WhitespaceCleanup

  autocmd VimEnter,ColorScheme *  highlight MyMatchGroup gui=underline

  " read file templates (according to :help template)
  autocmd BufNewFile  workspace.vim   0r ~/vimfiles/templates/workspace.vim
  autocmd BufNewFile  *.c             0r ~/vimfiles/templates/file.c
  autocmd BufNewFile  *.h             0r ~/vimfiles/templates/file.h

augroup END

" }}}

" mappings {{{

" Set leader and localleader keys, that works best for me
let mapleader=" "
let maplocalleader="-"

" surround visual selection with ", ', (, [
vnoremap <Leader>" c"<C-R>-"<Esc>
vnoremap <Leader>' c'<C-R>-'<Esc>
vnoremap <Leader>( c(<C-R>-)<Esc>
vnoremap <Leader>[ c[<C-R>-]<Esc>

" Try this! Use <C-V><Tab> to insert a real tab
inoremap <Tab> <Esc>

" Mappings for fast quickfix access
nnoremap <A-n> :cnext<CR>
nnoremap <A-N> :cprev<CR>

" extend abbreviation
inoremap <C-Tab> <C-]>

" Indent and re-select visual block
nnoremap <Leader>R :%s/<C-r><C-w>//c<Left><Left>
nnoremap <Leader>r :.,$s/<C-r><C-w>//c<Left><Left>

nnoremap <Leader>c :clist<cr>
nnoremap <Leader>g :silent grep <C-r><C-w><CR>
nnoremap <Leader>G :silent grep <C-r><C-w>
nnoremap <Leader>h :call HighlightWord("<C-r><C-w>")<CR>
nnoremap <Leader>t :tjump <C-r><C-w><CR>
nnoremap <Leader>T :tjump <C-r><C-w>

nnoremap <Leader>dt :ToggleVimdiff<CR>
nnoremap <Leader>do :VimdiffFileContext<CR>
nnoremap <Leader>db :ShowUnsavedChanges<CR>

nnoremap <Leader><Space> :WhitespaceMelt<CR>

nnoremap <silent> <C-up>   :call FastForwardAndRewind("rewind")<cr>
nnoremap <silent> <C-down> :call FastForwardAndRewind("fastforward")<cr>

" Mappings for the forgotten Umlaute keys
" use command :ascii or 'ga' on the character you like to find the code

nnoremap <char-252> :set invhlsearch<CR>
nnoremap <char-220> :set invrelativenumber<CR>
nnoremap <char-196> ?
nnoremap <char-228> /
nnoremap <char-246> :cnext<CR>
nnoremap <char-214> :cprev<CR>

" jump to previous window
nnoremap <BS> <C-w>w
nnoremap <S-BS> <C-w>W

nnoremap <F1>   :edit %:p:h<CR>
nnoremap <F2>   :find<Space>
nnoremap <F3>   :buffer<Space>
nnoremap <F4>   :stjump <C-r><C-w>
nnoremap <F5>   :SCRun<Space>
nnoremap <S-F5> :SCBuffer<CR>
nnoremap <F6>   :$tabnew<CR>
nnoremap <S-F6> :tabclose<CR>
nnoremap <F7>   :silent make<space><up><CR>
nnoremap <C-F7> :silent make<space><up>
nnoremap <f8>   :Hello<CR>
nnoremap <F12>  :TagbarOpenAutoClose<CR>

" check my spelling
nnoremap <Leader>se :setlocal spell spelllang=en_us<CR>
nnoremap <Leader>sg :setlocal spell spelllang=de_de<CR>
nnoremap <Leader>sn :setlocal nospell<CR>

" run Vims own grep on files directories
nnoremap <Leader>1 :wall<CR> :vimgrep //j <C-r>=simplify(fnameescape(expand("%:p:h")) . "\\*." . &filetype)<CR><C-b><C-Right><Right><Right>
nnoremap <Leader>2 :wall<CR> :vimgrep //j <C-r>=simplify(fnameescape(expand("%:p:h")) . "\\..\\**\\*." . &filetype)<CR><C-b><C-Right><Right><Right>

if has("win32") || has("win64")
  nnoremap <Leader>x :silent execute "!start explorer " . expand ("%:p:h")<CR>
  nnoremap <Leader>X :silent execute "!start cmd /k cd " . expand ("%:p:h")<CR>
endif

cabbrev xd <C-r>=expand("%:p:h")<CR>

" }}}

" environment {{{

" English, please
let $LANG="en_US"

" Make Vim's own binaries the first match
let $PATH = $VIMRUNTIME . ";" . $PATH

" }}}

" vim:sw=2:tw=0:nocindent:foldmethod=marker
