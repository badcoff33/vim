" Vim plugin files

set statusline=%{unique#GetUniqueName()}%t%m%r%y%w\ %l/%L,%c%{GetSearchMode()}\ %=%{GetScope()}

function! GetSearchMode()
  if &ignorecase == 1 && &smartcase == 1
    return 's'
  elseif &ignorecase == 0
    return 'c'
  else
    return 'i'
  endif
endfunction

" Description: If a function ScopeParser&ft exists, call it. The returned
" string can be used by 'statusline'. Recommended way to add new parser
" functions is in a file, located in after/ftplugin/&ft/scope.vim. Most
" important is that the function ScopeParser&ft exists.
function! GetScope()
  let parser_str = 'scope#Parser' . toupper(&ft[0]) . &ft[1:]
  try
    let Parser = function(parser_str)
    return Parser()
  catch
    return ''
  endtry
endfunction

augroup statusline
  au!
  au WinEnter * :call unique#UpdateUniqueName()
  au BufWinEnter * :call unique#UpdateUniqueName()
augroup END



