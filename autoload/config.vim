vim9script

import "utils.vim"

g:config_vars = []

def CbSelect(id: any, result: any)
  var input_string: string
  var gvar_name = g:config_vars[result - 1]
  var gvar_val = get(g:, gvar_name[2 : ], [])
  var prompt = $'Edit "{gvar_name}": '
  var val_str = input(prompt, utils.ToString(gvar_val))
  execute gvar_name .. " = []"
  for str in utils.ToList(val_str)
    execute "add(" .. gvar_name .. ", '" .. trim(str) .. "')"
  endfor
enddef

export def Edit()
  var items_ordered = mapnew(
    g:config_vars,
    (_, val) => val .. " = " .. utils.ToString(eval(val))
  )
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
    callback: 'CbSelect',
  })
enddef

export def RegisterVariable(new: string)
  if match(g:config_vars, new) < 0
    add(g:config_vars, new)
  endif
  if exists(":Configure") == 0
    command -nargs=0 Configure call config#Edit()
  endif
enddef

defcompile

