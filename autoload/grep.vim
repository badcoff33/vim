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
import "config.vim"

var grep_glob_patterns = {
  c:      ['*.c', '*.h', '*.h.in', '*.850', '*.s', '*.asm'],
  cpp:    ['*.c', '*.h', '*.h.in', '*.cc', '*.hh'],
  vim:    ['*.vim', '*vimrc'],
  asm:    ['*.850', '*.s'],
  py:     ['*.py'],
  cmake:  ['*.cmake', 'CMakeLists.txt']
}

def GrepGlobSwitchExclude(anti_pattern: string): string
  return "--exclude-dir=" .. anti_pattern
enddef

def GrepGlobSwitch(pattern: string): string
    return "--include=" .. pattern
enddef

def GrepIncludes(): string
  var include_string: string

  for e in grep_glob_patterns[&ft]
    include_string = include_string .. GrepGlobSwitch(e) .. " "
  endfor

  return include_string
enddef

def GrepExcludes(): string
  var exclude_string: string

  for e in g:cfg.grep.exclude
    exclude_string = exclude_string .. GrepGlobSwitchExclude(e) .. " "
  endfor

  return exclude_string
enddef

export def RunCompiledCmdLine(pattern: string)
  var cmd_line = join([
    "grep -Hnr",
    GrepExcludes(),
    GrepIncludes(),
    pattern,
    utils.ToString(g:cfg.src_paths)],
    " ")
  run.RunStart({
    cmd: cmd_line,
    regexp: "%f:%l:%",
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
    last_paths = utils.ToString(g:cfg.src_paths)

  else

    if last_options == ""
      last_options = GrepExcludes() .. " " .. GrepIncludes()
    endif
    if last_paths == ""
      last_paths = utils.ToString(g:cfg.src_paths)
    endif

    options = input("Grep options: ", last_options)
    paths = input("Grep path: ", last_paths, "dir")

    run.RunStart({
      cmd: join(["grep -Hnr", options, pattern, paths], " "),
      regexp: &grepformat,
      no_popup: true
    })

    last_pattern = pattern
    last_options = options
    last_paths = paths

  endif
enddef

defcompile

