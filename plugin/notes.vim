
let g:notes_files = []

function s:NotesBufferSettings()
    setfiletype markdown
    nnoremap <buffer> <A-PageDown> <Cmd>call NotesBacklog(+1)<CR>
    nnoremap <buffer> <A-PageUp>   <Cmd>call NotesBacklog(-1)<CR>
endfunction

function! NotesToday()
    execute "drop" strftime("~/.notes/note-%d-%m-%y.md")
    call s:NotesBufferSettings()
    let g:notes_files = NotesUpdateBacklog(60)
    let g:notes_file_idx = 0
endfunction

function! NotesUpdateBacklog(days)
    let one_day = 86400
    let now = localtime()
    let files = []
    for day in range(0, -a:days, -1)
        let file_candidate = expand(strftime("~/.notes/note-%d-%m-%y.md", (now - now % one_day) + (day * one_day )))
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
    try
        if bufexists(g:notes_files[g:notes_file_idx])
            execute "buffer" g:notes_files[g:notes_file_idx]
        else
            execute "drop" g:notes_files[g:notes_file_idx]
        endif
        call s:NotesBufferSettings()
    catch /.*/
    endtry
endfunction

execute mkdir(expand("~/.notes"), "p")
nnoremap <Leader>n <Cmd>call NotesToday()<CR>
nnoremap <Leader>N <Cmd>e ~/.notes<CR>

