let g:job_list = []

" Description: Capture data and skip empty lines. Process data for the closed
" job.
function! s:async_make_handler(job_id, data, event_type)
  if a:event_type == "stdout"
    call writefile(filter(a:data, 'v:val !~ "^\s*$"'), getenv('TEMP') .. '/job' .. a:job_id, 'a')
  elseif a:event_type == "stderr"
    call writefile(filter(a:data, 'v:val !~ "^\s*$"'), getenv('TEMP') .. '/job' .. a:job_id, 'a')
  else
    execute "cgetfile " .. getenv('TEMP') .. '/job' .. a:job_id
    let iter = 0
    for d in g:job_list
      if d['job_id'] == a:job_id
        call s:PopupList(["closing job " .. a:job_id .. ":" .. d['cmd']])
        call remove(g:job_list, iter)
        break
      endif
      let iter += 1
    endfor
  endif
endfunction

function! jobs#stop(job_id)
  " get confirmation by job handler with event 'exit'
  call lib#job#stop(a:job_id)
endfunction

function! jobs#jobs()
  let text_as_list = []
  call add(text_as_list, len(g:job_list).." jobs active")
  for d in g:job_list
    call add(text_as_list, ["job " .. d['job_id'] .. ":" .. d['cmd']])
  endfor
  call s:PopupList(text_as_list)
endfunction

let g:job_list = []
let s:async_make_options = { 'on_stdout': function('s:async_make_handler'),
      \ 'on_stderr': function('s:async_make_handler'),
      \ 'on_exit': function('s:async_make_handler') }

function! jobs#start(make_cmd) abort
  let job_id = lib#job#start( ['cmd', '/c', a:make_cmd], s:async_make_options )
  if job_id == 0
    echoerr 'job failed to start'
  else
    let g:job_list = add(g:job_list, { 'job_id':job_id , 'cmd': a:make_cmd})
    call delete(getenv('TEMP') .. '/job' .. job_id)
    call s:PopupList(["starting job " .. job_id .. ":" .. a:make_cmd])
  endif
endfunction

" Description: Show a popup with the arguments as a  list in the upper right
" corner.
function! s:PopupList(list_of_strings)
  let best_fit = 20
  for a in a:list_of_strings
    if len(a) > best_fit
      let best_fit = len(a)
    endif
  endfor
  let winid = popup_create(a:list_of_strings, {
        \ 'line': 2,
        \ 'col': &columns - best_fit - 5,
        \ 'minwidth': 20,
        \ 'maxheight': 10,
        \ 'minheight': argc(),
        \ 'time': 3000,
        \ 'tabpage': -1,
        \ 'zindex': 300,
        \ 'drag': 1,
        \ 'close': 'click',
        \ 'padding': [0,1,0,1],
        \ 'title': "Job Message:",
        \ })
  call setwinvar(winid, '&wincolor', 'WarningMsg')
endfunction

" If you want to get the process id of the job
" let pid = lib#job#pid(job_id)
"
" " If you want to wait the job:
" call lib#job#wait([job_id], 5000)  " timeout: 5 sec
"
