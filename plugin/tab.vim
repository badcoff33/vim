" Vim plugin file

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : (InsertTab() == v:true ? "\<TAB>" : "\<C-n>")
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-n>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
cnoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Description: Returns forward and backward char at cursor position.
" At lines end or start of line, a blank dictionary entry is returned.
function! NeighborChars()
  let col = col('.') - 1
  let line = getline('.')
  let length = len(line)
  let d= {}
  let d['backward'] = (col == 0) ? '' : line[col - 1]
  let d['forward']  = (col == length) ? '' : line[col]
  return d
endfunction

function! InsertTab()
  let n = NeighborChars()
  if n['backward'] == ''
    return v:true
  elseif n['backward'] =~? '\s'
    return v:true
  else
    return v:false
  endif
endfunction
