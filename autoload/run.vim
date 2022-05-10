
let s:run_ani_string = '-\|/'

function! GetJobDictName(hdl)
  return "g:run"..ch_info(a:hdl)["id"]
endfunction

function! run#append(ch, msg)
  let list_name = GetJobDictName(a:ch).."['lines']"
  execute "let" list_name "=" list_name "+ [a:msg]"
endfunction

function! run#close(ch)
  call timer_stop(g:run_tid)
  call popup_close(g:run_ani_winid)
  unlet g:run_ani_winid
  let dict_name = GetJobDictName(a:ch)
  execute 'call setqflist([], "r", ' dict_name ')'
  let text = "job done: "..eval(dict_name..'["title"]')
  if eval(dict_name..'["popup"]') == 1
    let winid = lib#popup#top_left(text)
    call setwinvar(winid, "&wrap", 0)
  endif
endfunction

function! run#hidden_error(ch,msg)
  echohl ErrorMsg
  echo 'error reported by ch' ch_info(a:ch)['id'] '-->' a:msg
  echohl None
endfunction

function! run#run(dict)
  let job_opts = {}
  if &autowrite || &autowriteall
    try
      silent wall
    catch /.*/
      echoerr "run#run: not all modified buffers written"
    finally
    endtry
  endif
  if exists('a:dict.cwd')
    let job_opts.cwd = a:dict.cwd
  else
    let job_opts.cwd = getcwd()
  endif
  if !exists('a:dict.hidden') || (a:dict.hidden == 0)
    let job_opts.out_cb = function("run#append")
    let job_opts.err_cb = function("run#append")
    let job_opts.close_cb = function("run#close")
  else
    let job_opts.err_cb = function("run#hidden_error")
  endif
  if exists('a:dict.cwd')
    let job_opts.cwd = a:dict.cwd
  endif
  if !exists('a:dict.regexp')
    let regexp = &errorformat
  else
    let regexp = a:dict.regexp
  endif
  if exists('a:dict.notify') && (a:dict.notify != 0)
    let close_popup = 1
  else
    let close_popup = 0
  endif
  if exists('a:dict.cmd')
    let j = job_start('cmd /C '.a:dict['cmd'], job_opts)
    let d = #{title: a:dict["cmd"], lines: [], efm: regexp, popup: close_popup}
    execute "let "..GetJobDictName(j).."= copy(d)"
    if ( job_status(j) == "run" ) && !exists("g:run_ani_winid") && ( !exists('a:dict.hidden') || (a:dict.hidden == 0) )
      let g:run_tid = timer_start(200, function("run#alive"), #{repeat: -1})
      let g:run_ani_index = 0
      let g:run_ani_winid = popup_create(s:run_ani_string[0], #{
            \ line: 1,
            \ col: 1,
            \ tabpage: -1,
            \ highlight: 'PmenuSel',
            \ padding: [0,0,0,0],
            \ })
    endif
  endif
endfunction

function! run#alive(...)
  if g:run_ani_index >= ( len(s:run_ani_string) - 1 )
    let g:run_ani_index = 0
  else
    let g:run_ani_index += 1
  endif
  call setbufline(winbufnr(g:run_ani_winid), 1, s:run_ani_string[g:run_ani_index])
endfunction
