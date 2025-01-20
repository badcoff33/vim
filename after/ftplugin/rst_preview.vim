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

command! -buffer RstOpenPreview call g:RstMakeHTML("preview \"" .. expand("%") .. "\"")
command! -buffer RstUpdatePreview call g:RstMakeHTML("preview /U \"" .. expand("%") .. "\"")

autocmd FocusLost <buffer> call g:RstMakeHTML("preview /U \"" .. expand("%") .. "\"")

nnoremap <buffer> <LocalLeader>p <Cmd>RstOpenPreview<CR>

defcompile
