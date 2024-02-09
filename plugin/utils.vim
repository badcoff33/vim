vim9script

import autoload "popnews.vim"
import autoload "quickfix.vim"
import autoload "utils.vim"

g:last_search = ""
g:user_vimrc = expand(g:vim_home .. '/pack/user/start/' .. getenv('USERNAME') .. '/plugin/user.vim')

def g:SaveLastSearch()
  g:last_search = getreg('/')
enddef

def g:RestoreLastSearch()
  histdel('searcH', -1)
  setreg('/', g:last_search)
enddef

def g:BackwardSlashToForward()
  s#\\#/#ge
  call histdel("/", -1)
enddef

def g:ForwardSlashToBackward()
  s#/#\\#ge
  call histdel("/", -1)
enddef

if !filereadable(g:user_vimrc)
  mkdir(fnamemodify(g:user_vimrc, ':p:h'), 'p')
  execute "edit" expand(g:vim_home .. "/templates/user_vimrc.vim")
  execute "write" g:user_vimrc
endif

augroup GroupUtils " {{{
  autocmd!
  autocmd BufNewFile .vimrc execute "0read" g:vim_home .. "\\templates\\local_vimrc.vim"
  autocmd DirChanged global if filereadable(".vimrc") | call popnews.Open("local .vimrc") | endif
augroup END " }}}

# export def Map(mapcmd: string,  lhs: string, rhs: string)

utils.Map('nnoremap', '<Leader>/', ':call ForwardSlashToBackward()<CR>')
utils.Map('nnoremap', '<Leader>\', ':call BackwardSlashToForward()<CR>')
utils.Map('nnoremap', '<Leader>?', '<Cmd>call popnews#PopupFiletypeHelp()<CR>')
utils.Map('nnoremap', '<Leader>q', ':call quickfix#ToggleQuickfix()<CR>')

utils.Map('nnoremap', '<Leader>vv', ':edit <C-r>=expand("~/vimfiles/vimrc")<CR><CR>')
utils.Map('nnoremap', '<Leader>vu', ':edit <C-r>=g:user_vimrc<CR><CR>')
utils.Map('nnoremap', '<Leader>vf', ':edit <C-r>=expand("~/vimfiles/after/ftplugin/" .. &ft .. ".vim")<CR><CR>')

defcompile
