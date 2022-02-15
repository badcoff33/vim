
" Description: Execute commands for key, found in the dictionary g:dircfg
" Dictionary required with this structured required:
"
" let g:dircfg = {
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

function! CompleteDircfg(a,l,p)
  let g:dircfg = get(g:, 'dircfg', {})
  if (type(g:dircfg) != v:t_dict) && (len(g:rc) == 0)
    echomsg "variable g:dircfg is no dictionary or empty"
  endif
  return filter(keys(g:dircfg), 'v:val =~ a:a')
endfun

command! -complete=customlist,CompleteDircfg -nargs=1 Readcfg call dircfg#Read('<args>')
