" Vim autoload file

function! s:JobHandler(job_id, data, event) 
  if a:event == 'stdout'
    for l in a:data
      caddexpr substitute(l, '\r', '', '')
    endfor
  elseif a:event == 'stderr'
    for l in a:data
      caddexpr substitute(l, '\r', '', '')
    endfor
    elseif a:event == 'exit'
    clist   
  endif
endfunction

function! async#RunMake(commandString)
  let l:opts = {
        \ 'on_stdout': function('s:JobHandler'),
        \ 'on_stderr': function('s:JobHandler'),
        \ 'on_exit': function('s:JobHandler'),
        \ }
  cexpr []
  doautocmd QuickFixCmdPre make
  let g:job = jobstart(a:commandString, l:opts)
  doautocmd QuickFixCmdPost make
endfunction
