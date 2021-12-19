
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
" here is an example:
"
" let g:rc = {
"          \ 'C:\Users\Tom\Documents\Workspaces\_':
"          \  [ 'set path=.,Main,XcpBasicDrv,,',
"          \    'set grepprg=rg\ --vimgrep\ -g\ *.[ch]\ $*',
"          \    'command! -nargs=0 CtagsCommand Ctags -R Main XcpBasicDrv',
"          \    'compiler iar'
"          \  ]
"          \ }
function! wdconfig#Read(dir)
  if !exists("g:rc")
    return
  endif
  if g:rc->has_key(a:dir)
    for v in g:rc[a:dir]
      echo ":execute" v
      execute v
    endfor
  else
    echomsg "no commands for \""..a:dir.."\""
  endif
endfunction

