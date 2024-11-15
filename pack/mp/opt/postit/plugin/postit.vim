vim9script

import autoload "popnews.vim"

var post_it_dict = {}

highlight! link PostIt ModeMsg
if prop_type_get('text_prop_postit') == {}
  prop_type_add('text_prop_postit', {
    highlight: 'PostIt'
  })
endif

def PinText(t: string)
  var cfile = expand('%')
  var cline = line('.')
  var ccol = col('.')

  post_it_dict[cfile] = {}
  post_it_dict[cfile].line = cline
  post_it_dict[cfile].col = ccol
  post_it_dict[cfile].text = t

  prop_add(cline, 0, {
    bufnr: bufnr('%'),
    type: "text_prop_postit",
    text: t,
    text_align: 'below',
    text_padding_left: ccol
  })
enddef

def PostIt(arg_text: string = "")
  if len(arg_text) > 0
    PinText(arg_text)
    return
  endif
  var text: string
  var prompt: string
  prompt = "POSTIT "
  while true
    text = input("Post it (press <CR> only to leave): ")
    if text == ""
      break
    endif
    PinText(prompt .. text)
    prompt = substitute(prompt, ".", " ", "g")
  endwhile
enddef

export def PostItRemove()
    prop_clear(line("."))
enddef

command! -nargs=* PostIt PostIt(<q-args>)
command! -nargs=0 PostItRemove PostItRemove()

defcompile

