vim9script

# Plugin: Easy access to the most used Vim resource files

if !has('win32') && !has('win64')
  finish
endif

g:user_vimrc = expand(getenv('LOCALAPPDATA') .. '/vim/user.vim')

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
nnoremap <Leader>vh :Lexplore <C-r>=expand("~/vimfiles")<CR><CR>
nnoremap <Leader>vl :setlocal<Space>
nnoremap <silent> <Leader>vu :edit <C-r>=g:user_vimrc<CR><CR>
nnoremap <silent> <Leader>vf :edit <C-r>=expand("~/vimfiles/after/ftplugin/" .. &ft .. ".vim")<CR><CR>
nnoremap <silent> <Leader>vc :edit <C-r>=expand("~/vimfiles/colors/" .. g:colors_name .. ".vim")<CR><CR>

# Show mappings
nnoremap <Leader>vm :nmap <buffer> <C-v><LocalLeader><CR>
nnoremap <expr> <Leader>vM ":nmap " .. (g:mapleader == " " ? "<C-v><Space<C-v>>" : g:mapleader)

defcompile
