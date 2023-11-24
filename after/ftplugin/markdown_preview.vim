vim9script
# Preview Markdown as HTML

def g:MarkdownMakeHTML(command: string)
  if filereadable(expand("%"))
    call run#RunStart({
      cmd: command,
      background: true,
      no_write: true
    })
  endif
enddef

command! -buffer MarkdownOpenPreview call g:MarkdownMakeHTML("md2preview \"" .. expand("%") .. "\"")
command! -buffer MarkdownUpdatePreview call g:MarkdownMakeHTML("md2preview --update-only \"" .. expand("%") .. "\"")

autocmd FocusLost <buffer> call g:MarkdownMakeHTML("md2preview --update-only \"" .. expand("%") .. "\"")

defcompile

