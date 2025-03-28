" Vim plugin file

augroup GroupBlinkOnYank
  au!
  autocmd TextYankPost *  call blinkonyank#On(#{duration: 300})
augroup END
