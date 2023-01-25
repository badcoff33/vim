vim9script

# Description: Sets a buffer local variable with unique part for buffers with
# the same base name.
export def GetUniqueName()
    var buf_listed = getbufinfo({"listed": 1})
    var buf_numbers = []
    var diff_str = ""

    for e in buf_listed
         add(buf_numbers, e.bufnr)
    endfor

    for b in buf_numbers
        setbufvar(b, "unique_name_prefix", "")
        for b_ in buf_numbers
            diff_str = FindUniqueNamePart(bufname(b), bufname(b_))
            if len(diff_str) > 0 && getbufvar(b, "unique_name_prefix") == ""
                setbufvar(b, "unique_name_prefix", diff_str .. ":")
            endif
        endfor
    endfor
enddef

# Description: Find the differences in buffers path name and return the
# resulting string for the first parameter file_a.
def FindUniqueNamePart(file_a: string, file_b: string): string
    var paths_a: list<string>
    var paths_b: list<string>

    if file_a == file_b
        return ""
    elseif fnamemodify(file_a, ":p:t") != fnamemodify(file_b, ":p:t")
        return ""
    else
        paths_a = split(substitute(fnamemodify(file_a, ":p:h"), '\', '/', 'g'), '/')
        paths_b = split(substitute(fnamemodify(file_b, ":p:h"), '\', '/', 'g'), '/')

        while !empty(paths_a) && !empty(paths_b)
            # check list index 0 of directory lists A/B
            if (paths_a[0] != paths_b[0]) || (len(paths_a) == 1)
                return paths_a[0]
            endif
            # throwaway the tested directory items A/B for next iteration
            paths_a = paths_a[1 : ]
            paths_b = paths_b[1 : ]
        endwhile
        return paths_a[0]
    endif
enddef

# --- testing
v:errors = []

assert_equal("vimfiles", FindUniqueNamePart("~/vimfiles/colors/twotone.vim", "~/AppData/Roaming/nvim/colors/twotone.vim"))

 assert_equal("", FindUniqueNamePart("aaa/bbb/ccc/111.txt", "aaa/bbb/ccc/222.txt"))
 assert_equal("", FindUniqueNamePart("aaa/bbb/ccc/111.txt", "aaa/bbb/ccc/111.txt"))

 assert_equal("ccc", FindUniqueNamePart("aaa/b2/ccc/111.txt", "aaa/b2/c3/111.txt"))
 assert_equal("c3", FindUniqueNamePart("aaa/b2/c3/111.txt", "aaa/b2/ccc/111.txt"))
 assert_equal("bb", FindUniqueNamePart("aaa/bb/c3/111.txt", "aaa/bbb/ccc/111.txt"))

# --- varying path length
 assert_equal("bb", FindUniqueNamePart("aaa/bb/111.txt", "aaa/bb/ccc/111.txt"))
 assert_equal("c3", FindUniqueNamePart("aaa/bb/c3/111.txt", "aaa/bb/111.txt"))
 assert_equal('sources', FindUniqueNamePart('\Daten\play\Software\sources\LowLevel\Mcu_Rram_startup_F1KM.850', '\Daten\play\Software\cmake\_3P\src\ghs\Mcu_Rram_startup_F1KM.850'))
 assert_equal('cmake', FindUniqueNamePart('\Daten\play\Software\cmake\_3P\src\ghs\Mcu_Rram_startup_F1KM.850', '\Daten\play\Software\sources\LowLevel\Mcu_Rram_startup_F1KM.850'))

# --- case sensitive
if has('unix')
     assert_equal("CCC", FindUniqueNamePart("aaa/bbb/CCC/111.txt", "aaa/bbb/ccc/111.txt"))
     assert_equal("ccc", FindUniqueNamePart("aaa/bbb/ccc/111.txt", "aaa/bbb/CCC/111.txt"))
endif

# Show assert results
for e in v:errors
    echo e
endfor

defcompile

