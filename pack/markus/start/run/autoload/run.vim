function! run#Append(channel, msg)
  let c = split(a:channel,' ')[1]
  let b = bufnr("__job_channel".c)
  call bufload(b)
  call appendbufline(b, '$', a:msg)
endfunction

function! run#Exit(job, status)
  let c = split(job_getchannel(a:job),' ')[1]
  let b = bufnr("__job_channel".c)
  execute "cbuffer ".b
  execute "silent bw!" b
endfunction

function! run#Run(d)
  let options = {}
  if &autowrite || &autowriteall
    try
      silent wall
    catch /.*/
      echoerr "run#Run: not all modified buffers written"
    finally
    endtry
  endif
  if has_key(a:d, 'cwd')
    let options.cwd = a:d.cwd
  else
    let options.cwd = getcwd()
  endif
  if !(has_key(a:d, 'hidden') && (a:d.hidden != 0))
    let options.out_cb = function("run#Append")
    let options.err_cb = function("run#Append")
    let options.close_cb = function("run#Exit")
  endif
  if has_key(a:d, 'cmd')
    let j = job_start('cmd /C '.a:d['cmd'], options)
    if !(has_key(a:d, 'hidden') && (a:d.hidden != 0))
      let c = split(job_getchannel(j),' ')[1]
      let b = bufadd("__job_channel".c)
      call setbufvar(b, "&buftype", "nofile")
      call setbufline(b, 1, '-- '.strftime("%Y-%m-%d %X"))
    endif
    echomsg "job running in channel" c
  endif
endfunction
