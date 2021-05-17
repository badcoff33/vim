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
  call add(head, "                                    ")
  call add(head, "            |\\   _,,,---,,_        ")
  call add(head, "    ZZzzz /,`.-'`'    -.  ;-;;,_    ")
  call add(head, "         |,4-  ) )-,_. ,\\ (  `'-'  ")
  call add(head, "        '---''(_/--'  `-'\\_)       ")

  let edit_cmds = []
  let num_of_edit_cmds = 0
  let cd_cmds = []
  let num_of_cd_cmds = 0

  let cmd_entries = histnr('cmd')
  for hist_num in range(1, cmd_entries)
    let cmd_line = histget('cmd', -hist_num)
    let m = matchlist(cmd_line, '\(^e\|^:edit\)\s\+\(.\+\)$')
    if !empty(m) && filereadable(fnamemodify(m[2], ':p')) && num_of_edit_cmds <= 5
      call add(edit_cmds, m[0])
      let num_of_edit_cmds += 1
    endif
    let m = matchlist(cmd_line, '\(^cd\)\s\+\(.\+\)$')
    if !empty(m) && isdirectory(fnamemodify(m[2], ':p')) && len(cd_cmds) <= 5
      call add(cd_cmds, m[0])
      let num_of_cd_cmds += 1
    endif
  endfor

  let std_cmds = [
        \ 'e ~\vimfiles\site.vim',
        \ 'e ~\vimfiles\vimrc']

  enew
  setlocal modifiable cursorline
  autocmd BufLeave <buffer> bwipe

  call append(0, head)
  call append(line('$'), '    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  let line_sep3=line('$')
  for l in std_cmds
    call append(line('$'), printf('    %s', l))
  endfor
  call append(line('$'), '    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  let line_sep1=line('$')
  for l in edit_cmds
    call append(line('$'), printf('    %s', l))
  endfor
  call append(line('$'), '    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  let line_sep2=line('$')
  for l in cd_cmds
    call append(line('$'), printf('    %s', l))
  endfor

  call prop_add(1, 1, {'end_lnum': len(head)+1, 'type': 'HelloHead'})
  call prop_add(line_sep1, 1, {'end_col': 80, 'type': 'HelloSep'})
  call prop_add(line_sep2, 1, {'end_col': 80, 'type': 'HelloSep'})
  call prop_add(line_sep3, 1, {'end_col': 80, 'type': 'HelloSep'})
  setlocal statusline=Hello!
  setlocal buftype=nofile nomodified nomodifiable
  nnoremap <buffer> q :bw<CR>
  nnoremap <buffer> j j_
  nnoremap <buffer> k k_
  nnoremap <buffer> <down> j_
  nnoremap <buffer> <up> k_
  nnoremap <buffer> <CR> 0"hy$:<C-r>h<CR>_
  execute 'normal' line_sep1 .. 'G'

endfunction

