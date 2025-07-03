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

command! -buffer MarkdownOpenPreview call g:MarkdownMakeHTML("view_markups --view \"" .. expand("%") .. "\"")
command! -buffer MarkdownUpdatePreview call g:MarkdownMakeHTML("view_markups \"" .. expand("%") .. "\"")

autocmd FocusLost <buffer> call g:MarkdownMakeHTML("view_markups \"" .. expand("%") .. "\"")

nnoremap <buffer> <LocalLeader>p <Cmd>MarkdownOpenPreview<CR>

defcompile
