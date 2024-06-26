vim9script

import autoload 'popnews.vim' as news

def g:RunTerminal()
  var term_tbufnrs = term_list()
  var tbufnr = 0
  for b in term_list()
    if term_getstatus(b) =~ '.*running.*'
      tbufnr = b
      break
    endif
  endfor
  if tbufnr != 0
    var twinnr = bufwinnr(tbufnr)
    if twinnr == -1
      wincmd s
      wincmd J
      execute "buffer" tbufnr
    else
      execute ":" .. string(twinnr) .. "wincmd w"
    endif
    feedkeys((mode() == "n") ? "i" : "")
  else
    news.Open('No terminal running -- Open terminal with command :terminal')
  endif
enddef

augroup GroupTerminal
  au!
  au TerminalOpen * setlocal signcolumn=no nocursorline foldcolumn=0
  au TerminalOpen * setlocal nonumber norelativenumber
augroup END

nnoremap <Leader>x :call g:RunTerminal()<CR>

defcompile
