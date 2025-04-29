let g:notes_files = []
let g:notes_file_idx = 0
let g:notes_diary_file = get(g:, 'notes_diary_file', expand("~/diary"))
let g:notes_home_dir = get(g:, 'notes_home_dir', expand("~/.text"))

function! s:NotesBufferSettings()
  setfiletype markdown
  nnoremap <buffer> <LocalLeader>f <Cmd>call NotesBacklog("fw")<CR>
  nnoremap <buffer> <LocalLeader>b <Cmd>call NotesBacklog("bw")<CR>
endfunction

function! NotesToDo(...)
  if !exists("g:notes_todo_file")
    execute "drop" g:notes_home_dir .. "/todo.txt"
  else
    execute "drop" g:notes_todo_file
  endif
endfunction

function! NotesToday(...)
  execute "drop" strftime(g:notes_home_dir .. "/note-%Y-%m-%d.txt")
  call s:NotesBufferSettings()
  let g:notes_files = NotesUpdateBacklog(60)
endfunction

function! NotesUpdateBacklog(days)
  let one_day = 86400
  let now = localtime()
  let files = []
  let g:notes_file_idx = 0
  for day in range(0, -a:days, -1)
    let file_candidate = expand(strftime(g:notes_home_dir .. "/note-%Y-%m-%d.txt", (now - now % one_day) + (day * one_day )))
    if bufexists(file_candidate)
      call add(files, file_candidate)
    elseif filereadable(file_candidate)
      call add(files, file_candidate)
    endif
  endfor
  return files
endfunction

function! NotesBacklog(direction)
  let one_day = 86400
  let now = localtime()
  let g:notes_files = NotesUpdateBacklog(60)
  if g:notes_files == []
    echohl WarningMsg
    echomsg "-- empty --"
    echohl None
    return
  endif
  let last_idx = len(g:notes_files) - 1

  let g:notes_file_idx += (a:direction == "fw") ? 1 : -1
  if g:notes_file_idx <= 0
    echohl WarningMsg
    echomsg "-- first --"
    echohl None
    let g:notes_file_idx = 0
  elseif g:notes_file_idx >= last_idx
    echohl WarningMsg
    echomsg "-- last --"
    echohl None
    let g:notes_file_idx = last_idx
  endif
  if bufexists(g:notes_files[g:notes_file_idx])
    execute "buffer" fnameescape(g:notes_files[g:notes_file_idx])
  else
    execute "drop" fnameescape(g:notes_files[g:notes_file_idx])
  endif
  call s:NotesBufferSettings()
endfunction

function! GetHeadlines(files)
  let g:popup_file_list = []
  let headlines = []
  for f in a:files
    for l in readfile(f, "", 10)
      if matchstr(l, '^#*\s*[A-Za-z]\+') > ""
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
  let current_files = globpath(g:notes_home_dir, "*.txt", v:false, v:true)
  let headlines = GetHeadlines(reverse(sort(current_files)))
  call popup_menu(reverse(sort(headlines)), #{
        \ callback: 'NotesSelected',
        \ borderchars: [' ']
        \ })
endfunction

function! NotesFind(string)
  silent execute 'vimgrep' a:string g:notes_home_dir .. '/*.txt'
endfunction

function! NotesDiary(...)
  execute $"drop {g:notes_diary_file}"
  normal Go
  " https://docs.oracle.com/cd/E23389_01/doc.11116/e21038/timeformat.htm
  call setline("$", strftime("%b %e, %Y") .. " ")
endfunction

function! NotesCmdDispatch(params)
  let [cmd; rest] = split(a:params, " ")
  let g:notes_cmd_to_func = #{
        \ todo: funcref('NotesToDo'),
        \ list: funcref('NotesList'),
        \ today: funcref('NotesToday'),
        \ find: funcref('NotesFind'),
        \ diary: funcref('NotesDiary')
        \ }
  call g:notes_cmd_to_func[cmd](join(rest, " "))
endfunction

command! -complete=customlist,CustomCompleteNotes -nargs=1 Notes call NotesCmdDispatch(<q-args>)
function! CustomCompleteNotes(ArgLead, CmdLine, CursorPos)
  return filter(['todo', 'today', 'list', 'find'], {idx, val -> val =~? a:ArgLead})
endfunction
