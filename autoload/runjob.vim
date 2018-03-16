" Vim autoload file

function! s:JobHandler(job_id, data, event)
  if a:event == 'stdout' || a:event == 'stderr'
    redir >> job.io
    for line in a:data
      echo substitute(line, '\r', '', '')
    endfor
    redir END
  elseif a:event == 'exit'
    autocmd BufReadPost job.io :WhitespaceCleanup 
    checktime
  endif
endfunction

function! runjob#StartJob(commandString)
  let l:opts = {
        \ 'on_stdout': function('s:JobHandler'),
        \ 'on_stderr': function('s:JobHandler'),
        \ 'on_exit': function('s:JobHandler'),
        \ }
  redir! > job.io
  execute 'echo "[' . a:commandString . ']"'
  redir END
  let s:job = jobstart(a:commandString, l:opts)
endfunction
