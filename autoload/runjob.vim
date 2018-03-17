" Neovim autoload file
"
" Description: Neovim flavored implementation of job handling. 

augroup Runjob
  autocmd!
  autocmd BufReadPost job.io :WhitespaceCleanup 
augroup END

if empty(mapcheck("<Leader>j", "n"))
  nnoremap <Leader>j :edit job.io<CR>
endif

function! s:JobHandler(job_id, data, event)
  if a:event == 'stdout' || a:event == 'stderr'
    let s:job_io += a:data
  elseif a:event == 'exit'
    call filter(s:job_io, '!empty(v:val)')
    call writefile(s:job_io, 'job.io', '')
    unlet s:job_io
    unlet s:job_id
    checktime
  endif
endfunction

function! runjob#GetStatus()
  if exists("s:job_id")
    return "[JOB" . s:job_id . "]"
  else
    return ""
  endif
endfunction

function! runjob#StartJob(commandString)
  call writefile(['[Busy ...]'], 'job.io', '')
  checktime
  let  s:job_io = []
  call add(s:job_io, '[' . a:commandString . ']')
  let s:job_id = jobstart(
        \ a:commandString, 
        \ {
        \  'on_stdout': function('s:JobHandler'),
        \  'on_stderr': function('s:JobHandler'),
        \  'on_exit': function('s:JobHandler'),
        \ })
endfunction
