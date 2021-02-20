
let g:jobs_active = get(g:, 'jobs_active', 0)

function! jobs#Active()
  return exists('g:job_active') && g:job_active==1 ? 1 : 0
endfunction

function! jobs#ToFrontBuffer()
  call lib#windows#PopupBuffer(g:job_bufnr)
endfunction

function! jobs#HideBuffer()
  call lib#windows#HideBuffer(g:job_bufnr)
endfunction

function! AsyncErrorHandler(channel, msg)
endfunction

function! AsyncCloseHandler(channel)
  let g:job_active = 0
  call lib#popup#TopLeft([
        \ "Stop process " .. ch_getjob(a:channel),
        \ printf("Process toke %.3f seconds", reltimefloat(reltime(g:job_start_time)))])
endfunction

function! AsyncOutHandler(channel, msg)
endfunction

function! s:Head(cmdstr)
  normal ggVGx
  call append(0, '# ' .. a:cmdstr)
  call append(1, '-------------------------------------------------------------------------------')
endfunction

function! jobs#UseAsQuickfix()
  execute "cbuffer" g:job_bufnr
endfunction

function! jobs#Start(cmd) abort
  let g:job_bufnr = bufnr('<job-output>', v:true)
  execute "buffer" g:job_bufnr
  setlocal buftype=nofile nonumber norelativenumber modifiable
  nnoremap <buffer> <CR>  :cbuffer<CR>
  nnoremap <buffer> <Esc> <C-w>c
  call s:Head(a:cmd)
  buffer #
  if &autowrite || &autowriteall
    wall
  endif
  let s:async_make_options = {
        \ 'close_cb': 'AsyncCloseHandler',
        \ 'err_cb': 'AsyncErrorHandler',
        \ 'out_cb': 'AsyncOutHandler',
        \ 'out_io': 'buffer',
        \ 'err_io': 'buffer',
        \ 'out_buf': g:job_bufnr,
        \ 'err_buf': g:job_bufnr}
  let job = job_start('cmd /C '..a:cmd, s:async_make_options )
  let id = job_info(job)['process']
  if job_info(job)['status'] == 'run'
    let g:job_active = 1
    let g:job_start_time = reltime()
    call lib#popup#Bottom([
          \ "Start process " .. id])
  else
    let g:job_active = 0
    call lib#popup#Bottom([
          \ "Failed process " .. id .. ": " .. a:cmd])
    echoerr 'job failed to start'
  endif
endfunction

