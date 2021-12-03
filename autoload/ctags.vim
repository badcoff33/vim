" File type plugin for C
"
" Description: Some support functions and mappings for C code files.
" Maintainer: markus prepens (markus dot prepens at gmail dot com)

" Description: Scan trough current TAG file, find the function symbols and
" highlight them as keyword when called with parameter "functions". When called
" with parameter "types", highlight C types. Well, 'both' says it all :)
function! ctags#HighlightTags(what)
  let ctags_sym = ""
  let ctags_type = ""
  let run_add_func = (a:what == 'functions') || (a:what == 'both')
  let run_add_type = (a:what == 'types') || (a:what == 'both')
  syntax clear ctagsFunction
  syntax clear ctagsType

  for tagsfile in tagfiles()
    for line in readfile(tagsfile)
      try
        let [ctags_sym, ctags_type] = split(substitute(line, '^\(\w\+\).*\(\<f\>\|\<t\>\).*$', '\1 \2', 'g'), ' ')
      catch /.*/
        " no match found on parsed line
        let [ctags_sym, ctags_type] = [ "", "" ]
      endtry
      if (ctags_type == 'f') && run_add_func
        execute "syntax keyword ctagsFunction" ctags_sym
      endif
      if (ctags_type == 't') && run_add_type
        execute "syntax keyword ctagsType"  ctags_type
      endif
    endfor
  endfor

  highlight def link ctagsFunction Function
  highlight def link ctagsType Type
endfunction

" Description: Callback function run by cyclic timer.
function! ctags#UpdaterCallback(tid)
  if exists(':Update') && exists('g:updater_timer_id') && (a:tid == g:updater_timer_id)
    if g:updater_run_it != 0
      Update
      g:updater_run_it = 0
    endif
  endif
endfunction

