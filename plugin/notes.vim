
execute mkdir(expand("~/.notes"), "p")
nnoremap <Leader>n <Cmd>call NotesToday()<CR>

let g:notes_files = []

function! NotesToday()
    execute "drop" strftime("~/.notes/note-%d-%m-%y.txt")
    setfiletype markdown
    nnoremap <buffer> <LocalLeader>B <Cmd>call NotesBacklog(+1)<CR>
    nnoremap <buffer> <LocalLeader>F <Cmd>call NotesBacklog(-1)<CR>
    let g:notes_file_idx = 0
endfunction

function! NotesUpdateBacklog(days)
    let one_day = 86400
    let now = localtime()
    let files = []
    for day in range(0, -a:days, -1)
        let file_candidate = strftime("~/.notes/note-%d-%m-%y.txt", (now - now % one_day) + ( day * one_day ) )
        if filereadable(expand(file_candidate))
            call add(files, expand(file_candidate))
        endif
    endfor
    return files
endfunction

function! NotesBacklog(dir)
    let one_day = 86400
    let now = localtime()
    let display = ["Select a note from the past:"]
    let g:notes_files = NotesUpdateBacklog(60)
    let last_idx = len(g:notes_files) - 1

    let g:notes_file_idx += a:dir
    if g:notes_file_idx <= 0
        let g:notes_file_idx = 0
    elseif g:notes_file_idx >= last_idx
        let g:notes_file_idx = last_idx
    endif
    echo g:notes_file_idx
    try
        execute "drop" g:notes_files[g:notes_file_idx]
        nnoremap <buffer> <LocalLeader>B <Cmd>call NotesBacklog(+1)<CR>
        nnoremap <buffer> <LocalLeader>F <Cmd>call NotesBacklog(-1)<CR>
        setfiletype markdown
    catch /.*/
    endtry
endfunction

