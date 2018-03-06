" Vim autoload file

function! s:JobHandler(job_id, data, event) 
  if a:event == 'stdout'
    caddexpr a:data
  elseif a:event == 'stderr'
    caddexpr a:data
  else
    echomsg 'exited'
  endif
endfunction

function! async#RunMake(commandString)
  let l:opts = {
        \ 'on_stdout': function('s:JobHandler'),
        \ 'on_stderr': function('s:JobHandler'),
        \ 'on_exit': function('s:JobHandler'),
        \ 'cwd': getcwd()
        \ }
  cexpr []
  let g:job = jobstart(a:commandString, l:opts)
endfunction


