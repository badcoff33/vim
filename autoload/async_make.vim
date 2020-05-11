

function! s:async_make_handler(job_id, data, event_type)
  if a:event_type == "stdout"
    call writefile(a:data, getenv('TEMP') .. '/job' .. a:job_id, 'a')
  elseif a:event_type == "stderr"
    call writefile(a:data, getenv('TEMP') .. '/job' .. a:job_id, 'a')
  else
    echomsg 'closing job ' .. a:job_id
    let iter = 0
    for d in g:make_async_jobs
      if d['job_id'] == a:job_id
        call remove(g:make_async_jobs, iter)
        break
      endif
      let iter += 1
    endfor
  endif
endfunction

function! async_make#stop(job_id)
  " get confirmation by job handler with event 'exit'
  call async#job#stop(a:job_id)
endfunction

function! async_make#jobs()
  echo len(g:make_async_jobs) "jobs active"
  for d in g:make_async_jobs
    echo "job" d['job_id'] ":  " d['cmd']
  endfor
endfunction

let g:make_async_jobs = []
let s:async_make_options = { 'on_stdout': function('s:async_make_handler'),
      \ 'on_stderr': function('s:async_make_handler'),
      \ 'on_exit': function('s:async_make_handler') }

function! async_make#start(make_cmd) abort
  let job_id = async#job#start( ['cmd', '/c', a:make_cmd], s:async_make_options )
  if job_id == 0
    echoerr 'job failed to start'
  else
    let g:make_async_jobs = add(g:make_async_jobs, { 'job_id':job_id , 'cmd': a:make_cmd})
    call delete(getenv('TEMP') .. '/job' .. job_id)
    echo "started job" job_id ":  " a:make_cmd
  endif
endfunction

" If you want to get the process id of the job
" let pid = async#job#pid(job_id)
"
" " If you want to wait the job:
" call async#job#wait([job_id], 5000)  " timeout: 5 sec
"
