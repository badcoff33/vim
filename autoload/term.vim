
let g:term_active = get(g:, 'term_active', 0)
let g:term_auto_quickfix = get(g:, 'term_auto_quickfix', 1)

function! term#JobActive()
  return exists('g:term_job_active') && g:term_job_active==1 ? 1 : 0
endfunction

function! term#ToFrontBuffer()
  call lib#windows#PopupBuffer(g:term_job_bufnr)
endfunction

function! term#HideBuffer()
  call lib#windows#HideBuffer(g:term_job_bufnr)
endfunction

function! AsyncErrorHandler(channel, msg)
endfunction

function! AsyncCloseHandler(channel)
  let g:term_job_active = 0
  call lib#popup#TopLeft([
        \ "Stop process " .. ch_getjob(a:channel),
        \ printf("Process toke %.3f seconds", reltimefloat(reltime(g:term_job_start_time)))])
  if g:term_auto_quickfix
    execute 'cbuffer' g:term_job_bufnr
  endif
endfunction

function! AsyncOutHandler(channel, msg)
endfunction

function! s:Head(cmdstr)
  normal ggVGx
  call append(0, '# <' .. strftime("%Y-%m-%d %X") .. '> ' .. a:cmdstr)
  call append(1, '===============================================================================')
endfunction

function! term#UseAsQuickfix()
  execute "cbuffer" g:term_job_bufnr
endfunction

function! term#Start(cmd) abort
  let g:term_job_bufnr = bufnr('<job-output>', v:true)
  execute "buffer" g:term_job_bufnr
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
        \ 'out_buf': g:term_job_bufnr,
        \ 'err_buf': g:term_job_bufnr}
  let job = job_start('cmd /C '..a:cmd, s:async_make_options )
  let id = job_info(job)['process']
  if job_info(job)['status'] == 'run'
    let g:term_job_active = 1
    let g:term_job_start_time = reltime()
    call lib#popup#TopLeft([
          \ "Start process " .. id])
  else
    let g:term_job_active = 0
    call lib#popup#Bottom([
          \ "Failed process " .. id .. ": " .. a:cmd])
    echoerr 'job failed to start'
  endif
endfunction

