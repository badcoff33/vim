let g:ff_string = ""
let g:ff_active_time = 1700

highlight FFWordUnderline gui=underline

function! FF_clear(id)
  match none
  let g:ff_string = ""
endfunction

function! FF_getchar()
    let a = getchar()
    if a == 3 || a == 27
      echon " aborted"
      return -1
    endif
    return a
endfunction

function! FF_update()
  if g:ff_string == ""
    echon "??"
    let a = FF_getchar()
    if a < 0
      return
    endif
    let b = FF_getchar()
    if b < 0
      return
    endif
    let g:ff_string = nr2char(a) .. nr2char(b)
    echon " "..g:ff_string
    call search(g:ff_string, "es")
  endif
  if exists("g:ff_timer")
    call timer_stop(g:ff_timer)
  endif
  execute "match FFWordUnderline /" .. g:ff_string.. "/"
  let g:ff_timer = timer_start(g:ff_active_time, "FF_clear" )
endfunction

function! FF()
  call FF_update()
  call search(g:ff_string, "es")
endfunction

function! FR()
  call FF_update()
  call search(g:ff_string, "bes")
endfunction

command! -nargs=0 FF call FF()
command! -nargs=0 FR call FR()
