" Vim compiler file
" Compiler:   Greenhills - Compiler
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
" Last Change:  2006 May 30
"
" Description: Use build.cmd to re-route STDERR to STDOUT. The script includes
" the gbuild call as this one: `gbuild %* 2>&1`

set makeprg=build
set errorformat=\"%f\"\\,\ line\ %l:\ %m
