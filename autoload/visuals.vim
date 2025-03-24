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
    echo printf("name=%s  fg=%s  bg=%s",
          \ empty(name) ? "NONE" : name,
          \ empty(fg) ? "NONE" : fg,
          \ empty(bg) ? "NONE" : bg)
  endfor
endfunction
