
"setbufline({expr}, {lnum}, {text})     *setbufline()*

noremap <unique> <script> <Plug>SayWelcome <SID>SayWelcome
noremap <SID>SayWelcome :silent call <SID>SayWelcome()<CR>

if !hasmapto('<Plug>SayWelcome')
  nmap <Leader>W <Plug>SayWelcome
endif

" Descrition: Wow! A really dirty function. But it works.
function! s:SayWelcome()
  let head = []
  call add(head,'    _----------_')
  call add(head,'     Need help? ')
  call add(head,'    -__________-')
  call add(head,'     \')
  call add(head,'      \   \_\_    _/_/')
  call add(head,'       \      \__/')
  call add(head,'              (oo)\_______')
  call add(head,'              (__)\       )\/\')
  call add(head,'                  ||----w |')
  call add(head,'                  ||     ||')
  let edit_cmds = {}
  let cd_cmds = {}
  let key = char2nr('a')
  let num = char2nr('0')
  let infofile = &viminfofile ? &viminfofile : '~\_viminfo'
  for line in readfile(expand(infofile))
    let m = matchlist(line, '\(^:cd\)\s\+\(.\+\)$')
    if !empty(m) && isdirectory(m[2])
      echo m[2] isdirectory(m[2])
      let cd_cmds[nr2char(num)] = m[0]
      let num += 1
    endif
    let m = matchlist(line, '\(^:e\|^:edit\)\s\+\(.\+\)$')
    if !empty(m) && filereadable(m[2])
      let edit_cmds[nr2char(key)] = m[0]
      let key += 1
    endif
  endfor

  silent bw! Welcome
  enew
  file Welcome
  let seperator = '    '
  for n in range(winwidth(0)-4)
    let seperator = seperator ..  '-'
  endfor

  call append(0, head)
  call append(line('$'), seperator)
  for key in keys(edit_cmds)
    call append(line('$'), printf('    [%s] -- %s', key, edit_cmds[key]))
    execute 'nnoremap <buffer>' key edit_cmds[key]..'<CR>'
  endfor
  call append(line('$'), seperator)
  for key in keys(cd_cmds)
    call append(line('$'), printf('    [%s] -- %s', key, cd_cmds[key]))
    execute 'nnoremap <buffer>' key cd_cmds[key]..'<CR>'
  endfor

  setlocal statusline=Welcome!
  setlocal nomodified nomodifiable

endfunction