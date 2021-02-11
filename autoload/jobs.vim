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

function! AsyncErrorHandler(channel, msg)
  let g:job_active = 0
  call lib#popup#Bottom([
        \ "Failed process " .. ch_getjob(a:channel),
        \ "Output buffer: JOB",
        \ "> "..a:msg])
endfunction

function! AsyncCloseHandler(channel)
  let g:job_active = 0
  call lib#popup#Bottom([
        \ "Stop process " .. ch_getjob(a:channel),
        \ "Output buffer: JOB"])
endfunction

function! AsyncOutHandler(channel, msg)
endfunction

function! jobs#Start(cmd) abort
  let save_winnr = winnr()
  if !bufexists('JOB')
    let g:jobs_bufnr = bufadd('JOB')
    vsplit JOB
    setlocal buftype=nofile
    nnoremap <buffer> <CR>  :cbuffer<CR><C-w>c
    nnoremap <buffer> <Esc> <C-w>c
  else
    let bufwinnr = bufwinnr(g:jobs_bufnr)
    if bufwinnr > 0
      execute bufwinnr . "wincmd w"
      normal ggVGx
    else
      wincmd v
      wincmd L
      execute "buffer".g:jobs_bufnr
      normal ggVGx
    endif
  endif
  execute save_winnr . "wincmd w"
  let s:async_make_options = {
        \ 'close_cb': 'AsyncCloseHandler',
        \ 'err_cb': 'AsyncErrorHandler',
        \ 'out_cb': 'AsyncOutHandler',
        \ 'out_io': 'buffer',
        \ 'err_io': 'buffer',
        \ 'out_buf': g:jobs_bufnr,
        \ 'err_buf': g:jobs_bufnr}
  let job = job_start('cmd /C '..a:cmd, s:async_make_options )
  let id = job_info(job)['process']
  if job_info(job)['status'] == 'run'
    let g:job_active = 1
    call lib#popup#Bottom([
          \ "Start process " .. id .. ": " .. a:cmd,
          \ "Output buffer: JOB("..g:jobs_bufnr..")"])
  else
    let g:job_active = 0
    call lib#popup#Bottom([
          \ "Failed process " .. id .. ": " .. a:cmd])
    echoerr 'job failed to start'
  endif
endfunction

