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
import autoload "ctags.vim"
import autoload "popnews.vim"
import autoload "torchlight.vim"

var ctags_job: job

def MakeCallback()
  torchlight.TorchlightUpdate()
enddef

def MakeStart(cmd: string)
  torchlight.TorchlightClearAll()
  run.RunStart({
    cmd: &makeprg .. " " .. cmd,
    callback: MakeCallback
  })
enddef

augroup GroupMake
  autocmd!
augroup END

def g:CtagsTriggerUpdate(verbose = false)
  var ctags_options: string

  if job_status(ctags_job) == "run" || !exists("g:ctags_options")
    return
  endif

  if type(g:ctags_options) == v:t_string
    ctags_options = g:ctags_options
  elseif type(g:ctags_options) == v:t_list
    ctags_options = join(g:ctags_options, " ")
  else
    popnews.Open("unknown type of 'g:ctags_options'", 4000, "ErrorMsg")
    return
  endif

  ctags_job = run.RunStart({cmd: 'ctags ' .. ctags_options, background: true})
  if job_status(ctags_job) != "run"
    popnews.Open("check ctags options", 4000, "ErrorMsg")
  elseif verbose == true
    popnews.Open('ctags ' .. ctags_options, 3000)
  endif
enddef

augroup GroupeCtags
  autocmd!
  autocmd BufWritePost *.c,*.h call CtagsTriggerUpdate()
  autocmd BufWritePost *.cpp,*.hpp call CtagsTriggerUpdate()
augroup END

g:rg_excludes = get(g:, "rg_excludes", [])
g:rg_paths = get(g:, "rg_paths", ["."])
g:rg_option_all = get(g:, "rg_option_all", false)
g:rg_find_files_options = get(g:, "rg_find_files_options", "-u")

g:rg_dict = {}
g:rg_glob_patterns = {
  c:      ['*.c', '*.h', '*.850', '*.s'],
  cpp:    ['*.c', '*.h', '*.850', '*.s', '*.cc', '*.hh'],
  vim:    ['*.vim', '*vimrc'],
  asm:    ['*.850', '*.s'],
  py:     ['*.py'],
  cmake:  ['*.cmake', 'CmakeLists.txt']
}

g:RgPattern = () =>  len(expand("<cword>")) == 0 ? "STRING" : '\b' .. expand("<cword>") .. '\b'
g:RgPaths = () => join(g:rg_paths, " ")

def g:RgPatternInput()
  var pattern = len(expand("<cword>")) == 0 ? "STRING" : expand("<cword>")
  execute join( [":Rg", g:RgExcludes(), g:RgIncludes(), input("Pattern (use '\\bPATTERN\\b' for exact matches'): ", pattern, "tag"), g:RgPaths() ], " ")
enddef

def g:RgPrettyPrint()
  for e in getqflist({ "nr": "$", "all": 0 }).items
    var temp: list<number>
    if has_key(g:rg_dict, e.bufnr)
      temp = g:rg_dict[e.bufnr]
    else
      temp = []
    endif
    add(temp, e.lnum)
    g:rg_dict[e.bufnr] = temp
  endfor
enddef

def g:RgIncludes(): string
  var include_string: string
  if g:rg_option_all == true
    include_string = g:RgGlobSwitch("*")
  else
    if has_key(g:rg_glob_patterns, &ft)
      for e in g:rg_glob_patterns[&ft]
        include_string = include_string .. g:RgGlobSwitch(e) .. " "
      endfor
    endif
  endif
  return include_string
enddef

def g:RgExcludes(): string
  var exclude_string = ""
  for e in g:rg_excludes
    exclude_string = exclude_string .. RgGlobSwitchExclude(e) .. " "
  endfor
  return exclude_string
enddef

def RgGlobSwitchExclude(anti_pattern: string): string
  if has("unix")
    return "-g !" .. anti_pattern
  else
    return "--iglob !" .. anti_pattern
  endif
enddef

def g:RgGlobSwitch(pattern: string): string
  if has("unix")
    return "-g " .. pattern
  else
    return "--iglob " .. pattern
  endif
enddef

def g:RgConfig()
  echo printf("g:rg_paths\t= %s", join(g:rg_paths, ", "))
  echo printf("g:rg_excludes\t= %s", join(g:rg_excludes, ", "))
  echo printf("g:rg_option_all\t= %s", g:rg_option_all)
enddef

if executable("rg")
  # Using links? Ripgrep supports this by the option '--follow'
  set grepprg=rg\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  command!                -nargs=0 RgConfig call g:RgConfig()
  command! -complete=file -nargs=* RgFindFiles run.RunStart({cmd: "rg --files " .. g:rg_find_files_options .. " " .. g:RgGlobSwitch('<args>'), name: "RgFiles"})
  command! -complete=file -nargs=* Rg run.RunStart({cmd: 'rg --vimgrep ' .. ' <args>', regexp: &grepformat, no_popup: true})
endif

command! -nargs=0                CtagsForceUpdate CtagsTriggerUpdate(true)
command! -nargs=* -complete=file                  Make MakeStart(<q-args>)

nnoremap <Leader>m :<C-u>Make<Up>

if executable("rg")
  nnoremap <Leader><CR> :call g:RgPatternInput()<CR>
  nnoremap <silent> <Leader><Leader> :<C-r>=join([":Rg", g:RgExcludes(), g:RgIncludes(), g:RgPattern(), g:RgPaths()], " ")<CR><CR>
endif

defcompile
