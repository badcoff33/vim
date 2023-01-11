
function! visuals#hl_word_toggle()
  highlight HlWordUnderline gui=underline
  if !exists("g:hl_word_timer")
      let g:hl_word_timer = timer_start(1000, function("visuals#hl_word_cyclic"), #{repeat: -1})
      let s:save_hlsearch = &hlsearch
      set nohlsearch
  else
      let save_winid = winnr()
      noautocmd windo match none
      call timer_stop(g:hl_word_timer)
      unlet g:hl_word_timer
      execute save_winid "wincmd w"
      if s:save_hlsearch
          set hlsearch
      endif
  endif
endfunction

function! visuals#hl_word_cyclic(tid)
    let cword = expand("<cword>")
    if matchstr(cword, "[a-zA-Z0-9_]") != ""
        execute "match HlWordUnderline /\\<" .. cword .. "\\>/"
    else
        match none
    endif
endfunction

" Description: Make the actual window more obvious by temporary turn the
" option 'cursorline' on.
function! visuals#enable_blinky()
    let g:tid_cursorline = -1
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
    if (&diff == 0) && (&buftype == "") && !empty(bufname("%"))
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
    if ((&previewwindow) || (&bt=='help') || (&ft == 'netrw'))
        set wincolor=CursorLine
    else
        set wincolor=
    endif
endfunction

" avoid error 2nd from prop_type_add by delete it first
call prop_type_delete('text_prop_yank')
call prop_type_add('text_prop_yank', #{ highlight: 'Visual' })

    function! visuals#blink_on_yank_now(dict)
let duration = (type(a:dict) == v:t_dict) && (has_key(a:dict, "duration")) ? a:dict["duration"] : 1000
let a = getpos("'[")
let b = getpos("']")
if v:event['visual'] == v:true
    return
endif
if v:event['operator'] == 'y'
    " we want this only for yank operations
    if b[2] == 0x7fffffff
        let sp = len(getline(b[1]))
    else
        let sp = b[2]
    endif
    call prop_add_list(#{bufnr: bufnr("%"), id: 1, type: 'text_prop_yank'}, [[a[1], a[2], b[1], sp + 1]])
    call timer_start(duration, "visuals#blink_on_yank_off", {'repeat': 1})
endif
    endfunction

    function! visuals#blink_on_yank_off(tid)
        call prop_clear(1, line("$"))
    endfunction
