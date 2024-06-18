" Vim plugin file

command -nargs=0 ShowHighlighting call visuals#info_hl()
command -nargs=0 HlWordToggle call visuals#hl_word_toggle()

function Blinky(option)
  if a:option == 'off'
    call visuals#disable_blinky()
  elseif a:option == 'flash'
    call visuals#enable_blinky_flash()
  elseif a:option == 'stay'
    call visuals#enable_blinky_stay()
  endif
endfunction

function CompleteBlinky(arg_lead, cmd_line, cur_pos)
  return ['stay', 'flash', 'off']
endfunction
command! -nargs=* -complete=customlist,CompleteBlinky Blinky call Blinky(<q-args>)

nnoremap <Leader>h <cmd>HlWordToggle<CR>

augroup visuals
  au!
  autocmd TextYankPost *  call visuals#blink_on_yank_now(#{duration: 300})
augroup END
