function! run#Append(channel, msg)
  let b = bufadd("__channel".ch_info(a:channel)['id'])
  call bufload(b)
  call setbufvar(b, "&buftype", "nofile")
  call appendbufline(b, '$', a:msg)
endfunction

function! run#Exit(channel)
  let b = bufadd("__channel".ch_info(a:channel)['id'])
  call bufload(b)
  execute "cbuffer ".b
  execute "silent bw!" b
endfunction

function! run#HiddenError(channel,msg)
  echohl ErrorMsg
  echo 'error reported by channel' ch_info(a:channel)['id']
  echo '-->' s:msg
  echohl None
endfunction

function! run#Run(dict)
  let options = {}
  if &autowrite || &autowriteall
    try
      silent wall
    catch /.*/
      echoerr "run#Run: not all modified buffers written"
    finally
    endtry
  endif
  if exists('a:dict.cwd')
    let options.cwd = a:dict.cwd
  else
    let options.cwd = getcwd()
  endif
  if !exists('a:dict.hidden') && (a:dict.hidden != 0))
    let options.out_cb = function("run#Append")
    let options.err_cb = function("run#Append")
    let options.close_cb = function("run#Exit")
  else
    let options.err_cb = function("run#HiddenError")
  endif
  if exists('a:dict.cmd')
    let j = job_start('cmd /C '.a:dict['cmd'], options)
  endif
endfunction
