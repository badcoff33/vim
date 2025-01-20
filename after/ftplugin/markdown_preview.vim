vim9script
# Preview Markdown as HTML

import "run.vim"

def g:MarkdownMakeHTML(command: string)
  if filereadable(expand("%"))
    call run.RunStart({
      cmd: command,
      background: true,
      no_write: true
    })
  endif
enddef

command! -buffer MarkdownOpenPreview call g:MarkdownMakeHTML("preview \"" .. expand("%") .. "\"")
command! -buffer MarkdownUpdatePreview call g:MarkdownMakeHTML("preview /U \"" .. expand("%") .. "\"")

autocmd FocusLost <buffer> call g:MarkdownMakeHTML("preview /U \"" .. expand("%") .. "\"")

nnoremap <buffer> <LocalLeader>p <Cmd>MarkdownOpenPreview<CR>

defcompile
