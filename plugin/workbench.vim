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
import autoload "selector/use.vim"

g:grep_backend = "rg"

if g:grep_backend == "rg"
g:grep_cmd = get(g:, "grep_cmd", "grep")
g:grep_options = get(g:, "grep_options", ["-Hnr"])
g:grep_excludes = get(g:, "grep_excludes", [])
g:grep_paths = get(g:, "grep_paths", ["."])
g:grep_for_all = get(g:, "grep_for_all", false)
endif

if g:grep_backend == "grep"
g:grep_cmd = get(g:, "grep_cmd", "rg")
g:grep_options = get(g:, "grep_options", ["--vimgrep"])
g:grep_excludes = get(g:, "grep_excludes", [])
g:grep_paths = get(g:, "grep_paths", ["."])
g:grep_for_all = get(g:, "grep_for_all", true)
endif

g:ctags_cmd = get(g:, "ctags_cmd", "ctags")
g:ctags_options = get(g:, "ctags_options", [ "-R", "." ])

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
nnoremap <Leader>G :call grep#GrepPatternInput()<CR>
nnoremap <silent> <Leader>g :call grep#RunCompiledCmdLine("<C-r><C-w>")<CR>

command! -nargs=0 CtagsForceUpdate ctags.CtagsTriggerUpdate(true)
command! -nargs=* -complete=file Make make.MakeStart(<q-args>)
command! -nargs=0 WbConfig EditWorkbenchVariable()

nnoremap <Leader>M :<C-u>Make <Up>
nnoremap <Leader>m :<C-u>Make <Up><CR>
nnoremap <Leader>b <Cmd>call selector#use#Buffers()<CR>
nnoremap <Leader>f <Cmd>call selector#use#Files()<CR>
nnoremap <Leader>t <Cmd>call selector#use#Tags()<CR>

defcompile

