command! -buffer -nargs=0 RunCode call <SID>RunCode()

nnoremap <buffer> <LocalLeader>r :RunCode<CR>

function! s:RunCode()
  " found head line of embedded code
  let l:headline = search('^```\s\+\(\w\+\)\s*$', 'cWb') 
  if l:headline == 0
    echomsg "found no code in Mardown file"
    return
  endif
  let l:start = l:headline + 1
  let l:matches = matchlist(getline('.'), '^```\s\+\(\w\+\)\s*$')
  let l:parser = l:matches[1]
  let l:end = search('^```\s*$', 'cW') - 1
  if l:end > l:start
    let l:codelines = getline(l:start, l:end)
    let l:filename = tempname()
    call writefile(l:codelines, l:filename)
    let l:syscall = l:parser . " " . l:filename
    let l:output = system(l:syscall)
    echo l:output
  endif
endfunction
