vim9script

import autoload 'run.vim' as run

def GetCompleteCandidates(): list<string>
    var options: list<string>
    var filename: string

    options = ["commit", "status", "heads", "resolve", "bookmark", "last", "log"]

    for e in systemlist("hg st") # returns list in format "[M|R|A] <FILENAME>"
        filename = split(e, " ")[1]
        options = add(options, filename)
    endfor

    return options
enddef

def CompleteHg(arg_lead: string, cmd_line: string, cur_pos: number): string
    var matching_keys: string
    var candidates: list<string>
    var filename: string

    candidates = GetCompleteCandidates()

    for k in sort(candidates)
        if match(k, arg_lead) >= 0
            matching_keys = matching_keys .. k .. "\n"
        endif
    endfor
    return matching_keys
enddef

command! -complete=custom,CompleteHg -nargs=+ Hg run.Run({cmd: 'hg <args>', name: "HG-OUTPUT"})

nnoremap <Leader>vv :<C-u>Hg<Space>
nnoremap <Leader>vs <Cmd>Hg status<CR>
nnoremap <Leader>vl <Cmd>Hg sl<CR>

# Uncomment when testing
defcompile
