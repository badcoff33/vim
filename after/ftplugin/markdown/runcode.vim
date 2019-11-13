command! -buffer -nargs=0 RunCode call <SID>RunCode()

nnoremap <buffer> <LocalLeader>r :RunCode<CR>

function! s:RunCode()
  let l:psep = '/'
  if exists('+shellslash')
    if &shellslash
      let l:psep = '/'
    else
      let l:psep = '\'
    endif
  endif
  " found head line of embedded code
  let l:headline = search('^```\s\+\w\+.*$', 'cWb') 
  if l:headline == 0
    echomsg "found no code in Mardown file"
    return
  endif
  let l:start = l:headline + 1
  let l:matches = matchlist(getline('.'), '^```\s\+\(\w\+\)\s*\(.*\)$')
  let l:parser = l:matches[1]
  let l:options = l:matches[2]
  let l:end = search('^```\s*$', 'cW') - 1
  if l:end > l:start
    let l:codelines = getline(l:start, l:end)
    let l:filename = getcwd() . l:psep . "." . l:parser . ".tmp"
    call writefile(l:codelines, l:filename)
    let l:syscall = l:parser . " " . l:options . " " . l:filename
    echomsg l:syscall
    let l:output = system(l:syscall)
    call OpenFloatingWin( l:output)
  endif
endfunction

function! OpenFloatingWin(text)
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  "Set the position, size, etc. of the floating window.
  "The size configuration here may not be so flexible, and there's room for further improvement.
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + 30,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  "Set Floating Window Highlighting
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
  put =printf('%s', a:text)
  autocmd BufLeave <buffer> bwipeout!
endfunction
