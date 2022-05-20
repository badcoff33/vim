" Description: Execute function, found in the list g:dircfg_functions
"
" let g:dircfg_functions = [
"      \ 'cfg-func_A',
"      \ ...
"      \ }

function! CompleteDircfg(a,l,p)
  let g:dircfg_functions = get(g:, 'dircfg_functions', {})
  if (type(g:dircfg_functions) != v:t_list) && (len(g:dircfg_functions) == 0)
    echomsg "variable g:dircfg_functions is not a list or empty"
  endif
  return filter(g:dircfg_functions, 'v:val =~ a:a')
endfun

function! SourceFunction(func_name)
  let Fref = function(a:func_name)
  execute "verbose function" a:func_name
  call Fref()
endfunction

command! -complete=customlist,CompleteDircfg -nargs=1 Readcfg call SourceFunction("<args>")
