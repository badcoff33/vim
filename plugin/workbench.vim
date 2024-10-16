vim9script
# File plugin for C
#
# Description: Workbench contain things to ease working in projects. is a project
#
# - Automaticalls update Ctags files after a buffer write.
# - Run Grep/Ripgrep
# - Run Make
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import autoload "run.vim"
import autoload "utils.vim"
import autoload "ctags.vim"
import autoload "make.vim"
import autoload "grep.vim"
import autoload "popnews.vim"
import autoload "filter_menu.vim"

g:ctags_cmd = get(g:, "ctags_cmd", "ctags")
g:ctags_options = get(g:, "ctags_options", [ "-R", "." ])
if 0
g:grep_cmd = get(g:, "grep_cmd", "grep")
g:grep_options = get(g:, "grep_options", ["-Hnr"])
g:grep_excludes = get(g:, "grep_excludes", [])
g:grep_paths = get(g:, "grep_paths", ["."])
g:grep_for_all = get(g:, "grep_for_all", false)
else
g:grep_cmd = get(g:, "grep_cmd", "rg")
g:grep_options = get(g:, "grep_options", ["--vimgrep"])
g:grep_excludes = get(g:, "grep_excludes", [])
g:grep_paths = get(g:, "grep_paths", ["."])
g:grep_for_all = get(g:, "grep_for_all", true)
endif



def WbMenuSelect(id: any, result: any)
  var input_string: string
  if result == 1
    g:ctags_cmd = input("Edit 'g:ctags_cmd': ", utils.ToString(g:ctags_cmd))
  elseif result == 2
    input_string = input("Edit 'g:ctags_options': ", utils.ToString(g:ctags_options))
    g:ctags_options = utils.ToList(input_string)
  elseif result == 3
    g:grep_cmd = input("Edit 'g:grep_cmd': ", utils.ToString(g:grep_cmd))
  elseif result == 4
    input_string = input("Edit 'g:grep_options': ", utils.ToString(g:grep_options))
    g:grep_options = utils.ToList(input_string)
  elseif result == 5
    input_string = input("Edit 'g:grep_excludes': ", utils.ToString(g:grep_excludes))
    g:grep_excludes = utils.ToList(input_string)
  elseif result == 6
    input_string = input("Edit 'g:grep_paths': ", utils.ToString(g:grep_paths))
    g:grep_paths = utils.ToList(input_string)
  elseif result == 7
    g:grep_for_all = (g:grep_for_all == true ? false : true)
    echo "g:grep_for_all = " .. g:grep_for_all
  endif
enddef

def EditWorkbenchVariable()
  var items_ordered = [
    "g:ctags_cmd = " .. utils.ToString(g:ctags_cmd),
    "g:ctags_options = " .. utils.ToString(g:ctags_options),
    "g:grep_cmd = " .. utils.ToString(g:grep_cmd),
    "g:grep_options = " .. utils.ToString(g:grep_options),
    "g:grep_excludes = " .. utils.ToString(g:grep_excludes),
    "g:grep_paths = " .. utils.ToString(g:grep_paths),
    "g:grep_for_all = " .. (g:grep_for_all ? "true" : "false"),
  ]
  popup_create(items_ordered, {
    title: 'Select variable:',
    pos: 'center',
    zindex: 200,
    drag: 1,
    wrap: 0,
    border: [0, 0, 0, 0],
    cursorline: 1,
    padding: [1, 2, 1, 2],
    filter: 'popup_filter_menu',
    mapping: 0,
    callback: 'WbMenuSelect',
  })
enddef

augroup GroupeWorkbench
  autocmd!
  autocmd BufWritePost *.c,*.h ctags.CtagsTriggerUpdate()
  autocmd BufWritePost *.cpp,*.hpp ctags.CtagsTriggerUpdate()
augroup END

set grepprg=grep\ $*
set grepformat=%f:%l:%m

command! -complete=file -nargs=* FindFiles run.RunStart({cmd: 'dir /S/B <args>', name: "RG-FILES"})
command! -complete=file -nargs=* Grep run.RunStart({cmd: grep.GrepCommand() .. ' <args>', regexp: &grepformat, no_popup: true })
nnoremap <Leader><S-Space> :call grep#GrepPatternInput()<CR>
nnoremap <silent> <Leader><Leader> :call grep#RunCompiledCmdLine("<C-r><C-w>")<CR>

command! -nargs=0 CtagsForceUpdate ctags.CtagsTriggerUpdate(true)
command! -nargs=* -complete=file Make make.MakeStart(<q-args>)
command! -nargs=0 WbConfig EditWorkbenchVariable()

nnoremap <Leader>m :<C-u>Make <Up>
nnoremap <Leader>1 :call filter_menu#SelectBuf()<CR>
nnoremap <Leader>2 :call filter_menu#SelectFiles()<CR>
nnoremap <Leader>3 :call filter_menu#SelectTags()<CR>

defcompile

