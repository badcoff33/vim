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

import "run.vim"
import "utils.vim"

var grep_glob_patterns = {
  c:      ['*.c', '*.h', '*.h.in', '*.850', '*.s', '*.asm'],
  cpp:    ['*.c', '*.h', '*.h.in', '*.cc', '*.hh'],
  vim:    ['*.vim', '*vimrc'],
  asm:    ['*.850', '*.s'],
  py:     ['*.py'],
  cmake:  ['*.cmake', 'CMakeLists.txt']
}

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

def GrepIncludes(): string
  var include_string: string
  if g:grep_for_all[0] ==? "true" || !has_key(grep_glob_patterns, &ft)
    include_string = GrepGlobSwitch("*")
  else
    for e in grep_glob_patterns[&ft]
      include_string = include_string .. GrepGlobSwitch(e) .. " "
    endfor
  endif
  return include_string
enddef

def GrepExcludes(): string
  var exclude_string: string
  if g:grep_for_all[0] ==? "true"
    return ""
  else
    for e in g:grep_excludes
      exclude_string = exclude_string .. GrepGlobSwitchExclude(e) .. " "
    endfor
  endif
  return exclude_string
enddef

def GrepCommand(): string
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
  var cmd_line = join([
    GrepCommand(),
    GrepExcludes(),
    GrepIncludes(),
    pattern,
    utils.ToString(g:grep_paths)],
    " ")
  run.RunStart({
    cmd: cmd_line,
    regexp: &grepformat,
    no_popup: true
  })
enddef

var last_pattern: string
var last_options: string
var last_paths: string

export def GrepPatternInput()
  var pattern: string
  var options: string
  var paths: string

  pattern = input("Pattern (use '\\bPATTERN\\b' for exact matches'): ", last_pattern, "tag")

  if pattern == ""

    last_options = GrepExcludes() .. " " .. GrepIncludes()
    last_paths = utils.ToString(g:grep_paths)

  else

    if last_options == ""
      last_options = GrepExcludes() .. " " .. GrepIncludes()
    endif
    if last_paths == ""
      last_paths = utils.ToString(g:grep_paths)
    endif

    options = input("Grep options: ", last_options)
    paths = input("Grep path: ", last_paths, "dir")

    run.RunStart({
      cmd: join([GrepCommand(), options, pattern, paths], " "),
      regexp: &grepformat,
      no_popup: true
    })

    last_pattern = pattern
    last_options = options
    last_paths = paths

  endif
enddef

defcompile

