function! Markdown#ToggleTodo()
  if search('\[[ Xx]\]','b') > 0
    if strcharpart(getline('.')[col('.'):], 0, 1) == ' '
      normal lrX
    else
      exe "normal lr "
    endif
  endif
endfunction

