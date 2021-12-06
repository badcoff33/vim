" Vim plugin term -- run job asynchron

let g:async_auto_quickfix = get(g:, 'async_auto_quickfix', 0)

function! async#JobActive()
  return exists('g:async_job_active') && g:async_job_active==1 ? 1 : 0
endfunction

function! async#JobBufferToFront()
  call lib#windows#PopupBuffer(g:async_job_bufnr)
endfunction

function! async#ToggleJobOutput()
  call lib#windows#ToggleBuffer(g:async_job_bufnr)
endfunction

function! AsyncCloseHandler(channel)
  let g:async_job_active = 0
  call lib#popup#Bottom([
        \ "Job " .. ch_status(a:channel),
        \ printf("run for %.3f seconds", reltimefloat(reltime(g:async_job_start_time)))])
  if g:async_auto_quickfix == 1
    execute 'cbuffer' g:async_job_bufnr
  endif
endfunction

function! async#StartJob(cmd) abort
  let g:async_job_bufnr = bufnr('<job-output>', v:true)
  let abufnr = bufnr('%')
  execute 'buffer' g:async_job_bufnr
  normal gg"_dG
  if abufnr != g:async_job_bufnr
    buffer #
  endif
  if &autowrite || &autowriteall
    try
      wall
    catch /.*/
      echomsg "modified buffers not written"
    finally
    endtry
  endif
  call setbufvar(g:async_job_bufnr, "&buftype", "nofile")
  call setbufvar(g:async_job_bufnr, "&number", 0)
  call setbufvar(g:async_job_bufnr, "&relativenumber", 0)
  call setbufvar(g:async_job_bufnr, "&modifiable", 1)
  call setbufline(g:async_job_bufnr, 1, '-- started ' .. strftime("%Y-%m-%d %X") .. ': ' .. a:cmd)
  call setbufline(g:async_job_bufnr, 2, '----------------------------------------')
  let options = {
        \ 'out_io': "buffer", "out_buf": g:async_job_bufnr,
        \ 'err_io': "buffer", "err_buf": g:async_job_bufnr,
        \ "close_cb": "AsyncCloseHandler"}
  let job = job_start('cmd /C ' .. a:cmd, options)
  let id = job_info(job)['process']
  if job_info(job)['status'] == 'run'
    let g:async_job_active = 1
    let g:async_job_start_time = reltime()
  else
    let g:async_job_active = 0
    call lib#popup#Bottom(["Failed process " .. id .. ": " .. a:cmd])
    echoerr 'job failed to start'
  endif
endfunction

" Description: Go to first not finished term buffer in buffer list.
function! async#OpenTerm()
  for b in term_list()
    if getbufvar(b, 'home_term', 0) == 1
      call lib#windows#GotoBuffer(b)
      return
    endif
  endfor
  botright terminal
  let b:home_term = 1
endfunction

function! async#CloseFinishedTerm()
  for b in term_list()
    if term_getstatus(b) == 'finished'
      execute 'bdelete' b
    endif
  endfor
endfunction

