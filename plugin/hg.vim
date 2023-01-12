vim9script

import autoload 'run.vim' as run

def CompleteHg(arg_lead: string, cmd_line: string, cur_pos: number): string
    var matching_keys = ""
    var options: list<string>
    var filename: string

    options = ["commit", "status", "heads", "resolve", "bookmark", "last", "log"]
    for e in systemlist("hg st")
        filename = split(e, " ")[1]
        options = add(options, filename)
    endfor
    for k in sort(options)
        if match(k, arg_lead) >= 0
            matching_keys = matching_keys .. k .. "\n"
        endif
    endfor
    return matching_keys
enddef

command! -complete=custom,CompleteHg -nargs=+ Hg run.Run({cmd: 'hg <args>', name: "HG-OUTPUT"})

nnoremap <Leader>v :<C-u>Hg<Space>

