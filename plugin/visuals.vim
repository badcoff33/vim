" Vim plugin file

command! -nargs=0 HlWord call visuals#hl_word_on()
noremap <Leader><Leader> <cmd>HlWord<CR>
autocmd BufEnter * call visuals#blend_down()

command -nargs=0 InfoHl call visuals#info_hl()

command -nargs=0 BlinkyOn :call visuals#enable_blinky()
command -nargs=0 BlinkyOff :call visuals#disable_blinky()
BlinkyOn " default to ON
