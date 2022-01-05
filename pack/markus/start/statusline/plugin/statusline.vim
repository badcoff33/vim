" Vim plugin files

set statusline =%{unique#GetUniqueName()}%t
set statusline+=\ %m%r%y%w%{GetSearchMode()}\ (%l,%c)
set statusline+=%=
set statusline+=%#StatuslineNC#%{scope#GetScope()}

function! GetSearchMode()
  if &ignorecase == 1 && &smartcase == 1
    return '[sc]'
  elseif &ignorecase == 0
    return '[cs]'
  else
    return '[ic]'
  endif
endfunction

