
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
  if (&previewwindow || &bt=='help' || &ft == 'netrw' || &ft == 'qf')
    setlocal wincolor=NonText
  endif
endfunction

function! visuals#blink_on_yank_now()
  let ml = getmarklist("%")
  for e in ml
    if e["mark"] == "'["
      let lead_pos = e["pos"]
    endif
    if e["mark"] == "']"
      let trail_pos = e["pos"]
    endif
  endfor
  call prop_type_delete('TP_Visual')
  call prop_type_add('TP_Visual', #{ highlight: 'Visual' })
  if trail_pos[2] == -2147483648
    let sp = len(getline(trail_pos[1]))
  else
    let sp = trail_pos[2]
  endif
  call prop_add_list(#{bufnr: bufnr("%"), id: 1, type: 'TP_Visual'}, [[lead_pos[1], lead_pos[2], trail_pos[1], sp + 1]])
  call timer_start(200, "BlinkOffYank", {'repeat': 1})
endfunction

function! visuals#blink_on_yank_off(tid)
  call prop_clear(1, line("$"))
  call prop_type_delete('TP_Visual')
endfunction
