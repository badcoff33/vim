vim9script

import autoload 'run.vim' as run

def WhichVcs(): string
  if isdirectory(".git")
      return "git"
  elseif isdirectory(".hg")
      return "hg"
  else
      return ""
  endif
enddef

def CompleteCandidatesHg(): list<string>
    var options: list<string>
    var filename: string

    options = ["commit", "status", "heads", "resolve", "bookmark", "last", "log"]
    for e in systemlist("hg st") # returns list in format "[M|R|A] <FILENAME>"
        filename = split(e, " ")[1]
        options = add(options, filename)
    endfor
    return options
enddef


def CompleteCandidatesGit(): list<string>
    var options: list<string>
    var filename: string

    options = [ "commit", "status", "add" ]
    for e in systemlist("git st")
        var ee = split(e, " ")
        if len(ee) >= 1 && ee[0] == "M"
            filename = ee[1]
            options = add(options, filename)
        endif
    endfor
    return options
enddef

def CompleteVcs(arg_lead: string, cmd_line: string, cur_pos: number): string
    var matching_keys: string
    var candidates: list<string>
    var filename: string

    if WhichVcs() == "git"
        candidates = CompleteCandidatesGit()
    elseif WhichVcs() == "hg"
        candidates = CompleteCandidatesHg()
    else
        candidates = []
    endif

    for k in sort(candidates)
        if match(k, arg_lead) >= 0
            matching_keys = matching_keys .. k .. "\n"
        endif
    endfor
    return matching_keys
enddef

command! -complete=custom,CompleteVcs -nargs=+ Vcs run.Run({cmd: g:WhichVcs() .. ' <args>', name: "HG-OUTPUT"})

nnoremap <Leader>v :<C-u>Vcs<Space>

# Uncomment when testing
defcompile
