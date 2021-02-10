let g:job_list = []

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

function! Async_error_handler(channel)
  echomsg "ERR"
endfunction

function! Async_close_handler(channel)
  let iter = 0
  let id = split(ch_getjob(a:channel))[1]
  for d in g:job_list
    if d['id'] == id
      call s:PopupList(["Stopping #" .. id ..": " .. d['cmd']])
      call remove(g:job_list, iter)
      break
    endif
    let iter += 1
  endfor
endfunction

function! Async_out_handler(channel, msg)
  echomsg "out" a:msg
endfunction

let s:async_make_options = {
      \ 'close_cb': 'Async_close_handler',
      \ 'err_cb': 'Async_error_handler',
      \ 'out_cb': 'Async_out_handler',
      \ 'out_io': 'file',
      \ 'err_io': 'file',
      \ 'out_name': 'out',
      \ 'err_name': 'out'}

function! jobs#run_bg(cmd) abort
  let job = job_start('cmd /C '..a:cmd, s:async_make_options )
  let id = job_info(job)['process']
  if job_info(job)['status'] == 'run'
    let g:job_list = add(g:job_list, { 'id': id, 'cmd': a:cmd})
    "call delete(getenv('TEMP') .. '/job' .. id)
    "call writefile(['job'..id..': '..a:cmd], s:GetJobFile(id), 'a')
    call s:PopupList(["Start #" .. id .. ": " .. a:cmd])
  else
    echoerr 'job failed to start'
  endif
endfunction

function! jobs#run(cmd) abort
   execute ":terminal ++shell "..a:cmd
   let b:started_as_job = 1
   nnoremap <buffer> <CR> :cbuffer<CR><C-w>c
   nnoremap <buffer> <Esc> <C-w>c
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
