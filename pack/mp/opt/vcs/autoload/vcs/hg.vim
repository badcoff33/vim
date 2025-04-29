vim9script

import 'run.vim' as run

g:vcs_hg_changed_files = []

var pattern = {
  'diff': '\(M\)\s\(.*\)',
  'add': '\(?\)\s\(.*\)',
  '*': '\(M\|R\|A\)\s\(.*\)'
}

export def GetRootDir(dir: string): string
  var main_dir: string

  if !isdirectory(dir)
    return ""
  endif

  main_dir = finddir(".hg", dir .. ";", 1)
  if main_dir == ""
    return ""
  else
    return fnamemodify(main_dir, ":h")
  endif

enddef

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

export def Vimdiff(file = "")
  var rev: string
  var bname: string
  var head: string
  var tail: string
  var save_dir: string

  if file == ""
    bname = bufname("%")
    head = fnamemodify(bufname("%"), ":p:h")
    tail = fnamemodify(bufname("%"), ":t")
  else
    bname = file
    head = fnamemodify(file, ":p:h")
    tail = fnamemodify(file, ":t")
  endif

  save_dir = getcwd()

  inputsave()
  rev = input("Revision (tip, -[1...]: ", "tip")
  inputrestore()
  if rev == ""
    return
  endif

  execute $"silent tabedit {bname}"
  diffthis

  vert new
  setlocal buftype=nofile nobuflisted
  try
    execute $"silent noautocmd cd {head}"
    silent execute $"read ++edit !hg cat -r {rev} {bufname('#')}"
  catch
    echo $"error in git show {rev}:./{tail}"
  finally
    execute $"silent noautocmd cd {save_dir}"
  endtry

  silent normal gg0d_
  diffthis

  nnoremap <buffer> c :bwipeout<CR>:tabclose<CR>
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

