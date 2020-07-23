let g:job_list = []

" Description: Capture data and skip empty lines. Process data for the closed
" job.
function! s:async_make_handler(id, data, event_type)
  if a:event_type == "stdout"
    call writefile(filter(a:data, 'v:val !~ "^\s*$"'), getenv('TEMP') .. '/job' .. a:id, 'a')
  elseif a:event_type == "stderr"
    call writefile(filter(a:data, 'v:val !~ "^\s*$"'), getenv('TEMP') .. '/job' .. a:id, 'a')
  else
    if filereadable(getenv('TEMP') .. '/job' .. a:id)
      execute "cgetfile " .. getenv('TEMP') .. '/job' .. a:id
    endif
    let iter = 0
    for d in g:job_list
      if d['id'] == a:id
        call s:PopupList("Closing job " .. a:id, [d['cmd']])
        call remove(g:job_list, iter)
        break
      endif
      let iter += 1
    endfor
  endif
endfunction

function! jobs#stop(id)
  " get confirmation by job handler with event 'exit'
  call lib#job#stop(a:id)
endfunction

function! jobs#jobs()
  let text_as_list = []
  let num_of_jobs = len(g:job_list)
    for d in g:job_list
      call add(text_as_list, "job "..d['id']..":"..d['cmd'])
    endfor
  if num_of_jobs == 0
    let title = "No jobs active"
  elseif num_of_jobs == 1
    let title = "One job active"
  else
    let title = num_of_jobs.." jobs active"
  endif
  call s:PopupList(title, text_as_list)
endfunction

let g:job_list = []
let s:async_make_options = { 'on_stdout': function('s:async_make_handler'),
      \ 'on_stderr': function('s:async_make_handler'),
      \ 'on_exit': function('s:async_make_handler') }

function! jobs#start(make_cmd) abort
  let id = lib#job#start( ['cmd', '/c', a:make_cmd], s:async_make_options )
  if id == 0
    echoerr 'job failed to start'
  else
    let g:job_list = add(g:job_list, { 'id':id , 'cmd': a:make_cmd})
    call delete(getenv('TEMP') .. '/job' .. id)
    call writefile(['job'..id..': '..a:make_cmd], getenv('TEMP') .. '/job' .. id, 'a')
    call s:PopupList("Start job " .. id, [a:make_cmd])
  endif
endfunction


if has('nvim')

function! s:PopupList(title, list_of_strings)
  echo a:title
  for text in a:list_of_strings
    echo text
  endfor
endfunction
finish

endif

" Description: Show a popup with the arguments as a  list in the upper right
" corner.
function! s:PopupList(title, list_of_strings)
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
        \ 'title': a:title,
        \ })
  call setwinvar(winid, '&wincolor', 'WarningMsg')
endfunction

" If you want to get the process id of the job
" let pid = lib#job#pid(id)
"
" " If you want to wait the job:
" call lib#job#wait([id], 5000)  " timeout: 5 sec
"
