" Vim plugin file

if v:true
  inoremap <expr> <TAB> (InsertTab() == v:true) ? "\<TAB>" : "\<C-]>"
else
  inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : (InsertTab() == v:true ? "\<TAB>" : "\<C-n>")
  inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-n>"
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
  cnoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
endif

" Description: Returns forward and backward char at cursor position.
" At lines end or start of line, a blank dictionary entry is returned.
function! NeighborChars()
  let col = col('.') - 1
  let line = getline('.')
  let length = len(line)
  let d= {}
  let d[0] = (col == 0) ? '' : line[col - 1]
  let d[1]  = (col == length) ? '' : line[col]
  return d
endfunction

function! InsertTab()
  let n = NeighborChars()
  if n[0] == ''
    return v:true
  elseif n[0] =~? '\s'
    return v:true
  else
    return v:false
  endif
endfunction
