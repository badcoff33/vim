vim9script
# File type plugin for C
#
# Description: Some support functions and mappings for C code files.
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

# Description: Scan trough current TAG file, find the function symbols and
# highlight them as keyword when called with parameter "functions". When called
# with parameter "types", highlight C types. Well, 'both' says it all :)
def ctags#HighlightTags(what: string)
  for tagsfile in tagfiles()
    for line in readfile(tagsfile)
      if (what == 'functions') || (what == 'both')
        if match(line, '\<f\>') > 0
          execute "syntax keyword ctagsFunction" matchstr(line, '^\w\+')
        endif
      endif
      if (what == 'types') || (what == 'both')
        if match(line, '\<t\>') > 0
          execute "syntax keyword ctagsType" matchstr(line, '^\w\+')
        endif
      endif
    endfor
  endfor
  highlight def link ctagsFunction Function
  highlight def link ctagsType Type
enddef

# Description: Callback function run by cyclic timer.
def ctags#UpdaterCallback(tid: number)
  if exists(':Update') && exists('g:updater_timer_id') && (tid == g:updater_timer_id)
    if g:updater_run_it != 0
      Update
      g:updater_run_it = 0
    endif
  endif
enddef

