"    ____     ___ __    __      _____  ____  _        ___
"   |    \   /  _]  |__|  |    |     ||    || |      /  _]
"   |  _  | /  [_|  |  |  |    |   __| |  | | |     /  [_
"   |  |  ||    _]  |  |  |    |  |_   |  | | |___ |    _]
"   |  |  ||   [_|  `  '  |    |   _]  |  | |     ||   [_
"   |  |  ||     |\      /     |  |    |  | |     ||     |
"   |__|__||_____| \_/\_/      |__|   |____||_____||_____|

" Options for the Ctags executable
let g:ctags_options = [
      \ "-R",
      \ "--fields=+n",
      \ "Sources/main",
      \ "Sources/lib",
      \ ]

" for plugin/rg.vim
let g:rg_paths = [ "Sources" ]
let g:rg_excludes = [ "tools", "build"]

" Look-up path for :find, 'gf' and friends
set path=source/**,.,,

" case-sensitive tag search
set tagcase=match

" Set compiler (sets 'errorformat') and 'makeprg'
compiler ninja
" use :make like this ':make -build Debug'
set makeprg=ninja

augroup GroupLocal
    au!
    " Remember last state of work
    autocmd VimLeave * mksession! .session.vim
    autocmd BufEnter CMakeLists.txt setfiletype cmake
augroup END
packadd signify

SignifyEnableAll
