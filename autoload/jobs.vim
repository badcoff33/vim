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
        call s:PopupList(["Closing #" .. a:id  .. ":" .. d['cmd']])
        call remove(g:job_list, iter)
        break
      endif
      let iter += 1
    endfor
  endif
endfunction

function! jobs#stop(id)
  " get confirmation by job handler with event 'exit'
  let iter = 0
  for d in g:job_list
    if d['id'] == a:id
      echo a:id
      call s:PopupList(["Stopping #" .. a:id ..":" .. d['cmd']])
      call lib#job#stop(a:id)
      call remove(g:job_list, iter)
      break
    endif
    let iter += 1
  endfor
endfunction

function! jobs#active()
  return len(g:job_list) ? 1 : 0
endfunction

function! jobs#jobs()
  let text_as_list = []
  let num_of_jobs = len(g:job_list)
  if num_of_jobs == 0
    let title = "No jobs active"
  elseif num_of_jobs == 1
    let title = "One job active"
  else
    let title = num_of_jobs.." jobs active"
  endif
  call add(text_as_list, title)
  for d in g:job_list
    call add(text_as_list, "#" .. d['id'] .. ":" .. d['cmd'])
  endfor
  call s:PopupList(text_as_list)
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
    call s:PopupList(["Start #" .. id .. ":" .. a:make_cmd])
  endif
endfunction


if has('nvim')

function! s:PopupList(list_of_strings)
  call lib#popup#OpenFloatingWin(a:list_of_strings)
endfunction
finish

endif

" Description: Show a popup with the arguments as a  list in the upper right
" corner.
function! s:PopupList(list_of_strings)
  let winid = popup_create(a:list_of_strings, {
        \ 'line': 1,
        \ 'col': 1,
        \ 'minwidth': &columns,
        \ 'maxheight': 10,
        \ 'minheight': argc(),
        \ 'time': 3000,
        \ 'tabpage': -1,
        \ 'zindex': 300,
        \ 'drag': 1,
        \ 'close': 'click',
        \ 'padding': [0,1,0,1],
        \ 'title': "",
        \ })
  call setwinvar(winid, '&wincolor', 'TabLineSel')
endfunction
