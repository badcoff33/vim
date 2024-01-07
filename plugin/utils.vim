vim9script

import autoload "popups.vim"
import autoload "quickfix.vim"

def g:BackwardSlashToForward()
  s#\\#/#g
  call histdel("/", -1)
enddef

def g:ForwardSlashToBackward()
  s#/#\\#g
  call histdel("/", -1)
enddef

augroup GroupUtils " {{{
  autocmd!
  autocmd BufNewFile .vimrc execute "0read" g:vim_home.."\\templates\\local_vimrc"
  autocmd DirChanged global if filereadable(".vimrc") | call popups.OneLinePopup("local .vimrc") | endif
augroup END " }}}

nnoremap <Leader>/ :call ForwardSlashToBackward()<CR>
nnoremap <Leader>\ :call BackwardSlashToForward()<CR>
nnoremap <Leader>? <Cmd>call popups#PopupFiletypeHelp()<CR>
nnoremap <Leader><Leader> :call quickfix#ToggleQuickfix()<CR>

defcompile
