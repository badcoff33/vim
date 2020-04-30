command! -buffer -nargs=0 RunCode call <SID>RunCode()

nnoremap <buffer> <LocalLeader>r :RunCode<CR>

function! s:RunCode()
  " found head line of embedded code
  let l:headline = search('^```\s*\w\+.*$', 'cWb')
  if &buftype != ""
    echomsg "write to buffer"
    return
  endif
  if l:headline == 0
    echomsg "found no Markdown code block or parser"
    return
  endif
  let l:start = l:headline + 1
  let l:matches = matchlist(getline('.'), '^```\s*\(\w\+\)\s*\(.*\)$')
  let l:parser = l:matches[1]
  let l:options = l:matches[2]
  let l:end = search('^```\s*$', 'cW') - 1
  if l:end >= l:start
    let l:codelines = getline(l:start, l:end)
    call writefile(l:codelines, ".script")
    if match(l:parser, 'vim') >= 0
      redir! > .output
      source .script
      redir END
    else
      let l:syscall = l:parser . " " . l:options . " .script"
      let l:output = system(l:syscall)
      call writefile(split(l:output, '\n'), ".output")
    endif
    call delete(".script")
  endif
endfunction


