" Vim autoload file

" Global Option: Define what to store in a session. Gets sourced by the very first function
" call to spaces#func.
set sessionoptions=buffers,curdir,localoptions,globals,tabpages,winsize

function! spaces#Start(newd)
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
  endif
  " find a resource file in curdir or in upper dirs
  let l:workspace_file = findfile(".vimrc", ".;")
  if filereadable(l:workspace_file)
    echomsg "found workspace file " . simplify(expand(l:workspace_file, ":p:h"))
    execute "source " . l:workspace_file
    let g:workspace_source_file = expand(l:workspace_file, ":p")
  endif
  call s:StartFileTracking()
endfunction

function! s:StartFileTracking()
  if !exists("#Spaces")
    let g:spaces_wd = getcwd()
    echo "Started session tracking in " . g:spaces_wd
    augroup Spaces
      autocmd!
      autocmd BufAdd      * :call spaces#UpdateSession()
      autocmd BufDelete   * :call spaces#UpdateSession()
    augroup END
  endif
endfunction

function! spaces#UpdateSession()
  if g:spaces_wd == getcwd()
    mksession! .session
  else
    echo "closing session in " . g:spaces_wd
    let g:spaces_wd = ""
    if exists("#Spaces")
      augroup Spaces
        autocmd!
      augroup END
      augroup! Spaces
    endif
  endif
endfunction

" vim:sw=2:tw=0:nocindent:foldmethod=marker
