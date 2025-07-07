vim9script

set signcolumn=number

sign_define([{name: 'changed',
    text: '!',
    texthl: 'DiffChanged'
}])

augroup GroupTracker
  au!
  au FileChangedShell,CursorHold * {
    if &ft != 'netrw' && &bt != 'terminal'
      sign_unplace("changed")
      for e in getchangelist(bufnr("%"))[0]
        sign_place(0, '', 'changed', bufname('%'),
          {lnum: e.lnum}
        )
      endfor
    endif
  }
augroup END

