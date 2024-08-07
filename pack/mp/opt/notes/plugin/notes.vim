let g:notes_files = []
let g:notes_home = get(g:, 'notes_home', expand("~/.text"))

function! s:NotesBufferSettings()
  setfiletype markdown
  nnoremap <buffer> <LocalLeader>+ <Cmd>call NotesBacklog(+1)<CR>
  nnoremap <buffer> <LocalLeader>- <Cmd>call NotesBacklog(-1)<CR>
endfunction

function! NotesToday(...)
  execute "drop" strftime(g:notes_home .. "/note-%Y-%m-%d.md")
  call s:NotesBufferSettings()
  let g:notes_files = NotesUpdateBacklog(60)
  let g:notes_file_idx = 0
endfunction

function! NotesUpdateBacklog(days)
  let one_day = 86400
  let now = localtime()
  let files = []
  for day in range(0, -a:days, -1)
    let file_candidate = expand(strftime(g:notes_home .. "/note-%Y-%m-%d.md", (now - now % one_day) + (day * one_day )))
    if bufexists(file_candidate)
      call add(files, file_candidate)
    elseif filereadable(file_candidate)
      call add(files, file_candidate)
    endif
  endfor
  return files
endfunction

function! NotesBacklog(dir)
  let one_day = 86400
  let now = localtime()
  let g:notes_files = NotesUpdateBacklog(60)
  let last_idx = len(g:notes_files) - 1

  let g:notes_file_idx += a:dir
  if g:notes_file_idx <= 0
    echohl WarningMsg
    echomsg "-- today --"
    echohl None
    let g:notes_file_idx = 0
  elseif g:notes_file_idx >= last_idx
    echohl WarningMsg
    echomsg "-- last --"
    echohl None
    let g:notes_file_idx = last_idx
  endif
    if bufexists(g:notes_files[g:notes_file_idx])
      execute "buffer" g:notes_files[g:notes_file_idx]
    else
      execute "drop" g:notes_files[g:notes_file_idx]
    endif
    call s:NotesBufferSettings()
endfunction

function! GetHeadlines(files)
  let g:popup_file_list = []
  let headlines = []
  for f in a:files
    for l in readfile(f, "", 10)
      if matchstr(l, '[#A-Za-z]\+') > ""
        call add(headlines, fnamemodify(f, ":t") .. "|" .. l)
        call add(g:popup_file_list, f)
        break
      endif
    endfor
  endfor
  return headlines
endfunction

function! NotesSelected(id, result)
  if a:result >= 1
    execute "drop" fnameescape(g:popup_file_list[a:result - 1])
  endif
endfunction

function! NotesList(...)
  let current_files = globpath(g:notes_home, "*.md", v:false, v:true)
  let headlines = GetHeadlines(reverse(sort(current_files)))
  call popup_menu(reverse(sort(headlines)), #{
        \ callback: 'NotesSelected',
        \ borderchars: [' ']
        \ })
endfunction

function! NotesFind(string)
  execute 'vimgrep' a:string g:notes_home .. '/*.md'
endfunction

function! NotesCmdDispatch(params)
  let cmd = split(a:params, ' ')[0]
  let rest = join(split(a:params, ' ')[1:], ' ')
  let g:notes_cmd_to_func = #{
        \ list: funcref('NotesList'),
        \ today: funcref('NotesToday'),
        \ find: funcref('NotesFind')
        \ }
  echo '#'..rest..'#'
  call g:notes_cmd_to_func[cmd](rest)
endfunction

command! -complete=customlist,CustomCompleteNotes -nargs=1 Notes call NotesCmdDispatch(<q-args>)
function! CustomCompleteNotes(ArgLead, CmdLine, CursorPos)
  return filter(['today', 'list', 'find'], {idx, val -> val =~? a:ArgLead})
endfunction

