vim9script

# Plugin: Easy access to the most used Vim resource files

if !has('win32') && !has('win64')
  finish
endif

g:user_vimrc = expand(getenv('LOCALAPPDATA') .. '/user-startup.vim')

def CreateNewUserFile()
  execute ":0read " expand(g:vim_home .. "/templates/user_vimrc.vim")
  execute "saveas" expand(g:user_vimrc)
enddef

augroup GroupVimfiles
  au!
  execute 'autocmd BufNewFile' fnamemodify(g:user_vimrc, ':t') 'call CreateNewUserFile()'
  autocmd VimEnter * {
    if filereadable(g:user_vimrc)
      execute('source ' .. g:user_vimrc)
    endif
  }
augroup END

nnoremap <silent> <Leader>vv :edit <C-r>=expand("~/vimfiles/vimrc")<CR><CR>
nnoremap <silent> <Leader>vu :edit <C-r>=g:user_vimrc<CR><CR>
nnoremap <silent> <Leader>vf :edit <C-r>=expand("~/vimfiles/after/ftplugin/" .. &ft .. ".vim")<CR><CR>
nnoremap <silent> <Leader>vc :edit <C-r>=expand("~/vimfiles/colors/" .. g:colors_name .. ".vim")<CR><CR>

defcompile
