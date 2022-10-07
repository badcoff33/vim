" Description: Execute function, found in the list g:config_functions
"
" let g:config_functions = [
"      \ 'cfg-func_A',
"      \ ...
"      \ }

function! CompleteConfigFunc(a,l,p)
  let g:config_functions = get(g:, 'config_functions', {})
  if (type(g:config_functions) != v:t_list) && (len(g:config_functions) == 0)
    echomsg "variable g:config_functions is not a list or empty"
  endif
  return filter(sort(g:config_functions), 'v:val =~ a:a')
endfun

function! SourceFunction(func_name)
  let Fref = function(a:func_name)
  execute "verbose function" a:func_name
  call Fref()
endfunction

command! -complete=customlist,CompleteConfigFunc -nargs=1 ConfigRead call SourceFunction("<args>")
