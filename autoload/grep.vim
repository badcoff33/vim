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

g:grep_command            = "grep"
g:grep_options            = "-Hnr"
g:grep_excludes           = get(g:, "grep_excludes", [])
g:grep_paths              = get(g:, "grep_paths", ".")
g:grep_option_all         = get(g:, "grep_option_all", false)
g:grep_dict               = {}

var grep_glob_patterns = {
  c:      ['*.c', '*.h', '*.850', '*.s'],
  cpp:    ['*.c', '*.h', '*.850', '*.s', '*.cc', '*.hh'],
  vim:    ['*.vim', '*vimrc'],
  asm:    ['*.850', '*.s'],
  py:     ['*.py'],
  cmake:  ['*.cmake', 'CmakeLists.txt']
}

export def GrepCommand(): string
  return g:grep_command .. ' ' .. g:grep_options
enddef

export def GrepPatternInput()
  execute join( [
    ":Grep",
    GrepExcludes(),
    GrepIncludes(),
    input("Pattern (use '\\bPATTERN\\b' for exact matches'): ", "", "tag"),
    utils.ToString(g:grep_paths)
  ], " ")
enddef

export def GrepPattern(): string
    return len(expand("<cword>")) == 0 ? "STRING" : '\b' .. expand("<cword>") .. '\b'
enddef

export def GrepIncludes(): string
  var include_string: string
  if g:grep_option_all == true
    include_string = GrepGlobSwitch("*")
  else
    if has_key(grep_glob_patterns, &ft)
      for e in grep_glob_patterns[&ft]
        include_string = include_string .. GrepGlobSwitch(e) .. " "
      endfor
    endif
  endif
  return include_string
enddef

export def GrepExcludes(): string
  var exclude_string = ""
  for e in g:grep_excludes
    exclude_string = exclude_string .. GrepGlobSwitchExclude(e) .. " "
  endfor
  return exclude_string
enddef

def GrepGlobSwitchExclude(anti_pattern: string): string
  if g:grep_command == 'grep'
    return "--exclude-dir=" .. anti_pattern
  elseif g:grep_command == 'rg'
    if has("unix")
      return "--exclude-dir=" .. anti_pattern
    else
      return "--exclude-dir=" .. anti_pattern
    endif
  endif
  return ""
enddef

def GrepGlobSwitch(pattern: string): string
  if g:grep_command == 'grep'
    return "--include=" .. pattern
  elseif g:grep_command == 'rg'
    if has("unix")
      return "-g " .. pattern
    else
      return "--iglob " .. pattern
    endif
  endif
  return ""
enddef

defcompile

