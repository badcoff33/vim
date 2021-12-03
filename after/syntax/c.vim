" Vim syntax file
" Language: C
" Description: Additional C highlighting
" Read this documentation how this is done :help mysyntaxfile-add

syntax match cType "\<\(\w\+_t\)\>"
syntax match cType "\<\(\w\+Type\)\>"

syntax keyword cType boolean
syntax keyword cType uint8 uint16 uint32
syntax keyword cType sint8 sint16 sint32

if exists('g:ctags_functions')
  for sym in g:ctags_functions
    execute "syntax keyword ctagsFunction" sym
  endfor
  if !empty(g:ctags_functions)
    highlight def link ctagsFunction Function
  endif
endif

if exists('g:ctags_functions')
  for sym in g:ctags_types
    execute "syntax keyword ctagsType"  sym
  endfor
  if !empty(g:ctags_types)
    highlight def link ctagsType Type
  endif
endif

