" Vim plugin file

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
cnoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

inoremap <expr> <TAB> InsertTabOrComplete()
inoremap <expr> <S-TAB> "\<C-p>"

function InsertTabOrComplete()
  if pumvisible() != 0
    let char = "\<C-n>"
  else
    if (CompleteAllowed() == v:true)
      let char = "\<C-n>"
    else
      let char = "\<TAB>"
    endif
  endif
  return char
endfunction

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
