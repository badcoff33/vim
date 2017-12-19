" Vim syntax file
" Language: C
" Description: Additional C highlighting
" Read this documentation how this is done :help mysyntaxfile-add

" if g:syntax_custom_c_types exists, types for my daily work gets highlighted
if exists("g:syntax_custom_c_types")

  syntax match cType "\<\(\w\+_t\)\>"
  syntax match cType "\<\(\w\+Type\)\>"

  syntax keyword cType boolean
  syntax keyword cType uint8 uint16 uint32
  syntax keyword cType sint8 sint16 sint32

endif
