
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
  let winid = popup_create(text, #{
        \ line: 1,
        \ col: 1,
        \ maxwidth: min([len(text), &columns / 2]),
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
    if ( job_status(j) == "run" ) && !exists("g:run_ani_winid") && ( !exists('a:dict.hidden') || (a:dict.hidden == 0) )
      let g:run_tid = timer_start(500, function("run#alive"), #{repeat: -1})
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
