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


