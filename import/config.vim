vim9script

import "popnews.vim" as pop

const default_cfg_file = $VIMHOME .. "/templates/vim.json"
const local_cfg_file = "./vim.json"

g:cfg = {}

var defaults: dict<any>
var saved_cfg_file: string

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
  if g:cfg.file != saved_cfg_file
    pop.Open($'Using {g:cfg["file"]}')
    saved_cfg_file = g:cfg.file
  endif

enddef

command -nargs=0 UpdateCfg Update()
