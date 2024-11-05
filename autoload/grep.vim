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

var grep_glob_patterns = {
  c:      ['*.c', '*.h', '*.h.in', '*.850', '*.s'],
  cpp:    ['*.c', '*.h', '*.h.in', '*.850', '*.s', '*.cc', '*.hh'],
  vim:    ['*.vim', '*vimrc'],
  asm:    ['*.850', '*.s'],
  py:     ['*.py'],
  cmake:  ['*.cmake', 'CmakeLists.txt']
}

export def GrepCommand(): string
  assert_true(g:grep_cmd == 'rg' || g:grep_cmd == 'grep', "set g:grep_cmd to 'rg' or 'grep' only")
  if g:grep_cmd == 'rg'
    set grepformat=%f:%l:%c:%m
    set grepprg=rg
  endif
  if g:grep_cmd == 'grep'
    set grepformat=%f:%l:%m
    set grepprg=grep
  endif
  return g:grep_cmd .. ' ' .. utils.ToString(g:grep_options)
enddef

export def RunCompiledCmdLine(pattern: string)
  var cmd_line = join([grep#GrepCommand(), grep#GrepExcludes(), grep#GrepIncludes(), pattern, utils#ToString(g:grep_paths)], " ")
  run.RunStart({
    cmd: cmd_line,
    regexp: &grepformat,
    no_popup: true
  })
enddef

export def GrepPatternInput()
  var pattern = input("Pattern (use '\\bPATTERN\\b' for exact matches'): ", "", "tag")
  if pattern->len() > 0
    var edited_options = input("Grep options: ", grep#GrepExcludes() .. " " .. grep#GrepIncludes())
    var edited_paths = input("Grep path: ", utils#ToString(g:grep_paths), "dir")
    var cmd_line = join([grep#GrepCommand(), edited_options, pattern, edited_paths], " ")
    run.RunStart({
      cmd: cmd_line,
      regexp: &grepformat,
      no_popup: true
    })
  endif
enddef

export def GrepIncludes(): string
  var include_string: string
  if g:grep_for_all == true || !has_key(grep_glob_patterns, &ft)
    include_string = GrepGlobSwitch("*")
  else
    for e in grep_glob_patterns[&ft]
      include_string = include_string .. GrepGlobSwitch(e) .. " "
    endfor
  endif
  return include_string
enddef

export def GrepExcludes(): string
  var exclude_string: string
  if g:grep_for_all == true
    return ""
  else
    for e in g:grep_excludes
      exclude_string = exclude_string .. GrepGlobSwitchExclude(e) .. " "
    endfor
  endif
  return exclude_string
enddef

def GrepGlobSwitchExclude(anti_pattern: string): string
  if g:grep_cmd == 'grep'
    return "--exclude-dir=" .. anti_pattern
  elseif g:grep_cmd == 'rg'
    if has("unix")
      return "--glob !" .. anti_pattern
    else
      return "--iglob !" .. anti_pattern
    endif
  endif
  return ""
enddef

def GrepGlobSwitch(pattern: string): string
  if g:grep_cmd == 'grep'
    return "--include=" .. pattern
  elseif g:grep_cmd == 'rg'
    if has("unix")
      return "-g " .. pattern
    else
      return "--iglob " .. pattern
    endif
  endif
  return ""
enddef

defcompile

