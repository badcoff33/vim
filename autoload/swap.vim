vim9script



def FileOptions(parts: list<string>): list<string>
  var file_options: list<string>
  var sep = expand('/')
  var file = expand("%")
  var head = fnamemodify(file, ":h")
  var tail_no_ext = fnamemodify(file, ":t:r")
  var extension = fnamemodify(file, ":e") == "c" ? "h" : "c"
  for part in parts
    add(file_options, head .. sep .. part .. tail_no_ext .. "." .. extension)
  endfor
  return file_options
enddef


export def OtherFileC()
  var extension = expand("%:e")
  for f in FileOptions(['', '../src/', '../inc/', '../include/'])
    if filereadable(f)
      execute "edit" f
      return
    endif
  endfor
  echomsg "- not supported -"
enddef

defcompile
