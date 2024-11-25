vim9script

# Plugin: Easy access to the most used Vim resource files

g:user_vimrc = expand(getenv('LOCALAPPDATA') .. '/user.vim')

def CreateNewUserFile()
  execute ":0read " expand(g:vim_home .. "/templates/user_vimrc.vim")
  execute "saveas" expand(g:user_vimrc)
enddef

def ExecuteUserFile()
  if filereadable(g:user_vimrc)
    autocmd VimEnter * execute 'source' g:user_vimrc
  endif
enddef

augroup GroupVimfiles
  autocmd!
  autocmd BufNewFile user2.vim call CreateNewUserFile()
  autocmd VimEnter   *         call ExecuteUserFile()
augroup END

nnoremap <silent> <Leader>vv :edit <C-r>=expand("~/vimfiles/vimrc")<CR><CR>
nnoremap <silent> <Leader>vu :edit <C-r>=g:user_vimrc<CR><CR>
nnoremap <silent> <Leader>vf :edit <C-r>=expand("~/vimfiles/after/ftplugin/" .. &ft .. ".vim")<CR><CR>
nnoremap <silent> <Leader>vc :edit <C-r>=expand("~/vimfiles/colors/" .. g:colors_name .. ".vim")<CR><CR>
defcompile

