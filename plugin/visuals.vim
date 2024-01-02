" Vim plugin file

command -nargs=0 ShowHighlighting call visuals#info_hl()
command -nargs=0 HlWordToggle call visuals#hl_word_toggle()
command -nargs=0 BlinkyOn :call visuals#enable_blinky("blink")
command -nargs=0 BlinkyStick :call visuals#enable_blinky("stick")
command -nargs=0 BlinkyOff :call visuals#disable_blinky()

nnoremap <Leader>h <cmd>HlWordToggle<CR>

augroup visuals
  au!
  autocmd TextYankPost *  call visuals#blink_on_yank_now(#{duration: 300})
augroup END
