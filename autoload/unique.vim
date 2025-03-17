vim9script

# Description: Sets a buffer local variable with unique part for buffers with
# the same base name.
export def GetUniqueName()
  var buf_listed = getbufinfo({"bufloaded": 1})
  var buf_numbers = []
  var unique_name = ""

  for e in buf_listed
    add(buf_numbers, e.bufnr)
  endfor

  for w in range(1, winnr("$"))
    var bufnr_ref = winbufnr(w)
    setbufvar(bufnr_ref, "unique_name_prefix", "")
    for bufnr_2nd in buf_numbers
      unique_name = Uniquefy(bufname(bufnr_ref), bufname(bufnr_2nd))
      if unique_name != ""
        setbufvar(bufnr_ref, "unique_name_prefix", "<" .. unique_name .. ">")
        break
      endif
    endfor
  endfor

enddef

# Description: Find the differences in buffers path name and return the
# resulting string for the first parameter file_a.
def Uniquefy(file_a: string, file_b: string): string
  var ref: list<string>
  var cmp: list<string>
  var r: list<string>

  if fnamemodify(file_a, ":t")  == fnamemodify(file_b, ":t")

    ref = split(substitute(fnamemodify(file_a, ":h"), '\', '/', 'g'), '/')
    cmp = split(substitute(fnamemodify(file_b, ":h"), '\', '/', 'g'), '/')

    while !empty(ref) && !empty(cmp)
      if (ref[-1] != cmp[-1])
        r = extend([ref[-1]], r)
      endif
      # throwaway the tested directory
      ref = ref[ : -2]
      cmp = cmp[ : -2]
      if len(r) >= 3
        break
      endif
    endwhile

    return len(r) > 0 ? join(r, ":") : ""
  else
    return ""
  endif
enddef

defcompile
# --- testing
v:errors = []

assert_equal("", Uniquefy("aaa/bbb/ccc/111.txt", "aaa/bbb/ccc/222.txt"))
assert_equal("", Uniquefy("aaa/bbb/ccc/111.txt", "aaa/bbb/ccc/111.txt"))

assert_equal("ccc", Uniquefy("aaa/b2/ccc/111.txt", "aaa/b2/c3/111.txt"))
assert_equal("c3", Uniquefy("aaa/b2/c3/111.txt", "aaa/b2/ccc/111.txt"))
assert_equal("bb:c3", Uniquefy("aaa/bb/c3/111.txt", "aaa/bbb/ccc/111.txt"))

assert_equal("~:vimfiles", Uniquefy("~/vimfiles/colors/twotone.vim", "~/AppData/Roaming/nvim/colors/twotone.vim"))

# --- varying path length
assert_equal("aaa:bb", Uniquefy("aaa/bb/111.txt", "aaa/bb/ccc/111.txt"))
assert_equal("bb:c3", Uniquefy("aaa/bb/c3/111.txt", "aaa/bb/111.txt"))
assert_equal('Software:sources:LowLevel', Uniquefy('\Daten\play\Software\sources\LowLevel\Mcu_Rram_startup_F1KM.850', '\Daten\play\Software\cmake\_3P\src\ghs\Mcu_Rram_startup_F1KM.850'))
assert_equal('_3P:src:ghs', Uniquefy('\Daten\play\Software\cmake\_3P\src\ghs\Mcu_Rram_startup_F1KM.850', '\Daten\play\Software\sources\LowLevel\Mcu_Rram_startup_F1KM.850'))

# --- case sensitive
if has('unix')
  assert_equal("CCC", Uniquefy("aaa/bbb/CCC/111.txt", "aaa/bbb/ccc/111.txt"))
  assert_equal("ccc", Uniquefy("aaa/bbb/ccc/111.txt", "aaa/bbb/CCC/111.txt"))
endif

# Show assert results
for e in v:errors
  echo e
endfor
