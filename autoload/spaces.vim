" Vim autoload file

function! s:StartFileTracking()
  if !exists("#Spaces")
    let g:spaces_wd = getcwd()
    augroup Spaces
      autocmd!
      autocmd BufAdd      * :if g:spaces_wd == getcwd() | mksession! .session | endif
      autocmd BufDelete   * :if g:spaces_wd == getcwd() | mksession! .session | endif
    augroup END
  endif
endfunction

function! spaces#Disable()
  if exists("g:spaces_wd")
    unlet g:spaces_wd
  endif
  if exists("#Spaces")
    augroup Spaces
      autocmd!
    augroup END
    augroup! Spaces
  endif
endfunction

function! spaces#Enable()
  call spaces#Disable()
  if filereadable(".session")
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
  call s:StartFileTracking()
endfunction

" vim:sw=2:tw=0:nocindent:foldmethod=marker
