vim9script
# Preview ReStructuredText as HTML

import "run.vim"

def g:RstMakeHTML(command: string)
  if filereadable(expand("%"))
    call run.RunStart({
      cmd: command,
      background: true,
      no_write: true
    })
  endif
enddef

command! -buffer RstOpenPreview call g:RstMakeHTML("view_markups --view \"" .. expand("%") .. "\"")
command! -buffer RstUpdatePreview call g:RstMakeHTML("view_markups \"" .. expand("%") .. "\"")

autocmd FocusLost <buffer> call g:RstMakeHTML("view_markups /U \"" .. expand("%") .. "\"")

nnoremap <buffer> <LocalLeader>p <Cmd>RstOpenPreview<CR>

defcompile
