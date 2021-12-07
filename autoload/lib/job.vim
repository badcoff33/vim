" Vim plugin term -- run job asynchron

let g:job_do_auto_quickfix = get(g:, 'job_do_auto_quickfix', 0)

function! lib#job#JobActive()
  return exists('g:job_active') && g:job_active==1 ? 1 : 0
endfunction

function! lib#job#JobBufferToFront()
  call lib#windows#PopupBuffer(g:job_bufnr)
endfunction

function! lib#job#ToggleJobOutput()
  call lib#windows#ToggleBuffer(g:job_bufnr)
endfunction

function! AsyncCloseHandler(channel)
  let g:job_active = 0
  call lib#popup#Bottom([
        \ "Job " .. ch_status(a:channel),
        \ printf("run for %.3f seconds", reltimefloat(reltime(g:job_start_time)))])
  if g:job_do_auto_quickfix == 1
    execute 'cbuffer' g:job_bufnr
  endif
endfunction

function! lib#job#StartJob(cmd) abort
  let g:job_bufnr = bufnr('<job-output>', v:true)
  let abufnr = bufnr('%')
  execute 'buffer' g:job_bufnr
  normal gg"_dG
  if abufnr != g:job_bufnr
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
  call setbufvar(g:job_bufnr, "&buftype", "nofile")
  call setbufvar(g:job_bufnr, "&number", 0)
  call setbufvar(g:job_bufnr, "&relativenumber", 0)
  call setbufvar(g:job_bufnr, "&modifiable", 1)
  call setbufline(g:job_bufnr, 1, '-- job started on ' .. strftime("%Y-%m-%d %X") .. ': ' .. a:cmd)
  let options = {
        \ 'out_io': "buffer", "out_buf": g:job_bufnr,
        \ 'err_io': "buffer", "err_buf": g:job_bufnr,
        \ "close_cb": "AsyncCloseHandler"}
  let job = job_start('cmd /C ' .. a:cmd, options)
  let id = job_info(job)['process']
  if job_info(job)['status'] == 'run'
    let g:job_active = 1
    let g:job_start_time = reltime()
  else
    let g:job_active = 0
    call lib#popup#Bottom(["Failed process " .. id .. ": " .. a:cmd])
    echoerr 'job failed to start'
  endif
endfunction

