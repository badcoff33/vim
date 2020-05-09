function! s:handler(job_id, data, event_type)
  echom "id:" a:job_id
  echom "event:" a:event_type
  if a:event_type == "stdout"
    call setqflist([], 'r', {'title': 'My search'})
    echom "data:" a:data
  endif
endfunction

if has('win32') || has('win64')
  let argv = ['cmd', '/c', 'dir c:\ /b']
else
  let argv = ['bash', '-c', 'ls']
endif

let jobid = async#job_start(argv, {
      \ 'on_stdout': function('s:handler'),
      \ 'on_stderr': function('s:handler'),
      \ 'on_exit': function('s:handler'),
      \ })

if jobid > 0
  echom 'job started'
else
  echom 'job failed to start'
endif

" If you want to get the process id of the job
" let pid = async#job_pid(jobid)
"
" " If you want to wait the job:
" call async#job_wait([jobid], 5000)  " timeout: 5 sec
"
" " If you want to stop the job:
" call async#job_stop(jobid)
