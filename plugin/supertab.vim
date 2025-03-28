vim9script
# Vim plugin file

import "utils.vim"

def CompleteAllowed(): bool
  var chars = utils.NeighborChars()
  if (chars.rearview == '')
    return false
  elseif (chars.rearview !~ '[ \t]') && ((chars.frontview =~ '\([^a-zA-Z0-9_]\)') || (chars.frontview == ''))
    return true
  else
    return false
  endif
enddef

def CondInsertComplete(): string
  if pumvisible() != 0
    return "\<C-n>"
  elseif (CompleteAllowed() == true)
      return "\<C-n>"
  else
    return nr2char(&wildchar)
  endif
enddef

def CondCommandLineComplete(): string
  if pumvisible()
    return "\<Right>"
  elseif getcmdpos() > len(getcmdline())
    return nr2char(&wildchar)
  else
    return "\<Right>"
  endif
enddef

inoremap <expr> <TAB> CondInsertComplete()
inoremap <expr> <S-TAB> "\<C-p>"
cnoremap <expr> <Right> CondCommandLineComplete()

