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
    for k in candidates
        if match(k, arg_lead) >= 0
            matching_keys = matching_keys .. k .. "\n"
        endif
    endfor
    return matching_keys
enddef

augroup GroupHg
    autocmd!
    autocmd BufWinEnter Hg-Output setf hg
augroup END

def g:VcsHgExecute(hg_command: string)
  run.RunStart({
    cmd: 'hg ' .. hg_command,
    name: "HG-Output"
  })
enddef

command! -nargs=* -complete=custom,g:CompleteHg Hg g:VcsHgExecute(<q-args>)

# Uncomment when testing
defcompile
