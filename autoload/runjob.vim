" Neovim autoload file
"
" Description: Neovim flavored implementation of job handling. 

augroup Runjob
  autocmd!
  autocmd BufReadPost job.io :WhitespaceCleanup 
augroup END

function! s:JobHandler(job_id, data, event)
  if a:event == 'stdout' || a:event == 'stderr'
    let s:job_io += a:data
  elseif a:event == 'exit'
    call filter(s:job_io, '!empty(v:val)')
    call writefile(s:job_io, 'job.io', '')
    unlet s:job_io
    checktime
  endif
endfunction

function! runjob#StartJob(commandString)
  let l:opts = {
        \ 'on_stdout': function('s:JobHandler'),
        \ 'on_stderr': function('s:JobHandler'),
        \ 'on_exit': function('s:JobHandler'),
        \ }
  let  s:job_io = []
  call writefile(['[Busy ...]'], 'job.io', '')
  checktime
  call add(s:job_io, '[' . a:commandString . ']')
  let s:job = jobstart(a:commandString, l:opts)
endfunction
