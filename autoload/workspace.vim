" Vim autoload file

function! workspace#Switch()

  try
    %bwipeout
  catch /E89/
    ls +
    echomsg "Check your changed buffers. Want to save them?"
    return
  endtry

  let g:workspace_session_file = $TEMP. "/" . sha256(getcwd()) . ".vim"

  let l:workspace_path = "workspace.vim"
  for i in range(4)
    if filereadable(l:workspace_path)
      if i == 0 
        echomsg "found workspace file " . simplify(expand(l:workspace_path, ":p:h"))
      else
        echomsg "found workspace file " . simplify(expand(l:workspace_path, ":p:h"))
      endif
      execute "source " . l:workspace_path
      break
    endif
    let l:workspace_path = "../" . l:workspace_path
  endfor

  echomsg "looking for session " . fnamemodify(g:workspace_session_file, ":t:r")
  if filereadable(g:workspace_session_file)
    while 1
      let answer = tolower(input("load last session [yes|no]? " ,"yes"))
      if answer == "yes"
        execute "source " . g:workspace_session_file
        break
      elseif answer == "no"
        break
      endif
    endwhile
  else
    echomsg "no session file found."
  endif

endfunction

" vim:sw=2:tw=0:nocindent:foldmethod=marker
