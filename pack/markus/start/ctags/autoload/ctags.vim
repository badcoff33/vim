" File type plugin for C
"
" Description: Some support functions and mappings for C code files.
" Maintainer: markus prepens (markus dot prepens at gmail dot com)

let g:ctags_functions = []
let g:ctags_types = []

" Description: Scan trough current TAG file, find the function symbols and
" highlight them as keyword when called with parameter "functions". When called
" with parameter "types", highlight C types. Well, 'both' says it all :)
function! ctags#HighlightTags(what)
  let sym_name = ""
  let sym_type = ""
  let run_add_func = (a:what == 'functions') || (a:what == 'both')
  let run_add_type = (a:what == 'types') || (a:what == 'both')
  let g:ctags_functions = []
  let g:ctags_types = []
  for tagsfile in tagfiles()
    for line in readfile(tagsfile)
      try
        let [sym_name, sym_type] = split(substitute(line, '^\(\w\+\).*\(\<f\>\|\<t\>\).*$', '\1 \2', 'g'), ' ')
      catch /.*/
        " no match found on parsed line
        let [sym_name, sym_type] = [ "", "" ]
      endtry
      if (sym_type == 'f') && run_add_func
        call add(g:ctags_functions, sym_name)
      endif
      if (sym_type == 't') && run_add_type
        call add(g:ctags_types, sym_name)
      endif
    endfor
  endfor

endfunction

" Description: Callback function run by a one-shot timer.
function! ctags#ExecuteCtags(tid)
  if exists(':CtagsCommand') && exists('g:ctags_timer_id') && (a:tid == g:ctags_timer_id)
    CtagsCommand
  endif
endfunction

