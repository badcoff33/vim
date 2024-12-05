function! visuals#hl_word_toggle()
  highlight HlWordUnderline gui=underline
  if !exists("g:hl_word_timer")
    let g:hl_word_timer = timer_start(1000, function("visuals#hl_word_cyclic"), #{repeat: -1})
      let s:save_hlsearch = &hlsearch
    set nohlsearch
  else
    let save_winid = win_getid()
    for w in getwininfo()
      call clearmatches(w.winid)
    endfor
    call win_gotoid(save_winid)
    call timer_stop(g:hl_word_timer)
    unlet g:hl_word_timer
    let &hlsearch = s:save_hlsearch
  endif
endfunction

function! visuals#hl_word_cyclic(tid)
  let cword = expand("<cword>")
  if mode() == "v"
    call clearmatches()
  elseif matchstr(cword, "[a-zA-Z0-9_]") != ""
    call clearmatches()
    let w:match_id = matchadd( "HlWordUnderline",  "\\<" .. cword .. "\\>")
  else
    call clearmatches()
  endif
endfunction

" Description: Print highlighting information at current cursor position.
function! visuals#info_hl()
  for syn_id in synstack(line("."), col("."))
    let syn_id_trans = synIDtrans(syn_id)
    let name = synIDattr(syn_id_trans, "name")
    let fg = synIDattr(syn_id_trans, "fg")
    let bg = synIDattr(syn_id_trans, "bg")
    echo printf("name: %s\nforeground: %s\nbackground: %s",
          \ empty(name) ? "NONE" : name,
          \ empty(fg) ? "NONE" : fg,
          \ empty(bg) ? "NONE" : bg)
  endfor
endfunction

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
    let s:save_hlsearch = &hlsearch
    let s:save_cursorline = &cursorline
    set nohlsearch
    setlocal nocursorline
    call prop_add_list(#{bufnr: bufnr("%"), id: 1, type: 'text_prop_yank'}, [[a[1], a[2], b[1], sp + 1]])
    call timer_start(duration, "visuals#blink_on_yank_off", {'repeat': 1})
  endif
endfunction

function! visuals#blink_on_yank_off(tid)
  let &hlsearch = s:save_hlsearch
  let &cursorline = s:save_cursorline
  call prop_clear(1, line("$"))
endfunction

" avoid error 2nd from prop_type_add by delete it first
call prop_type_delete('text_prop_yank')
call prop_type_add('text_prop_yank', #{ highlight: 'Visual' })
