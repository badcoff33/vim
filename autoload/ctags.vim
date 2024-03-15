vim9script
# autoload file
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

export def TagCycle(direction: string)
  var tl = taglist('.')
  if !exists('b:tag_number')
    # Initialize
    b:max_tag_number = len(tl) - 1
    if direction == 'n'
      b:tag_number = 0
    else
      b:tag_number = b:max_tag_number
    endif
  else
    if direction == 'n'
      # Count up
      b:tag_number += 1
      if b:tag_number > b:max_tag_number
        b:tag_number = 0
      endif
    elseif direction == 'p'
      # or count down
      b:tag_number -= 1
      if b:tag_number < 0
        b:tag_number = b:max_tag_number
      endif
    endif
  endif
  # Jump to tag
  var n = b:tag_number
  b:tag_name = tl[n]['name']
  var name = b:tag_name
  echo ':tag ' .. b:tag_name
  legacy execute 'tag ' .. b:tag_name
enddef

# re-compile when debugging
defcompile
