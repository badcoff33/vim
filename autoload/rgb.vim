vim9script

def ChangeColor()
  var rgb = expand("<cword>")
  if len(rgb) == 7 && match(rgb, '#[0-9A-Fa-f]\{6\}') == 0
    execute $"highlight ColorBg24 guifg=black guibg={rgb}"
    execute $"highlight ColorFg24 guifg={rgb} guibg=black"
    prop_type_delete("text_prop_show_color_bg")
    prop_type_delete("text_prop_show_color_fg")
    prop_type_add('text_prop_show_color_bg', { highlight: 'ColorBg24' })
    prop_type_add('text_prop_show_color_fg', { highlight: 'ColorFg24' })
    prop_add(line('.'), 0, {
      bufnr: bufnr(),
      type: "text_prop_show_color_bg",
      text: "AAaa0011",
      text_align: 'after',
      text_padding_left: 3
    })
    prop_add(line('.'), 0, {
      bufnr: bufnr(),
      type: "text_prop_show_color_fg",
      text: "AAaa0011",
      text_align: 'after',
      text_padding_left: 0
    })
  endif
enddef

# Description: Change background of 24bit hex-coded color under cursor,
# Example: #445566
export def UnderCursor()
  var cmd_ins_leave = {
    bufnr: bufnr('%'),
    cmd: 'ChangeColor()',
    event: 'InsertLeave'
  }
  var cmd_cur_hold = {
    bufnr: bufnr('%'),
    cmd: 'ChangeColor()',
    event: 'CursorHold'
  }
  if exists("#InsertLeave<buffer>")
    autocmd_delete([cmd_ins_leave])
    prop_type_delete("text_prop_show_color_bg")
    prop_type_delete("text_prop_show_color_fg")
  else
    autocmd_add([cmd_ins_leave])
  endif
  if exists("#CursorHold#<buffer>")
    prop_type_delete("text_prop_show_color_bg")
    prop_type_delete("text_prop_show_color_fg")
    autocmd_delete([cmd_cur_hold])
  else
    autocmd_add([cmd_cur_hold])
  endif
enddef

