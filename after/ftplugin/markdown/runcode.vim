command! -buffer -nargs=0 RunCode call <SID>RunCode()

nnoremap <buffer> <LocalLeader>r :RunCode<CR>

function! s:RunCode()
  let l:save_reg_v = @v
  " found head line of embedded code
  let l:headline = search('^```\s*\w\+.*$', 'cWb') 
  if l:headline == 0
    echomsg "found no Mardown code block or parser"
    return
  endif
  let l:start = l:headline + 1
  let l:matches = matchlist(getline('.'), '^```\s*\(\w\+\)\s*\(.*\)$')
  let l:parser = l:matches[1]
  let l:options = l:matches[2]
  let l:end = search('^```\s*$', 'cW') - 1
  if l:end >= l:start
    let l:codelines = getline(l:start, l:end)
    let l:filename = $TEMP . g:psep . "." . l:parser . ".tmp"
    call writefile(l:codelines, l:filename)
    if match(l:parser, 'vim') >= 0
      redir @v
      execute 'source ' . l:filename
      redir END
      call basic#OpenFloatingWin(@v)
    else
      let l:syscall = l:parser . " " . l:options . " " . l:filename
      let l:output = system(l:syscall)
      call basic#OpenFloatingWin(l:output)
    endif
  endif
  " let @v = l:save_reg_v
endfunction


