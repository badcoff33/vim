" Options for the Ctags executable
let g:ctags_options = [
      \ "-R",
      \ "--fields=+n",
      \ "source/common",
      \ "source/consistency",
      \ "source/safetyLib",
      \ "source/eval_board_support"
      \ ]

" for plugin/rg.vim
let g:rg_paths = [ "source" ]
let g:rg_excludes = [ "tools", ".settings"]

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
