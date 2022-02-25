" Vim plugin files

augroup statusline
  au!
  au WinEnter * call unique#UpdateUniqueName()
augroup END

set statusline =\ %{unique#GetUniqueName()}%t
set statusline+=\ %m%r%y%w%{GetSearchMode()}
set statusline+=%=
set statusline+=%{scope#GetScope()}\ %l:%c

let &statusline=&statusline.." "

function! GetSearchMode()
  if &ignorecase == 1 && &smartcase == 1
    return '[sc]'
  elseif &ignorecase == 0
    return '[cs]'
  else
    return '[ic]'
  endif
endfunction

