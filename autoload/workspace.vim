" Vim autoload file

augroup WorkspaceSession
  autocmd!
  autocmd VimLeavePre * call SaveWorkspaceSession()
  autocmd DirChanged global call SaveWorkspaceSession()
augroup END

" vim:sw=2:tw=0:nocindent
function! RemoveWorkspaceSession()
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

function! EditWorkspaceSourceFile()
  if exists("g:workspace_source_file")
    execute "edit " . g:workspace_source_file
  endif
endfunction

command! -nargs=0 SaveWorkspace    call SaveWorkspaceSession()
command! -nargs=0 EditWorkspace    call EditWorkspaceSourceFile()
command! -nargs=0 RemoveWorkspace  call RemoveWorkspaceSession()
command! -nargs=0 SwitchWorkspace  call workspace#Switch()

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

  let l:workspace_path = findfile(".vimrc", ".;")
  if filereadable(l:workspace_path)
    echomsg "found workspace file " . simplify(expand(l:workspace_path, ":p:h"))
    execute "source " . l:workspace_path
    let g:workspace_source_file = expand(l:workspace_path, ":p")
  endif

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

" Description: My workspace splash screen
function! workspace#OpenListFile()
  let g:workspace_list_file = get(g:, "workspace_list_file", "~/workspaces.txt")
  execute 'edit ' . g:workspace_list_file
  nmap <buffer> <CR> :cd <C-r><C-f><CR>:SwitchWorkspace<CR>
endfunction

" vim:sw=2:tw=0:nocindent:foldmethod=marker
