vim9script
# Preview ReStructuredText as HTML

def g:OrgMakeHTML(command: string)
  if filereadable(expand("%"))
    call run#RunStart({
      cmd: command,
      background: true,
      no_write: true
    })
  endif
enddef

command! -buffer OrgOpenPreview call g:OrgMakeHTML("preview \"" .. expand("%") .. "\"")
command! -buffer OrgUpdatePreview call g:OrgMakeHTML("preview /U \"" .. expand("%") .. "\"")

autocmd FocusLost <buffer> call g:OrgMakeHTML("preview /U \"" .. expand("%") .. "\"")

nnoremap <buffer> <LocalLeader>p <Cmd>OrgOpenPreview<CR>

defcompile

