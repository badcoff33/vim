vim9script

import autoload 'run.vim' as run

augroup GroupVcsHg
  autocmd!
  autocmd BufWinEnter HG-Output setf vcs_output
  autocmd BufWinEnter HG-Output nnoremap <buffer> <CR> :Hg<Space>
augroup END

def GetChangedFiles(): list<string>
  var filename: string
  var candidates: list<string>
  for e in systemlist("hg status") # returns list in format "[M|R|A] <FILENAME>"
    filename = substitute(e, '\(M\|R\|A\)\s\(.*\)', '\2', '')
    candidates = add(candidates, filename)
  endfor
  return candidates
enddef

def CompleteHg(arg_lead: string, cmd_line: string, cur_pos: number): list<string>
  var candidates = [ "revert", "status", "commit", "diff", "tag" ]
  var hg_sub_cmd = matchstr(substitute(cmd_line, 'Hg\s\+', '', ''), '\w\+')
  if index(candidates, hg_sub_cmd) == -1
    filter(candidates, (idx, val) => val =~ hg_sub_cmd)
  else
    candidates = GetChangedFiles()
    filter(candidates, (idx, val) => val =~ arg_lead)
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

