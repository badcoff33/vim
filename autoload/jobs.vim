let g:job_active = 0

function! jobs#Active()
  return exists('g:job_active') && g:job_active==1 ? 1 : 0
endfunction

function! jobs#CloseTermWindows()
  for b in term_list()
    if term_getstatus(b) == 'finished'
      execute 'bdelete' b
    endif
  endfor
  bwipe JOB
endfunction

function! AsyncErrorHandler(channel)
  let g:job_active = 0
  call lib#popup#Head([
        \ "Failed process " .. ch_getjob(a:channel),
        \ "Output buffer: JOB"])
endfunction

function! AsyncCloseHandler(channel)
  let g:job_active = 0
  call lib#popup#Head([
        \ "Stop process " .. ch_getjob(a:channel),
        \ "Output buffer: JOB"])
endfunction

function! AsyncOutHandler(channel, msg)
endfunction

function! jobs#Start(cmd) abort
  if bufexists('JOB')
    bwipe! JOB
  endif
  let out_buf = bufadd('JOB')
  let s:async_make_options = {
        \ 'close_cb': 'AsyncCloseHandler',
        \ 'err_cb': 'AsyncErrorHandler',
        \ 'out_cb': 'AsyncOutHandler',
        \ 'out_io': 'buffer',
        \ 'err_io': 'buffer',
        \ 'out_buf': bufnr("JOB"),
        \ 'err_buf': bufnr("JOB")}
  let job = job_start('cmd /C '..a:cmd, s:async_make_options )
  let id = job_info(job)['process']
  if job_info(job)['status'] == 'run'
    let g:job_active = 1
    call lib#popup#Head([
          \ "Start process " .. id .. ": " .. a:cmd,
          \ "Output buffer: JOB("..out_buf..")"])
    vsplit JOB
    nnoremap <buffer> <CR>  :cbuffer<CR><C-w>c
    nnoremap <buffer> <Esc> <C-w>c
    wincmd p
  else
    let g:job_active = 0
    echoerr 'job failed to start'
  endif
endfunction

