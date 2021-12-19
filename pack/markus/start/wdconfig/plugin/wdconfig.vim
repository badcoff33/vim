
" Description: When called with projects root directory as parameter, execute
" the store commands. Dictionary required with this structured required:
" let g:rc = {
"      \ '<dir-a>':
"      \ [
"      \   '<command-a1>',
"      \   '<command-a2>',
"      \   '...'
"      \ ],
"      \ '<dir-b>':
"      \ [
"      \   '<command-b1>',
"      \   '<command-b2>',
"      \   '...'
"      \ ]
"      \ }
"
command -nargs=0 ReadWdConfig  call wdconfig#Read(getcwd())
