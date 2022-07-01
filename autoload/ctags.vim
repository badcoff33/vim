vim9script
# File type plugin for C
#
# Description: Some support functions and mappings for C code files.
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

g:ctags_types = []
g:ctags_functions = []

# Description: Scan trough current TAG file, find the function symbols and
# highlight them as keyword when called with parameter "functions". When called
# with parameter "types", highlight C types. Well, 'both' says it all :)
#echo match('ApplXcpCalculateChecksum XcpBasicDrv/_xcp_appl.c /^vuint8 ApplXcpCalculateChecksum( ROMBYTEPTR pMemArea, BYTEPTR pRes, vuint32 length )$/;"  f typeref:typename:vuint8','^\(\w\+\).*\(\<f\>\|\<t\>\).*$')
export def HighlightTags(what: string)
  var run_add_func = (what == 'functions') || (what == 'both')
  var run_add_type = (what == 'types') || (what == 'both')
  var ctags_sym = ""
  var ctags_type = ""
  try
    syntax clear ctagsFunction
    syntax clear ctagsType
  catch /*./
  endtry
  for tagsfile in tagfiles()
    for line in readfile(tagsfile)
      try
        [ctags_sym, ctags_type] = split(substitute(line, '^\(\w\+\).*\(\<f\>\|\<t\>\).*$', '\1 \2', 'g'), ' ')
      catch /.*/
        # no match found on parsed line
        [ctags_sym, ctags_type] = [ "", "" ]
      endtry
      if (ctags_type == 'f') && run_add_func
        add(g:ctags_functions, ctags_sym)
        #execute "syntax keyword ctagsFunction" ctags_sym
      endif
      if (ctags_type == 't') && run_add_type
        add(g:ctags_types, ctags_sym)
        #execute "syntax keyword ctagsType"  ctags_type
      endif
    endfor
  endfor
  uniq(g:ctags_types)
  uniq(g:ctags_functions)
  highlight def link ctagsFunction Function
  highlight def link ctagsType Type
enddef

export def RunUpdate(tid: number)
  BuildCtags
enddef

export def Update()
  if exists(":BuildCtags") == 2
    timer_start(1000, "ctags#RunUpdate", {'repeat': 1})
  endif
enddef
