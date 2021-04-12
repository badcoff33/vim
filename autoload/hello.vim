"setbufline({expr}, {lnum}, {text})     *setbufline()*
"in contrust to
"append(...)?

function! hello#SetProps()
  call prop_type_delete('HelloHead')
  call prop_type_add('HelloHead', {'highlight': 'Title'})
  call prop_type_delete('HelloSep')
  call prop_type_add('HelloSep', {'highlight': 'Constant'})
endfunction

" Descrition: Wow! A really dirty function. But it works.
function! hello#SayHello()
  call hello#SetProps()
  let head = []
  call add(head, "            |\\   _,,,---,,_        ")
  call add(head, "    ZZzzz /,`.-'`'    -.  ;-;;,_    ")
  call add(head, "         |,4-  ) )-,_. ,\\ (  `'-'  ")
  call add(head, "        '---''(_/--'  `-'\\_)       ")
" call add(head,'    _----------_')
" call add(head,'     Need help? ')
" call add(head,'    -__________-')
" call add(head,'     \')
" call add(head,'      \   \_\_    _/_/')
" call add(head,'       \      \__/')
" call add(head,'              (oo)\_______')
" call add(head,'              (__)\       )\/\')
" call add(head,'                  ||----w |')
" call add(head,'                  ||     ||')

  let edit_cmds = {}
  let cd_cmds = {}
  let key = char2nr('a')
  let num = char2nr('0')
  let infofile = &viminfofile ? &viminfofile : '~\_viminfo'
  for line in readfile(expand(infofile))
    let m = matchlist(line, '\(^:e\|^:edit\)\s\+\(.\+\)$')
    if !empty(m) && filereadable(fnamemodify(m[2], ':p')) && len(edit_cmds) <= 5
      let edit_cmds[nr2char(key)] = m[0]
      let key += 1
    endif
    let m = matchlist(line, '\(^:cd\)\s\+\(.\+\)$')
    if !empty(m) && isdirectory(fnamemodify(m[2], ':p')) && len(cd_cmds) <= 5
      let cd_cmds[nr2char(num)] = m[0]
      let num += 1
    endif
  endfor

  if bufexists('Hello')
    silent bdelete! Hello
  endif
  enew
  file Hello

  call append(0, head)
  call append(line('$'), '    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  let line_sep3=line('$')
  call append(line('$'), printf('    [q]    quit'))
  call append(line('$'), '    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  let line_sep1=line('$')
  for key in keys(edit_cmds)
    call append(line('$'), printf('    [%s]    %s', key, edit_cmds[key]))
    execute 'nnoremap <buffer>' key edit_cmds[key]..'<CR>'
  endfor
  call append(line('$'), '    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  let line_sep2=line('$')
  for key in keys(cd_cmds)
    call append(line('$'), printf('    [%s]    %s', key, cd_cmds[key]))
    execute 'nnoremap <buffer>' key cd_cmds[key]..'<CR>'
  endfor

  call prop_add(1, 1, {'end_lnum': len(head)+1, 'type': 'HelloHead'})
  call prop_add(line_sep1, 1, {'end_col': 80, 'type': 'HelloSep'})
  call prop_add(line_sep2, 1, {'end_col': 80, 'type': 'HelloSep'})
  call prop_add(line_sep3, 1, {'end_col': 80, 'type': 'HelloSep'})
  setlocal statusline=Hello!
  setlocal buftype=nofile nomodified nomodifiable
  nnoremap <buffer> q :bw<CR>
  nnoremap <buffer> j jzz
  nnoremap <buffer> k kzz
  nnoremap <buffer> <down> jzz
  nnoremap <buffer> <up> kzz

endfunction

