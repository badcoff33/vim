" Vim autoload file
"
" Description:  Execute a shell commands and cature the output stream in a
" buffer. Uses plugin 'fileset' to operate on a set of files.


" Description: A autoload wrapper function.
" Run a shell command and capture the output in a scratch buffer.
function! shellcommand#Run(cmdLine)

  if !exists("s:outputBuffer")
    let s:outputBuffer = tempname()
  endif

  let winnr = bufwinnr(s:outputBuffer)

  if winnr >= 0
    " Use the already visible buffer of ShellCommand
    execute winnr . "wincmd w"
    setlocal modifiable
    normal ggdG
  elseif bufexists(s:outputBuffer)
    " A ShellCommand buffer exist but it is not visible
    execute "buffer " . s:outputBuffer
    setlocal modifiable
    normal ggdG
  else
    " No ShellCommand buffer
    execute "edit " . s:outputBuffer
    setlocal noswapfile nowrap
  endif

  let cmdRun = ""
  for cmdPart in a:cmdLine
    if filereadable(cmdPart) || isdirectory(cmdPart)
      let cmdRun .= "\"" . escape(cmdPart, '!%#') . "\" "
    else
      let cmdRun .= escape(cmdPart, '!%#') . " "
    endif
  endfor

  silent execute '$read !' . cmdRun
  execute 'normal ggi:!' . cmdRun

  setlocal nomodifiable nomodified
  call s:DetectFileTypeHook()

endfunction

function! shellcommand#ShowBuffer()
    if bufexists(s:outputBuffer)
      execute "buffer " . s:outputBuffer
      wincmd o
    endif
  endfunction

  " Description: Find an appropriate file type based on pattrerns in the first 20
  " lines of code. Supported file types are diff, changelog and gitcommit.
  function! s:DetectFileTypeHook()

    let n = 1 " It does not start from 0.
    while n < 20 " check first 50 lines of the buffer
      let line = getline(n)
      let n = n + 1
      if line =~ '^\(diff\|+++\|---\)\s\+.*$'
      setfiletype diff
      break
    elseif line =~ '^\(revno\|changeset\):\s\+\d\+.*$'
      setfiletype ChangeLog
      break
    elseif line =~ '^:!git\s\+log.*$'
      setfiletype git
      break
    elseif line =~ '^:!git\s\+st.*$'
      setfiletype gitcommit
      break
    endif
  endwhile
  return

endfunction

