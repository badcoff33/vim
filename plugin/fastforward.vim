let g:ff_string = ""

function! FF_clear(id)
  unlet g:ff_timer
  let g:ff_string = ""
  let &statusline = g:ff_saved_statusline
endfunction

function! FF_update(msg)
  if g:ff_string == ""
    echon "two keys?"
    let a = getchar()
    if a == 3 || a == 27
      echon
      return
    endif
    let b = getchar()
    if b == 3 || b == 27
      echon
      return
    endif
    let g:ff_string = nr2char(a) .. nr2char(b)
    call search(g:ff_string, "es")
    let g:ff_saved_statusline = &statusline
    execute "set statusline=" .. escape(a:msg, " ") .. '\ with\ %{g:ff_string}'
  endif
  if exists("g:ff_timer")
    call timer_stop(g:ff_timer)
  endif
  let g:ff_timer = timer_start(1500, "FF_clear" )
endfunction

function! FF()
  call FF_update(" >>> fast forward")
  call search(g:ff_string, "es")
endfunction

function! FR()
  call FF_update(" <<< fast rewind")
  call search(g:ff_string, "bes")
endfunction

command! -nargs=0 FF call FF()
command! -nargs=0 FR call FR()
