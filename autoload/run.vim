function! GetJobDictName(hdl)
  return "g:run"..ch_info(a:hdl)["id"]
endfunction

function! run#Append(ch, msg)
  let list_name = GetJobDictName(a:ch).."['lines']"
  execute "let" list_name "=" list_name "+ [a:msg]"
endfunction

function! run#Close(ch)
  let dict_name = GetJobDictName(a:ch)
  execute 'call setqflist([], "r", ' dict_name ')'
  let text = "job done: "..eval(dict_name..'["title"]')
  let text = text[:&columns - 2]
  call popup_create(text, #{
        \ line: &lines,
        \ col: &columns - len(text),
        \ maxwidth: len(text),
        \ time: 2500,
        \ tabpage: -1,
        \ highlight: 'PmenuSel',
        \ padding: [1,1,1,1],
        \ })
endfunction

function! run#HiddenError(ch,msg)
  echohl ErrorMsg
  echo 'error reported by ch' ch_info(a:ch)['id'] '-->' a:msg
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
  if !exists('a:dict.hidden') || (a:dict.hidden == 0)
    let options.out_cb = function("run#Append")
    let options.err_cb = function("run#Append")
    let options.close_cb = function("run#Close")
  else
    let options.err_cb = function("run#HiddenError")
  endif
  if exists('a:dict.cmd')
    let j = job_start('cmd /C '.a:dict['cmd'], options)
    let d=#{title: a:dict["cmd"], lines:[], efm:&errorformat}
    execute "let "..GetJobDictName(j).."= copy(d)"
  endif
endfunction
