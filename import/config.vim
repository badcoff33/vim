vim9script

import "popnews.vim" as pop

const default_cfg_file = $VIMHOME .. "/templates/vim.json"
const local_cfg_file = "./vim.json"

g:cfg = {}

var defaults: dict<any>

if filereadable(default_cfg_file)
  defaults = js_decode(join(readfile(default_cfg_file)))
endif

export def Update()
  var overrides: dict<any>

  if filereadable(local_cfg_file)
    overrides = js_decode(join(readfile(local_cfg_file)))
  endif

  g:cfg = extend(defaults, overrides)
  for cmd in g:cfg.vim
    execute cmd
  endfor

  g:cfg["file"] = fnamemodify(local_cfg_file, ':p')

enddef

def UpdateCmd()
  var prev_cfg_file: string

    if g:cfg->has_key("file")
      prev_cfg_file = g:cfg["file"]
    endif
    Update()
    if prev_cfg_file == g:cfg["file"]
      pop.Open($'Updating from file {g:cfg["file"]}')
    else
      pop.Open($'Reading file {g:cfg["file"]}')
    endif

enddef

command -nargs=0 UpdateCfg UpdateCmd()
