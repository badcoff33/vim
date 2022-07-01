" Vim plugin file

command -nargs=0 InfoHl call visuals#info_hl()
command -nargs=0 HlWord call visuals#hl_word_on()
command -nargs=0 BlinkyOn :call visuals#enable_blinky()
command -nargs=0 BlinkyOff :call visuals#disable_blinky()

noremap <Leader><Leader> <cmd>HlWord<CR>

augroup visuals
  au!
  autocmd WinNew,WinEnter,BufWinEnter * call visuals#blend_down()
  autocmd TextYankPost *  call visuals#blink_on_yank_now(#{duration: 150})
augroup END

BlinkyOn " default to ON
