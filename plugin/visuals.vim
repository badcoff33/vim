" Vim plugin file

command -nargs=0 InfoHl call visuals#info_hl()
command -nargs=0 HlWord call visuals#hl_word_on()
command -nargs=0 BlinkyOn :call visuals#enable_blinky()
command -nargs=0 BlinkyOff :call visuals#disable_blinky()

augroup visuals
  au!
  autocmd WinNew * call visuals#blend_down()
augroup END

noremap <Leader><Leader> <cmd>HlWord<CR>

autocmd! TextYankPost
autocmd TextYankPost *  call visuals#blink_on_yank_now()

BlinkyOn " default to ON
