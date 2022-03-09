
function! visuals#hl_word_on()
  let cword = expand("<cword>")
  highlight HlWordUnderline gui=underline
  if matchstr(cword, "[a-zA-Z0-9_]") != ""
    execute "match HlWordUnderline /" .. cword .. "/"
    call timer_start(1001, function("visuals#hl_word_off"))
    call setwinvar(winnr(), "hl_word", cword)
  endif
endfunction

function! visuals#hl_word_off(tid)
  let cword = expand("<cword>")
  if cword == getwinvar(winnr(), "hl_word")
    call timer_start(1000, function("visuals#hl_word_off"))
  else
    match none
  end
endfunction

" Description: Make the actual window more obvious by temporary turn the
" option 'cursorline' on.
function! visuals#enable_blinky()
  let g:tid_cursorline = -1
  setlocal cursorline
  augroup StickyCursorline
    autocmd!
    autocmd WinLeave             * call visuals#turn_cursorline_off()
    autocmd BufWinEnter,WinEnter * call visuals#turn_cursorline_on()
  augroup END
endfunction

" Description: Stop function and release all resources
function! visuals#disable_blinky()
  let g:blinky_cursorline_on = 0
  setlocal nocursorline
  autocmd! StickyCursorline
endfunction

function! visuals#turn_cursorline_on()
  if (&diff == 0) && (&buftype == "")
    let g:tid_cursorline = timer_start(1000, function("visuals#turn_cursorline_off"))
    setlocal cursorline
  end
endfunction

function! visuals#turn_cursorline_off(...)
  call timer_stop(g:tid_cursorline)
  setlocal nocursorline
endfunction

" Description: Print highlighting information at current cursor position.
function! visuals#info_hl()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  echo "highlight name:" synIDattr(synidtrans, "name")
  echo "foreground:" synIDattr(synidtrans, "fg")
  echo "background:" synIDattr(synidtrans, "bg")
endfunction

function visuals#blend_down()
  if (&previewwindow || &buftype=='help')
    if hlexists('BlendDown') == v:true
      setlocal wincolor=BlendDown
    else
      setlocal wincolor=NonText
    endif
  endif
endfunction

