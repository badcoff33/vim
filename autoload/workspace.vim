" Vim autoload file

function! workspace#Switch()

  %bwipeout
  let g:workspace_session_file = $TEMP. "/" . sha256(getcwd()) . ".vim"

  if filereadable("../workspace.vim")
    " Source the top (project-family-like) workspace file
    source ../workspace.vim
  endif
  
  if filereadable("workspace.vim")
    " Source the local workspace file. Options set by top workspace file 
    " can be overwritten.
    source workspace.vim
  endif

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
