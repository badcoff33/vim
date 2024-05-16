" Vim plugin file

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : (CompleteAllowed() == v:true ? "\<C-n>" : "\<TAB>" )
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-n>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
cnoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Description: Returns forward and backward chars at cursor position.
" At lines end or start of line, a blank dictionary entry is returned.
function! s:NeighborChars()
  let col = col('.') - 1
  let line = getline('.')
  let length = len(line)
  let d = {}
  let d['rearview'] = (col == 0) ? '' : line[col - 1]
  let d['frontview']  = (col == length) ? '' : line[col]
  return d
endfunction
let g:a=[0,0,0]

function! CompleteAllowed()
  let chars = s:NeighborChars()
  if (chars.rearview !~ "[ \t]") && ((chars.frontview =~ '\([^a-zA-Z0-9_]\)') || (chars.frontview == ''))
    return v:true
  else
    return v:false
  endif
endfunction
