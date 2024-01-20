vim9script

import autoload "popnews.vim"
import autoload "quickfix.vim"

def g:BackwardSlashToForward()
  s#\\#/#g
  call histdel("/", -1)
enddef

def g:ForwardSlashToBackward()
  s#/#\\#g
  call histdel("/", -1)
enddef

var user_vimrc: string = expand(g:vim_home .. '/pack/user/start/' .. getenv('USERNAME') .. '/plugin/user.vim')
if !filereadable(user_vimrc)
  mkdir(fnamemodify(user_vimrc, ':p:h'), 'p')
  execute "edit" expand(g:vim_home .. "/templates/user_vimrc.vim")
  execute "write" user_vimrc
endif

augroup GroupUtils " {{{
  autocmd!
  autocmd BufNewFile .vimrc execute "0read" g:vim_home .. "\\templates\\local_vimrc.vim"
  autocmd DirChanged global if filereadable(".vimrc") | call popups.News("local .vimrc") | endif
augroup END " }}}

nnoremap <Leader>/ :call ForwardSlashToBackward()<CR>
nnoremap <Leader>\ :call BackwardSlashToForward()<CR>
nnoremap <Leader>? <Cmd>call popnews#PopupFiletypeHelp()<CR>
nnoremap <Leader>q :call quickfix#ToggleQuickfix()<CR>

defcompile
