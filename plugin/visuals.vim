" Vim plugin file

noremap <SID>HighlightWord :call visuals#hl_word_on()<CR>

if !hasmapto('<Plug>HighlightWord')
  nmap <Leader><Leader> <Plug>HighlightWord
endif

command -nargs=0 InfoHl call visuals#info_hl()

autocmd BufEnter * call visuals#blend_down()

command -nargs=0 Blinky :call visuals#toggle_blinky()
Blinky " default to ON
