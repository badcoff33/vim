vim9script
# Preview ReStructuredText as HTML

def g:RstMakeHTML(command: string)
  if filereadable(expand("%"))
    call run#RunStart({
      cmd: command,
      background: true,
      no_write: true
    })
  endif
enddef

command! -buffer RstOpenPreview call g:RstMakeHTML("rst2preview \"" .. expand("%") .. "\"")
command! -buffer RstUpdatePreview call g:RstMakeHTML("rst2preview --update-only \"" .. expand("%") .. "\"")

autocmd FocusLost <buffer> call g:RstMakeHTML("rst2preview --update-only \"" .. expand("%") .. "\"")

defcompile


