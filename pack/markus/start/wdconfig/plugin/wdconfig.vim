
" Description: Execute commands for key, found in the dictionary g:wdconfig
" Dictionary required with this structured required:
"
" let g:wdconfig = {
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
  let g:wdconfig = get(g:, 'wdconfig', {})
  if (type(g:wdconfig) != v:t_dict) && (len(g:rc) == 0)
    echomsg "variable g:wdconfig is no dictionary or empty"
  endif
  return filter(keys(g:wdconfig), 'v:val =~ a:a')
endfun

command! -complete=customlist,CompleteWdConfig -nargs=1 ReadWdConfig call wdconfig#Read('<args>')
