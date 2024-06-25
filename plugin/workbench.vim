vim9script
# File plugin for C
#
# Description: Workbench contain things to ease working in projects. is a project
#
# - Automaticalls update Ctags files after a buffer write.
# - Run Ripgrep
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

g:ctags_command         = "ctags -R ."
g:ctags_options         = ""

def ColorSelected(id: any, result: any)
  echo id result
  if result == 1
    g:ctags_command = input("Edit 'g:ctags_command': ", utils.ToString(g:ctags_command))
  elseif result == 2
    g:ctags_options = input("Edit 'g:ctags_options': ", utils.ToString(g:ctags_options))
  elseif result == 3
    g:grep_command = input("Edit 'g:grep_command': ", utils.ToString(g:grep_command))
  elseif result == 4
    g:grep_options = input("Edit 'g:grep_options': ", utils.ToString(g:grep_options))
  elseif result == 5
    g:grep_excludes = input("Edit 'g:grep_excludes': ", utils.ToString(g:grep_excludes))
  elseif result == 6
    g:grep_paths = input("Edit 'g:grep_paths': ", utils.ToString(g:grep_paths))
  endif
enddef

def EditWorkbenchVariable()
  var items_ordered = [
    "g:ctags_command",
    "g:ctags_options",
    "g:grep_command",
    "g:grep_options",
    "g:grep_excludes",
    "g:grep_paths",
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
    callback: 'ColorSelected',
  })
enddef

def g:WbConfig()
  echo printf("g:ctags_command\t= %s", g:ctags_command)
  echo printf("g:ctags_options\t= %s", utils.ToString(g:ctags_options))
  echo printf("g:grep_command\t= %s", g:grep_command)
  echo printf("g:grep_options\t= %s", g:grep_options)
  echo printf("g:grep_paths\t= %s", utils.ToString(g:grep_paths))
  echo printf("g:grep_excludes\t= %s", utils.ToString(g:grep_excludes))
enddef

augroup GroupeWorkbench
  autocmd!
  autocmd BufWritePost *.c,*.h ctags.CtagsTriggerUpdate()
  autocmd BufWritePost *.cpp,*.hpp ctags.CtagsTriggerUpdate()
augroup END

set grepprg=grep\ $*
set grepformat=%f:%l:%m

command! -complete=file -nargs=* FindFiles run.RunStart({cmd: 'dir /S/B <args>', name: "RG-FILES"})
command! -complete=file -nargs=* Grep      run.RunStart({cmd: grep.GrepCommand() .. ' <args>', regexp: &grepformat, no_popup: true})
nnoremap <Leader><CR> :call grep#GrepPatternInput()<CR>
nnoremap <silent> <Leader><Leader> :<C-r>=join([":Grep", grep#GrepExcludes(), grep#GrepIncludes(), grep#GrepPattern(), utils#ToString(g:grep_paths), " "])<CR><CR>

command! -nargs=0 WbConfig g:WbConfig()
command! -nargs=0 CtagsForceUpdate g:CtagsTriggerUpdate(true)
command! -nargs=* -complete=file Make make.MakeStart(<q-args>)
command! -nargs=0 WbEditConfig EditWorkbenchVariable()

nnoremap <Leader>m :<C-u>Make <Up>
nnoremap <Leader>1 :call filter_menu#SelectBuf()<CR>
nnoremap <Leader>2 :call filter_menu#SelectFiles()<CR>
nnoremap <Leader>3 :call filter_menu#SelectTags()<CR>

defcompile

