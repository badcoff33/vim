function! GetJobDictName(hdl)
  return "g:run"..ch_info(a:hdl)["id"]
endfunction

function! run#append(ch, msg)
  let list_name = GetJobDictName(a:ch).."['lines']"
  execute "let" list_name "=" list_name "+ [a:msg]"
endfunction

function! run#close(ch)
  call timer_stop(g:tid_run)
  let dict_name = GetJobDictName(a:ch)
  execute 'call setqflist([], "r", ' dict_name ')'
  let text = "job done: "..eval(dict_name..'["title"]')
  let text = text[:&columns - 2]
  let width = min([len(text), &columns / 2])
  let winid = popup_create(text, #{
        \ line: &lines,
        \ col: &columns - width,
        \ maxwidth: width,
        \ time: 2500,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [1,1,1,1],
        \ })
  call setwinvar(winid, "&wrap", 0)
endfunction

function! run#hidden_error(ch,msg)
  echohl ErrorMsg
  echo 'error reported by ch' ch_info(a:ch)['id'] '-->' a:msg
  echohl None
endfunction

function! run#run(dict)
  let options = {}
  if &autowrite || &autowriteall
    try
      silent wall
    catch /.*/
      echoerr "run#run: not all modified buffers written"
    finally
    endtry
  endif
  if exists('a:dict.cwd')
    let options.cwd = a:dict.cwd
  else
    let options.cwd = getcwd()
  endif
  if !exists('a:dict.hidden') || (a:dict.hidden == 0)
    let options.out_cb = function("run#append")
    let options.err_cb = function("run#append")
    let options.close_cb = function("run#close")
  else
    let options.err_cb = function("run#hidden_error")
  endif
  if !exists('a:dict.regexp')
    let regexp = &errorformat
  else
    let regexp = a:dict.regexp
  endif
  if exists('a:dict.cmd')
    let j = job_start('cmd /C '.a:dict['cmd'], options)
    let d=#{title: a:dict["cmd"], lines: [], efm: regexp}
    execute "let "..GetJobDictName(j).."= copy(d)"
    if job_status(j) == "run"
      let g:tid_run = timer_start(1000, function("run#alive"), #{repeat: -1})
      let g:run_alive_sec = 0
    else
      unlet  g:tid_run
    endif
  endif
endfunction

function! run#alive(tid)
  cgetexpr "running "..g:run_alive_sec.." seconds"
  let g:run_alive_sec += 1
endfunction
