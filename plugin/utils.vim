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
  autocmd DirChanged global {
    if filereadable(".vimrc")
      call popnews.Open("local .vimrc available")
    endif
  }
augroup END " }}}

if filereadable(".vimrc")
  call popnews.Open("local .vimrc available")
endif

# nice presentation of v:errors, filled by assert functions
command! -nargs=0 AssReport for e in v:errors | echo e | endfor

def g:LookupWord()
  var size: number
  var wid = win_getid()
  if match(&errorformat, '%f:%l:%m') < 0
    set errorformat+=%f:%l:%m
  endif
  setloclist(wid, [], " ", {"title": "word in " .. fnamemodify(bufname("%"), ":t")})
  execute 'g/' .. expand("<cword>") .. '/call setloclist(win_getid(), [], "a", {"lines": [bufname("%") .. ":" .. line(".") .. ":" .. getline(".")]})'
  size = getloclist(wid, {'nr': '$', 'size': 0}).size
  nnoremap <buffer> <LocalLeader><Esc> <Cmd>lclose<CR>
  if size > 0
    execute 'botright lopen ' .. min([size, &lines / 3])
    nnoremap <buffer> <Esc> <C-w>p<Cmd>lclose<CR>
    nnoremap <buffer> j <Cmd>lnext<CR>zz<C-w>p
    nnoremap <buffer> k <Cmd>lprevious<CR>zz<C-w>p
  endif
enddef

# export def Map(mapcmd: string,  lhs: string, rhs: string)

utils.Map('nnoremap', '<Leader>l', ':call g:LookupWord()<CR>')
utils.Map('nnoremap', '<Leader>/', ':call ForwardSlashToBackward()<CR>')
utils.Map('nnoremap', '<Leader>\', ':call BackwardSlashToForward()<CR>')
utils.Map('nnoremap', '<Leader>?', '<Cmd>call popnews#PopupFiletypeHelp()<CR>')
utils.Map('nnoremap', '<Leader>q', ':call quickfix#ToggleQuickfix()<CR>')

utils.Map('nnoremap', '<Leader>vv', ':edit <C-r>=expand("~/vimfiles/vimrc")<CR><CR>')
utils.Map('nnoremap', '<Leader>vu', ':edit <C-r>=g:user_vimrc<CR><CR>')
utils.Map('nnoremap', '<Leader>vf', ':edit <C-r>=expand("~/vimfiles/after/ftplugin/" .. &ft .. ".vim")<CR><CR>')
utils.Map('nnoremap', '<Leader>vc', ':edit <C-r>=expand("~/vimfiles/colors/" .. g:colors_name .. ".vim")<CR><CR>')

defcompile
