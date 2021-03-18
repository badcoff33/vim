
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent> <expr> <C-Space>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>CompletionInhibit() ? "\<TAB>" :
      \ "\<C-x>\<C-]>"
inoremap <C-S-Space> <C-p>

inoremap <silent> <expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>CompletionInhibit() ? "\<TAB>" :
      \ "\<C-n>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Description: Returns forward and backward char at cursor position.
" At lines end or start of line, a blank dictionary entry is returned.
function! s:neighbors()
  let col = col('.') - 1
  let line = getline('.')
  let length = len(line)
  let char_backward = (col == 0) ? '' : line[col - 1]
  let char_forward = (col == length) ? '' : line[col]
  return {'backward': char_backward, 'forward': char_forward}
endfunction

function! s:CompletionInhibit() abort
  let n = s:neighbors()
  return empty(n['backward'])
        \ || (n['backward'] =~? '\s')
        \ || (n['backward'] =~? '\w') && (n['forward'] =~? '\w')
endfunction

