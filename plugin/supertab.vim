vim9script
# Vim plugin file

inoremap <expr> <TAB> InsertTabOrComplete()
inoremap <expr> <S-TAB> "\<C-p>"

def InsertTabOrComplete(): string
  if pumvisible() != 0
    return "\<C-n>"
  elseif (CompleteAllowed() == true)
      return "\<C-n>"
  else
    return "\<TAB>"
  endif
enddef

# Description: Returns forward and backward chars at cursor position.
# At lines end or start of line, a blank dictionary entry is returned.
def NeighborChars(): dict<string>
  var d = {}
  var col = col('.') - 1
  var line = getline('.')
  var length = len(line)
  d['rearview'] = (col == 0) ? '' : line[col - 1]
  d['frontview']  = (col == length) ? '' : line[col]
  return d
enddef

def CompleteAllowed(): bool
  var chars = s:NeighborChars()
  if (chars.rearview == '')
    return false
  elseif (chars.rearview !~ '[ \t]') && ((chars.frontview =~ '\([^a-zA-Z0-9_]\)') || (chars.frontview == ''))
    return true
  else
    return false
  endif
enddef
