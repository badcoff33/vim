vim9script

import autoload 'popnews.vim' as news

def g:Execute(command = "")
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
    term_sendkeys(tbufnr, ((mode() == "n") ? "i" : "") .. command .. "\<CR>" )
  else
    news.Open('No terminal running -- Open terminal with command :terminal')
  endif
enddef

augroup GroupTerminal
  au!
  au TerminalOpen * setlocal signcolumn=no nocursorline foldcolumn=0
  au TerminalOpen * setlocal nonumber norelativenumber
augroup END

nnoremap <Leader>X :call g:Execute(input("command: "))<CR>

defcompile
