" Neovim autoload file
"
" Description: Neovim flavored implementation of job handling. 

if !exists("g:job_cwd")
  let g:job_cwd = fnamemodify(".", ":p")
endif

function! s:JobHandler(job_id, data, event)
  if a:event == 'stdout' || a:event == 'stderr'
    if len(a:data)
      let s:job_io += a:data
    endif
  elseif a:event == 'exit'
    execute "cd " . g:job_cwd
    call filter(s:job_io, '!empty(v:val)')
    cexpr s:job_io
    cd -
    unlet s:job_io
    unlet s:job_id
  endif
endfunction

function! runjob#GetStatus()
  if exists("s:job_id")
    return "[JOB " . s:job_id . "]"
  else
    return ""
  endif
endfunction

function! runjob#SetCwd(path)
  let g:job_cwd = fnamemodify(a:path, ":p")
endfunction

function! runjob#StartJob(commandString)
  if exists("s:job_id")
    echomsg "wait for job " . s:job_id
    return
  endif
  let s:job_io = []
  let s:job_id = jobstart(
        \ a:commandString, 
        \ {
        \  'on_stdout': function('s:JobHandler'),
        \  'on_stderr': function('s:JobHandler'),
        \  'on_exit': function('s:JobHandler'),
        \  'cwd': g:job_cwd
        \ })
endfunction
