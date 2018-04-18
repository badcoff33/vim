" Vim autoload file

augroup WorkspaceSession
  autocmd!
  autocmd VimLeavePre * call SaveWorkspaceSession()
augroup END

function! ClearWorkspaceSession()
  if exists("g:workspace_session_file")
    execute "silent !del " . g:workspace_session_file
  endif
endfunction

function! SaveWorkspaceSession()
  if exists("g:workspace_session_file")
    let l:save_sessionoptions = &sessionoptions
    set sessionoptions-=curdir
    execute "mksession! " . g:workspace_session_file
    let &sessionoptions = l:save_sessionoptions
  endif
endfunction

function! EditWorkspaceSession()
  if exists("g:workspace_session_file")
    execute "edit " . g:workspace_session_file
  endif
endfunction

command! -nargs=0 SaveWorkspaceSession call SaveWorkspaceSession()
command! -nargs=0 EditWorkspaceSession call EditWorkspaceSession()
command! -nargs=0 ClearWorkspaceSession call ClearWorkspaceSession()

function! workspace#Switch()
  
  " save the session you want to leave
  call SaveWorkspaceSession()

  " Clean up 
  try
    %bwipeout
  catch /E89/
    ls +
    echomsg "Check your changed buffers. Want to save them?"
    return
  endtry

  let g:workspace_session_file = expand($TEMP . "/" . sha256(getcwd()) . ".vim", "%")

  let l:workspace_path = "workspace.vim"
  for i in range(4)
    if filereadable(l:workspace_path)
      echomsg "found workspace file " . simplify(expand(l:workspace_path, ":p:h"))
      execute "source " . l:workspace_path
      break
    endif
    let l:workspace_path = "../" . l:workspace_path
  endfor

  echomsg "looking for session file"
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
