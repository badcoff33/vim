" Vim plugin file

command -nargs=0 ShowHighlighting call visuals#info_hl()
command -nargs=0 HlWordToggle call visuals#hl_word_toggle()

function Blinky(option)
  if a:option == 'off'
    call blinky#disable_blinky()
  elseif a:option == 'flash'
    call blinky#enable_blinky_flash()
  elseif a:option == 'stay'
    call blinky#enable_blinky_stay()
  endif
endfunction

function CompleteBlinky(arg_lead, cmd_line, cur_pos)
  let candidates = filter(['stay', 'flash', 'off'], {idx, val -> val =~ a:arg_lead})
  return candidates
endfunction

command! -nargs=* -complete=customlist,CompleteBlinky Blinky call Blinky(<q-args>)

nnoremap <Leader>h <cmd>HlWordToggle<CR>
