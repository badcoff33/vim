" Vim compiler file
" Compiler:   Greenhills - Compiler
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" Description: Use build.cmd to re-route STDERR to STDOUT. The script includes
" the gbuild call as this one: `gbuild %* 2>&1`
"
" Example: A Greenhills Warning
" "/AA/BB/CC/main.c", line 696: warning #550-D:
"           variable "dummy" was set but never used
"       uint32 dummy=0x0;
"              ^
"

set makeprg=make

" multi-line
set errorformat=%W\"%f\"\\,\ line\ %l:\ %tarning\ #%n-%m,%Z%m
set errorformat+=%E\"%f\"\\,\ line\ %l:\ %trror\ #%n-%m,%Z%m

" single-line
set errorformat+=\"%f\"\\,\ line\ %l:\ %m
