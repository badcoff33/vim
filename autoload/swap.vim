
function! swap#OtherFileC()
  let extension = expand("%:e")
  let other_file = ""
  if extension == "c"
    let other_file = expand("%:r")..".h"
  elseif extension == "h"
    let other_file = expand("%:r")..".c"
  endif
  if filereadable(other_file)
    execute "edit" other_file
  else
    echo other_file "didn't exist"
  endif
endfunction

