vim9script
# Preview ReStructuredText as HTML
import "run.vim"

def g:OrgMakeHTML(command: string)
  if filereadable(expand("%"))
    call run.RunStart({
      cmd: command,
      background: true,
      no_write: true
    })
  endif
enddef

command! -buffer OrgOpenPreview call g:OrgMakeHTML("view_markups --view \"" .. expand("%") .. "\"")
command! -buffer OrgUpdatePreview call g:OrgMakeHTML("view_markups /U \"" .. expand("%") .. "\"")

autocmd FocusLost <buffer> call g:OrgMakeHTML("view_markups \"" .. expand("%") .. "\"")

nnoremap <buffer> <LocalLeader>p <Cmd>OrgOpenPreview<CR>

defcompile
