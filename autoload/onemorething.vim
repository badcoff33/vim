" Vim autoload file
"
" Description: This file implements a simple method to drop notes on open jobs
" at cursor position, like a comment on  a certain source code line, waiting
" for a bug fix. 

if !exists("g:one_more_thing_file")
  let g:one_more_thing_file = '~/Documents/omt.md'
endif

" Description: Pop the OneMortThing file to front.
function! onemorething#ShowFile()
  if filereadable(expand(g:one_more_thing_file, ":p:h"))
    execute "edit " . g:one_more_thing_file 
  else
    echomsg "No OneMoreThing?"
  endif
endfunction

" Description: Enter one-more-thing and store the text with file and line info
" in a file. This file/line info can be opend with a 'gF' command.
function! onemorething#NewEntry()
  let l:reference = printf('"%s" %d', bufname("%"), line("."))
  let l:comment = input(
        \ printf("Comment on\n  file %s\n  line %d\n==> ", bufname("%"), line(".")), 
        \ "", 
        \ "tag")
  if !filereadable(expand(g:one_more_thing_file, ":p:h"))
    enew
    put='# One More Thing'
    put=''
    put='------------------------------------------------------------------------------'
    put='  vim:ft=markdown'
    execute 'w! ' . g:one_more_thing_file
  endif
  if !bufexists(g:one_more_thing_file)
    execute "edit " . g:one_more_thing_file
  else
    execute "buffer " . g:one_more_thing_file
  endif
  normal gg
  if search('^#\+\s\+One More Thing', 'eW') == 0
    echohl ErrorMsg
    echo "missing chapter '# One More Thing' in file" g:one_more_thing_file
    echohl None
    return
  endif
  let l:level = len(split(getline("."), " ")[0])
  if search('^#\{' . l:level . '\}\s\+', 'eW') > 0
    normal {
  else
    normal G{
  endif
  let l:head = ''
  for i in range(0, l:level)
    let l:head = l:head . '#'
  endfor
  put=printf(l:head . ' %s', l:comment)
  put=printf('    %s', l:reference)
  put=''
  write
endfunction



