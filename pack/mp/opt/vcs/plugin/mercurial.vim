vim9script

import autoload 'run.vim' as run

g:vcs_hg_changed_files = []

def GetChangedFiles(): list<string>
  var files: string
  var candidates: list<string>
  if g:vcs_hg_changed_files == []
      g:vcs_hg_changed_files = systemlist("hg status")
  endif
  for e in g:vcs_hg_changed_files
    files = substitute(e, '\(M\|R\|A\)\s\(.*\)', '\2', '')
    add(candidates, files)
  endfor
  return candidates
enddef

def CompleteHg(arg_lead: string, cmd_line: string, cur_pos: number): list<string>
  var candidates = [ "revert", "status", "commit", "diff", "tag", "branch" ]
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

augroup GroupVcsHg
  autocmd!
  autocmd BufWinEnter HG-Output setf vcs_output
  autocmd BufWinEnter HG-Output nnoremap <buffer> <CR> :Hg<Space>
    autocmd CmdlineEnter : g:vcs_hg_changed_files = []
augroup END

# Uncomment when testing
defcompile

