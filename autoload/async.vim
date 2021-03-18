" Vim plugin term -- run job asynchron

let g:term_active = get(g:, 'term_active', 0)

function! async#JobActive()
  return exists('g:term_job_active') && g:term_job_active==1 ? 1 : 0
endfunction

function! async#JobBufferToFront()
  call lib#windows#PopupBuffer(g:term_job_bufnr)
endfunction

function! async#HideJobBuffer()
  call lib#windows#HideBuffer(g:term_job_bufnr)
endfunction

function! AsyncErrorHandler(channel, msg)
endfunction

function! AsyncCloseHandler(channel)
  let g:term_job_active = 0
  call lib#popup#TopLeft([
        \ "Stop process " .. ch_getjob(a:channel),
        \ printf("Process toke %.3f seconds", reltimefloat(reltime(g:term_job_start_time)))])
  if s:term_auto_quickfix == 1
    execute '3,$cbuffer' g:term_job_bufnr
  endif
endfunction

function! AsyncOutHandler(channel, msg)
endfunction

function! s:Head(cmdstr)
  normal ggVG"_x
  let head_str  = '# started ' .. strftime("%Y-%m-%d %X") .. '& '
  let separator = '###############################################################################'
  call append(0, [head_str .. a:cmdstr, separator])
  call prop_clear(1, 2)
  call prop_add(1, 1, {'length': len(head_str), 'type': 'term_head'})
  call prop_add(1, len(head_str), {'length': len(a:cmdstr) + 1, 'type': 'term_cmd'})
  call prop_add(2, 1, {'length': len(separator), 'type': 'term_head'})
endfunction

function! async#JobBufferAsQuickfix()
  execute "3,$cbuffer" g:term_job_bufnr
endfunction

if empty(prop_type_get('term_head'))
  call prop_type_add('term_head', {'highlight': 'Comment'})
  call prop_type_add('term_cmd', {'highlight': 'Title'})
endif

function! async#StartJob(cmd, ...) abort
  let g:term_job_bufnr = bufnr('<job-output>', v:true)
  if &autowrite || &autowriteall
    try
      wall
    catch /.*/
      echo "Couldn't write all buffers"
    finally
      ls +
    endtry
  endif
  let s:term_auto_quickfix = (a:0 == 1) ? a:1 : 0
  execute "buffer" g:term_job_bufnr
  setlocal buftype=nofile nonumber norelativenumber modifiable
  nnoremap <buffer> <CR>  :3,$cbuffer<CR>
  nnoremap <buffer> <Esc> <C-w>c
  call s:Head(a:cmd)
  buffer #
  let s:async_make_options = {
        \ 'close_cb': 'AsyncCloseHandler',
        \ 'err_cb': 'AsyncErrorHandler',
        \ 'out_cb': 'AsyncOutHandler',
        \ 'out_io': 'buffer',
        \ 'err_io': 'buffer',
        \ 'out_buf': g:term_job_bufnr,
        \ 'err_buf': g:term_job_bufnr
        \ }
  let job = job_start('cmd /C '..a:cmd, s:async_make_options )
  let id = job_info(job)['process']
  if job_info(job)['status'] == 'run'
    let g:term_job_active = 1
    let g:term_job_start_time = reltime()
    call lib#popup#Bottom(["Start process " .. id])
  else
    let g:term_job_active = 0
    call lib#popup#Bottom(["Failed process " .. id .. ": " .. a:cmd])
    echoerr 'job failed to start'
  endif
endfunction

" Description: Popup to first not finished term buffer in buffer list.
function! async#PopupTerm()
  for b in term_list()
    if term_getstatus(b) != 'normal'
      call lib#windows#GotoBuffer(b)
      return
    endif
  endfor
  terminal
endfunction

function! async#CloseFinishedTerm()
  for b in term_list()
    if term_getstatus(b) == 'finished'
      execute 'bdelete' b
    endif
  endfor
endfunction

