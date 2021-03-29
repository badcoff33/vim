" Vim plugin Log It!
" Description: A notes and diary file keep track on draft text (goes into notes
" file) and a log file (goes into the diary file). No further bells and
" whistles.

let g:notes_file = get(g:, 'notes_file', '~\.notes\notes.txt')
let g:diary_file = get(g:, 'diary_file', '~\.notes\diary.txt')

nnoremap <Leader>nn :drop <C-r>=g:notes_file<cr><cr>
nnoremap <Leader>nd :drop <C-r>=g:diary_file<cr><cr>

execute 'autocmd BufEnter' fnamemodify(g:diary_file, ':t') 'nnoremap <buffer> + :call logit#AddNewEntry()<CR>i'

