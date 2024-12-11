vim9script

export def TruncateString(str: string, max_len: number): string
    if len(str) >  max_len
        return str[ : max_len - 1 ] .. ".."
    else
        return str
    endif
enddef

export def TruncateList(lst: list<string>, max_len: number): list<string>
    var out = []
    for m in lst
       add(out, TruncateString(m, max_len))
    endfor
    return out
enddef

export def ToString(obj: any): string
  var toStr: string
  if type(obj) == v:t_string
    return obj
  elseif type(obj) == v:t_number
    return string(obj)
  elseif type(obj) == v:t_list
    return join(obj, " ")
  else
    assert_report("unknown type for ToString()")
    return ""
  endif
enddef

export def ToList(fromString: string): list<string>
  var toList: list<string>
  for p in split(fromString, ' ')
    add(toList, p)
  endfor
  return toList
enddef
defcompile
