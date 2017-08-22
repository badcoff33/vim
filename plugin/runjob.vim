
if !has('job') || !has('channel') || !has('quickfix')
  finish
endif

function! s:JobHandler(handler)

  let l:cbufnr = bufnr("make.io")
  if l:cbufnr < 0
    echoerr "make.io does not exist."
    return
  endif
  execute "cbuffer " . l:cbufnr
  echomsg "closed " . a:handler

endfunction

function! RunMake(commandString)

  let l:opts = {
        \ 'close_cb':       function('s:JobHandler'),
        \ 'out_io':         'buffer',
        \ 'out_name':       "make.io",
        \ 'out_modifiable': 0,
        \ 'out_msg':        0,
        \ 'err_io':         'buffer',
        \ 'err_name':       "make.io",
        \ 'err_modifiable': 0,
        \ 'in_io':          'null'
        \ }

  if bufnr("make.io") >= 0
    bwipeout make.io
  endif

  let g:job = job_start("cmd /C " . a:commandString, l:opts)

endfunction

command! -nargs=+  MakeJob :call RunMake(<q-args>)


" function! s:CreateMakeJobWindow(name)
"
"   let l:bufnr = bufnr(a:name)
"   if l:bufnr < 0
"     " Need to create the job buffer
"     silent execute 'belowright 10split ' . a:name
"     setlocal bufhidden=hide buftype=nofile nobuflisted nolist
"     setlocal noswapfile nowrap nomodifiable
"     let l:bufnr = winbufnr(0)
"   endif
"
"   let l:winnr = bufwinnr(l:bufnr)
"   if l:winnr > 0
"     " Focus on already visible buffer
"     execute l:winnr . "wincmd w"
"   else
"     " Bring buffer to focus
"     execute "buffer " . l:bufnr
"   endif
"
"   " clear the old buffer content
"   setlocal modifiable
"   normal ggVG"_x
"   setlocal nomodified nomodifiable
"
" endfunction

