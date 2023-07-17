
let g:notes_files = []
let g:notes_home = expand("~/.notes")

if !isdirectory(g:notes_home)
    mkdir mkdir(g:notes_home)
endif

function! s:NotesBufferSettings()
    setfiletype markdown
    nnoremap <LocalLeader>f <Cmd>call NotesBacklog(+1)<CR>
    nnoremap <LocalLeader>b <Cmd>call NotesBacklog(-1)<CR>
endfunction

function! NotesToday()
    execute "drop" strftime("~/.notes/note-%Y-%m-%d.md")
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
        execute "drop" g:popup_file_list[a:result - 1]
    endif
endfunction

function! NotesPopup()
    let current_files = globpath(g:notes_home, "*.md", v:false, v:true)
    let headlines = GetHeadlines(reverse(sort(current_files)))
    call popup_menu(reverse(sort(headlines)), #{
                \ callback: 'NotesSelected',
                \ borderchars: [' ']
                \ })
endfunction

execute mkdir(g:notes_home, "p")
nnoremap <Leader>n. <Cmd>call NotesToday()<CR>
nnoremap <Leader>nn <Cmd>call NotesPopup()<CR>
nnoremap <Leader>ng :vimgrep <C-r>=g:notes_home<CR>/*.md<C-b><C-Right><Space>

