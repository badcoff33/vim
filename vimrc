" Vim resource file
"
" New Vim features are nicly tracked on this site:
"   https://www.arp242.net/vimlog/
"
" Maintainer: Markus Prepens (markus dot prepens at gmail dot com)

filetype plugin on
filetype indent on

set belloff=all
set clipboard=
set expandtab
set history=200
set keymodel=
set mouse=a
set noerrorbells
set more
set norelativenumber numberwidth=2
set noswapfile
set novisualbell
set nowrap
set report=0
set ruler
set selection=inclusive
set selectmode=
set shiftwidth=4
set shortmess-=S " Yes, search count please
set shortmess-=f " long form for file info
set showmatch matchtime=1
set showtabline=1
set tabstop=4
set termguicolors
set signcolumn=yes
set laststatus=2

" limit number of suggestions of z=
set spellsuggest=best,10
set spelllang=en_us,de_de
set spelloptions=camel

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
set backspace=indent,eol,start
set whichwrap+=<,>,[,]

" makes selecting text more consistent (at least for me)
set virtualedit=onemore,block

" Search: Some configuration for the search behavior.
set ignorecase smartcase
set incsearch
set hlsearch
set magic
set wrapscan

set backup
execute mkdir(getenv('LOCALAPPDATA') .. g:slash .. join(["vim", "backup"], g:slash) , "p")
execute 'set backupdir=' .. getenv('LOCALAPPDATA') .. '\vim\backup'
set wildignore+=*/backup/*

set undofile
execute mkdir(getenv('LOCALAPPDATA') .. g:slash .. join(["vim", "undo"], g:slash) , "p")
execute 'set undodir=' .. getenv('LOCALAPPDATA') .. '\vim\undo'
set wildignore+=*/undo/*

" Insert mode completion
set complete=.,w
set noshowfulltag
set completeopt=menu

set pumheight=7

" Command line completion
set wildmenu
set wildoptions=pum,tagfile,fuzzy
set wildmode=full:lastused
set nowildignorecase
set wildignore+=*.*~,*.o,TAGS
" How to handle search for tags
set tagcase=match

" Tune the diff feature for my needs.
set diffopt=internal,algorithm:minimal,context:8,vertical,iwhite,filler
" When starting in 'diff' mode, go full screen.
if &diff
    set columns=999 lines=999
endif
command! ShowChanges vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Living with QWERTZ keyboards
execute "set langmap+=\<Char-196>}"
execute "set langmap+=\<Char-246>["
execute "set langmap+=\<Char-228>]"
execute "set langmap+=\<Char-214>{"

" Switching modes
inoremap <k0> <Esc>
imap <Char-252> <Esc>

" Consistent cursor movement
noremap! <A-Left> <Home>
noremap! <A-Right> <End>
nnoremap <A-Left> <Home>
nnoremap <A-Right> <End>
vnoremap <A-Left> 0
vnoremap <A-Right> $

" Alternative keys to delete words in insert mode
inoremap <C-BS> <C-o>db
inoremap <C-Del> <C-o>de
cnoremap <C-BS> <C-w>
cnoremap <C-Del> <C-Right><C-w>

" Next/prev match,expand fold and recenter
nnoremap n nzzzv
nnoremap N Nzzzv

" Yank more consistent to D and dd commands
nnoremap Y y$
" Yank word under cursor
nnoremap <C-Insert> yiw

" Resizing window
let GrowWin = { -> "3wincmd + | 5wincmd >" }
let ShrinkWin = { -> winnr("j")==winnr() ? "5wincmd <" : "3wincmd - | 5wincmd <" }
nnoremap <A-+> :<C-r>=GrowWin()<CR><CR>
nnoremap <A--> :<C-r>=ShrinkWin()<CR><CR>

" increment/decrement numbers blockwise
vnoremap <C-x> <C-x>gv
vnoremap <C-a> <C-a>gv

" Shift left/right highlighted lines/block [count] 'shiftwidth' and reselect
" visual region
vnoremap > >gv
vnoremap < <gv

" To map <Esc> to exit terminal-mode: >
tnoremap <Esc>       <C-\><C-n>
tnoremap <LeftMouse> <C-\><C-n>

" Line bubbling, key mapping leant to scrolling keys C-e C-y
nnoremap <A-e> :move .-2<CR>==
vnoremap <A-e> :move '<-2<CR>==gv=gv
nnoremap <A-y> :move .+1<CR>==
vnoremap <A-y> :move '>+1<CR>==gv=gv

nnoremap <A-o> :bprevious<CR>
nnoremap <A-i> :bnext<CR>

" Command line abbreviations
cnoreabbrev <expr> vimgrep  (getcmdtype() ==# ':' && getcmdline() =~# '^vimgrep')  ? 'silent vimgrep'  : 'vimgrep'
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> make  (getcmdtype() ==# ':' && getcmdline() =~# '^make')  ? 'silent make'  : 'make'
cabbrev <expr> home $HOME .. g:slash .. 'vimfiles' .. g:slash
cabbrev <expr> here (FilePath() == ".") ? "." : FilePath()

let FilePath = { -> expand("%:h") == "" ? "" : expand("%:h") .. g:slash }
cnoremap <expr> <A-.> (FilePath() == ".") ? "." : FilePath()
cnoremap <expr> <A-,> $HOME .. g:slash .. 'vimfiles' .. g:slash
cmap <C-BS> <C-w>
cmap <C-Del> <C-Right><C-w>

" Surfing the quickfix matches
nnoremap <A-h> :colder<CR>
nnoremap <A-l> :cnewer<CR>
nnoremap <A-j> <cmd>cnext<CR>
nnoremap <A-k> <cmd>cprevious<CR>

" Move between windows - This is boring {{{
nnoremap <S-left> <C-w>h
nnoremap <S-right> <C-w>l
nnoremap <S-up> <C-w>k
nnoremap <S-down> <C-w>j
inoremap <S-left> <Esc><C-w>h
inoremap <S-right> <Esc><C-w>l
inoremap <S-up> <Esc><C-w>k
inoremap <S-down> <Esc><C-w>j
tnoremap <S-left> <Esc><C-w>h
tnoremap <S-right> <Esc><C-w>l
tnoremap <S-up> <Esc><C-w>k
tnoremap <S-down> <Esc><C-w>j
" }}}

" By default, <C-l> clears and redraws the screen (like :redraw!). The
" following mapping does a little bit more to keep the screen sane.
nmap <C-l> :nohlsearch<cr>:diffupdate<cr>:redraw!<cr>
imap <C-l> <Esc><C-l>

" Type a word, press below key sequence and "Enclose" `current` (word) {bang}!
inoremap <C-s>" <C-o>b"<Esc>ea"
inoremap <C-s>' <C-o>b'<Esc>ea'
inoremap <C-s>` <C-o>b`<Esc>ea`
inoremap <C-s>) <C-o>b(<Esc>ea)
inoremap <C-s>] <C-o>b[<Esc>ea]
inoremap <C-s>} <C-o>b{<Esc>ea}

let g:vim_home = expand('<sfile>:p:h')
let g:slash = exists('&shellslash') ? '\' : '/'

" set leader and localleader keys, that works best for me
let mapleader = " "
let maplocalleader = "!"

" quick note taking
nnoremap <expr> <Leader>n ":drop "..strftime("~/Documents/Notes/note-%d-%m-%y.txt".."<CR>:setfiletype markdown<CR>")

" toggle options
nnoremap <Leader>os <cmd>setlocal invspell spell?<CR>
nnoremap <Leader>op <cmd>setlocal invpaste paste?<CR>
nnoremap <Leader>or <cmd>setlocal invrelativenumber<CR>
nnoremap <Leader>ow <cmd>setlocal invwrap<CR>
nnoremap <Leader>og :<C-u>set grepprg=<C-r>=escape(&grepprg, ' ')<CR>

" Substitute command
nnoremap <Leader>s :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <Leader>s :s///gI<Left><Left><Left><Left>

" commands
nnoremap <Leader>E :edit <C-r>=$HOME .. g:slash .. 'vimfiles' .. g:slash<CR>
nnoremap <Leader>e :edit <C-r>=(FilePath() == ".") ? "." : FilePath()<CR>
nnoremap <Leader>t <cmd>tab split<CR>
nnoremap <Leader>f :find<Space>
nnoremap <Leader>b :buffer<Space>
nnoremap <Leader>d <cmd>bdelete<CR>

" Toggle the quickfix window
function! s:ToggleQuickfix()
    let is_open = v:false
    windo if &buftype== "quickfix" | let is_open = v:true | endif
    if is_open == v:false
        let qf = getqflist()
        let max_len = 0
        for qfentry in qf
            let max_len = len(qfentry["text"]) > max_len ? len(qfentry["text"]) : max_len
        endfor
        if max_len > (&columns / 3)
            botright copen
            wincmd p
        elseif winnr("$") == 1 && &columns >= 140
            vert copen
            wincmd p
            wincmd =
                else
            botright copen
                endif
    else
        if (winnr("$") == 1) && (&buftype=="quickfix")
            buffer #
        else
            cclose
            wincmd p
        endif
    endif
endfunction
nnoremap <BS> <cmd>call <SID>ToggleQuickfix()<CR>
nnoremap <Leader>G <cmd>clast<CR>

let g:ft2glob = { 'c':'*.[ch]$', 'vim':'*.vim', 'py':'*.py$', 'cmake':'*cmake*' }
let LsFilter = { ft -> has_key(g:ft2glob, ft) ? g:ft2glob[ft] : '*.*'}
nnoremap <expr> <Leader>g ':silent vimgrep /'..expand("<cword>")..'/ '..expand("%:h")..g:slash..LsFilter(&ft)

command! -nargs=0 IC :set   ignorecase nosmartcase
command! -nargs=0 CS :set noignorecase nosmartcase
command! -nargs=0 SC :set   ignorecase  smartcase

augroup GroupVimrc " {{{
    autocmd!
    autocmd WinEnter * checktime " Reload changed buffers. :checktime relies on 'autoread'.
    autocmd VimEnter * execute "colorscheme" ( (&term == "builtin_gui") ? "twotone" : "apollo" )
    autocmd FocusLost * try | silent wall | catch /.*/ | endtry
    autocmd BufNewFile .vimrc execute "0read" g:vim_home.."\\templates\\local_vimrc"
augroup END " }}}

let g:term = &term
syntax on

" Vim9: Workaround for gvim.exe since several keys didn't work on German keyboards {{{
nmap <C-+> g<C-]>
cmap <C-+> <C-]>
imap <C-Char-252> <C-[>
cmap <C-Char-252> <C-[>
" }}}

" vim:foldmethod=marker:foldenable:

