" Vim syntax file
" Language: C
" Description: Additional C highlighting
" Read this documentation how this is done :help mysyntaxfile-add

syntax match cType "\<\(\w\+_t\)\>"
syntax match cType "\<\(\w\+Type\)\>"

syntax keyword cType boolean
syntax keyword cType uint8 uint16 uint32
syntax keyword cType sint8 sint16 sint32

