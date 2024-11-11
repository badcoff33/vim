vim9script

import autoload 'run.vim' as run

var hg_commands = [ "revert", "status", "commit", "diff", "tag" ]

augroup GroupVcsHg
  autocmd!
  autocmd BufWinEnter HG-Output setf vcs_output
  autocmd BufWinEnter HG-Output nnoremap <buffer> <CR> :Hg<Space>
augroup END

def GetChangedFiles(kind: string): list<string>
  var filename: string
  var candidates: list<string>
  for e in systemlist("hg status") # returns list in format "[M|R|A] <FILENAME>"
    filename = substitute(e, '\(M\|R\|A\)\s\(.*\)', '\2', '')
    candidates = add(candidates, filename)
  endfor
  return candidates
enddef

def CompleteHg(arg_lead: string, cmd_line: string, cur_pos: number): list<string>
  var candidates: list<string>
  var hg_sub_cmd = substitute(cmd_line, 'Hg\s\+\(\w\+\)\s', '\1', '')
  if index(hg_commands, hg_sub_cmd) == -1
    candidates = filter(hg_commands, (idx, val) => val =~ arg_lead)
  else
    candidates = filter(GetChangedFiles(hg_sub_cmd), (idx, val) => val =~ arg_lead)
  endif
  return candidates
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

command! -nargs=* -complete=customlist,CompleteHg Hg g:VcsHgExecute(<q-args>)

# Uncomment when testing
defcompile

