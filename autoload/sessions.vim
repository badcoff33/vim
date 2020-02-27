" Vim autoload file

" Global Option: Define what to store in a session. Gets sourced by the very first function
" call to sessions#func.
set sessionoptions=buffers,curdir,tabpages,winsize

function! sessions#Start(newd)
  if !isdirectory(a:newd)
    echoerr "directory" a:newd "does not exist"
    return
  endif
  " close all terminals
  bufdo if &buftype == 'terminal' | bw! | endif
  " Save previous session if one is allready open
  call sessions#CloseSession()
  " Clean up
  try
    noautocmd %bwipeout
  catch /E89/
    ls +
    echomsg "Check your changed buffers. Want to save them?"
    return
  endtry
  if isdirectory(a:newd)
    execute "cd " . a:newd
  endif
  if filereadable(".session")
    while 1
      let answer = tolower(input("load last session [yes|no]? " ,"yes"))
      if answer == "yes"
        source .session
        break
      elseif answer == "no"
        break
      endif
    endwhile
    echo "\n"
  endif
  " find a resource file in curdir or in upper dirs
  let l:workspace_file = findfile(".vimrc", ".;")
  if filereadable(l:workspace_file)
    echomsg "using resource file " . simplify(expand(l:workspace_file, ":p:h"))
    execute "source " . l:workspace_file
  endif
  if !exists("#Spaces")
    echo "Started session tracking in " . getcwd()
    augroup Spaces
      autocmd!
      autocmd ExitPre     *       :mksession! .session
      autocmd DirChanged  global  :call sessions#CloseSession()
    augroup END
  endif
endfunction

function! sessions#CloseSession()
  if exists("#Spaces")
    mksession! .session
    echo "closing session in" getcwd()
    augroup Spaces
      autocmd!
    augroup END
    augroup! Spaces
  endif
endfunction

" vim:sw=2:tw=0:nocindent:foldmethod=marker
