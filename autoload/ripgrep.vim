vim9script
# File plugin for C
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

def Includes(): string
  var AddSwitch = (str) => (has("unix") ? "-g " : "--iglob ") .. str .. " "
  var include_string: string

  for e in grep_glob_patterns[&ft]
    include_string ..= AddSwitch(e)
  endfor

  if include_string == ""
    include_string = AddSwitch("*")
  endif

  return include_string
enddef

def Excludes(): string
  var AddSwitch = (str) => (has("unix") ? "--glob !" : "--iglob !") .. str .. " "
  var exclude_string: string

  for e in g:cfg.ripgrep.exclude
    exclude_string ..= AddSwitch(e)
  endfor

  return exclude_string
enddef

export def RunCompiledCmdLine(pattern: string)

  var cmd_line: string

  config.Update()

  run.RunStart({
    cmd: join([
      $'rg -u --vimgrep {(&ignorecase == true) ? "-i" : ""}',
      Excludes(),
      Includes(),
      pattern,
      utils.ToString(g:cfg.src_paths)], " "),
    regexp: "%f:%l:%c:%m",
    no_popup: true
  })
enddef

var last_pattern: string
var last_options: string
var last_paths: string

export def PatternInput()
  var pattern: string
  var options: string
  var paths: string

  pattern = input("Pattern (use '\\bPATTERN\\b' for exact matches'): ", last_pattern, "tag")

  if pattern == ""

    last_options = Excludes() .. " " .. Includes()
    last_paths = utils.ToString(g:cfg.src_paths)

  else

    if last_options == ""
      last_options = Excludes() .. " " .. Includes()
    endif
    if last_paths == ""
      last_paths = utils.ToString(g:cfg.src_paths)
    endif

    options = input("Grep options: ", last_options)
    paths = input("Grep path: ", last_paths, "dir")

    run.RunStart({
      cmd: join([
        $'rg -u --vimgrep {(&ignorecase == true) ? "-i" : ""}',
        options,
        pattern,
        paths], " "),
      regexp: "%f:%l:%c:%m",
      no_popup: true
    })

    last_pattern = pattern
    last_options = options
    last_paths = paths

  endif
enddef

defcompile


