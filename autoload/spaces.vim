" Vim autoload file

function! spaces#Enable()
  if !exists("#Spaces")
    call s:Change()
    augroup Spaces
      autocmd!
      autocmd DirChanged  * :call s:Change()
      autocmd BufAdd      * :mksession! .session
      autocmd BufDelete   * :mksession! .session
      autocmd VimLeavePre * :mksession! .session
    augroup END
  endif
endfunction

function! spaces#Disable()
  if exists("#Spaces")
    augroup Spaces
      autocmd!
    augroup END
    augroup! Spaces
  endif
endfunction

function! s:Change()
  " Clean up
  try
    %bwipeout
  catch /E89/
    ls +
    echomsg "Check your changed buffers. Want to save them?"
    return
  endtry
  " find a resource file in curdir or in upper dirs
  let l:workspace_file = findfile(".vimrc", ".;")
  if filereadable(l:workspace_file)
    echomsg "found workspace file " . simplify(expand(l:workspace_file, ":p:h"))
    execute "source " . l:workspace_file
    let g:workspace_source_file = expand(l:workspace_file, ":p")
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
endfunction

" vim:sw=2:tw=0:nocindent:foldmethod=marker
