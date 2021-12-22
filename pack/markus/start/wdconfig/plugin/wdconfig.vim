
" Description: Execute commands for key, found in the dictionary g:rc
" Dictionary required with this structured required:
"
" let g:rc = {
"      \ '<NAME-A>':
"      \ [
"      \   '<command-a1>',
"      \   '<command-a2>',
"      \   '...'
"      \ ],
"      \ '<NAME-B>':
"      \ [
"      \   '<command-b1>',
"      \   '<command-b2>',
"      \   '...'
"      \ ]
"      \ }

function! CompleteWdConfig(a,l,p)
  let g:rc = get(g:, 'rc', {})
  if (type(g:rc) != v:t_dict) && (len(g:rc) == 0)
    echomsg "variable g:rc is no dictionary or empty"
  endif
  return filter(keys(g:rc), 'v:val =~ a:a')
endfun

command! -complete=customlist,CompleteWdConfig -nargs=1 ReadWdConfig call wdconfig#Read('<args>')
