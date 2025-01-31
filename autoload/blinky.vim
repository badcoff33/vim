let g:blinky_winnr_list = []

" Blinky operation mode =0: off, =1: stay, =2: flash
let s:blinky_mode = 0

" Description: Make the actual window more obvious by temporary turn the
" option 'cursorline' on.
function! blinky#enable_blinky_flash()
  call s:turn_cursorline_off()
  augroup GroupBlinky
  autocmd!
  autocmd WinEnter    * call s:turn_cursorline_on()
  autocmd FocusGained * call s:turn_cursorline_on()
  augroup END
  let s:blinky_mode = 2
  call s:turn_cursorline_on()
endfunction

augroup GroupBlinkyBg
  au!
  autocmd WinEnter *  if hlexists("NormalWinHl") | setlocal wincolor=NormalWinHl | endif
  autocmd WinLeave *  setlocal wincolor=
augroup END

" Description: Make the actual window more obvious by temporary turn the
" option 'cursorline' on.
function! blinky#enable_blinky_stay()
  call s:turn_cursorline_off()
  augroup GroupBlinky
    autocmd!
    autocmd WinEnter *    call s:turn_cursorline_on()
    autocmd WinLeave *    call s:turn_cursorline_off()
    autocmd FocusGained * call s:turn_cursorline_on()
  augroup END
  let s:blinky_mode = 1
  call s:turn_cursorline_on()
endfunction

" Description: Stop function and release all resources
function! blinky#disable_blinky()
  setlocal nocursorline
  augroup GroupBlinky
    au! GroupBlinky
  augroup END
  let s:blinky_mode = 0
endfunction

function! s:turn_cursorline_on()
  if &diff
    return
  elseif (&ft == "netrw") || (&bt == "terminal")
    return
  elseif s:blinky_mode == 1
    call setwinvar(winnr(), '&cursorline', v:true)
  elseif s:blinky_mode == 2
    if (&buftype == "") && !empty(bufname("%"))
      if getwinvar(winnr(), '&cursorline') == v:false
        call setwinvar(winnr(), '&cursorline', v:true)
        call add(g:blinky_winnr_list, winnr())
        let tid = timer_start(1000, function("s:turn_cursorline_off"))
      endif
    endif
  endif
endfunction

function! s:turn_cursorline_off(...)
  let timer_id = (a:0 == 1) ? a:1 : 0
  if s:blinky_mode == 1
    call setwinvar(winnr(), '&cursorline', v:false)
  elseif s:blinky_mode == 2
    call timer_stop(timer_id)
    if empty(g:blinky_winnr_list)
      call assert_true(v:false, "unexpected empty list")
      return
    endif
    call setwinvar(g:blinky_winnr_list[0], '&cursorline', v:false)
    let g:blinky_winnr_list = g:blinky_winnr_list[1:]
  endif
endfunction
