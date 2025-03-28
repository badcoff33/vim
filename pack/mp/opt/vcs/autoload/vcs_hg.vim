vim9script

import 'run.vim' as run

g:vcs_hg_changed_files = []

var pattern = {
  'diff': '\(M\)\s\(.*\)',
  'add': '\(?\)\s\(.*\)',
  '*': '\(M\|R\|A\)\s\(.*\)'
}

def GetChangedFiles(cmd: string): list<string>
  var file: string
  var pat: string
  var candidates: list<string>
  if g:vcs_hg_changed_files == []
    g:vcs_hg_changed_files = systemlist("hg status")
  endif
  pat = pattern[has_key(pattern, cmd) ? cmd : '*']
  for status_line in g:vcs_hg_changed_files
    file = substitute(status_line, pat, '\2', '')
    if status_line != file
      add(candidates, file)
    endif
  endfor
  return candidates
enddef

export def CompleteHg(arg_lead: string, cmd_line: string, cur_pos: number): list<string>
  var candidates = [ "add", "revert", "status", "commit", "diff", "tag", "branch", "push", "pull", "incoming", "outgoing" ]
  var hg_sub_cmd = matchstr(substitute(cmd_line, 'Hg\s\+', '', ''), '\w\+')
  if index(candidates, hg_sub_cmd) == -1
    filter(candidates, (idx, val) => val =~ '^' .. hg_sub_cmd)
  else
    candidates = GetChangedFiles(hg_sub_cmd)
    filter(candidates, (idx, val) => val =~ arg_lead)
  endif
  return candidates
enddef

export def ShowDiff(file = "")
  # hg diff -c -1 file/with/slashes
  execute "tabedit" (file == "") ? bufname("%") : file
  inputsave()
  var rev = input("Revision (tip, -[1...]: ", "tip")
  inputrestore()
  diffthis
  vert new
  setlocal buftype=nofile nobuflisted
  silent execute $"read ++edit !hg cat -r {rev} {bufname('#')}"
  silent normal gg0d_
  diffthis
  nnoremap <buffer> c :bwipeout<CR>:tabclose<CR>
  nnoremap <buffer> <C-j> ]c
  nnoremap <buffer> <C-k> [c
enddef

export def Execute(hg_command: string)
  run.RunStart({
    cmd: 'hg ' .. hg_command,
    name: "HG-Output"
  })
enddef

augroup GroupVcsHg
  autocmd!
  autocmd BufWinEnter HG-Output setf vcs_output
  autocmd BufWinEnter HG-Output nnoremap <buffer> <CR> :Hg<Space>
  autocmd BufWinEnter HG-Output nnoremap <buffer> <LocalLeader>d :HgDiff <C-r><C-f><CR>
  autocmd CmdlineEnter : g:vcs_hg_changed_files = []
augroup END
augroup END

# Uncomment when testing
defcompile

