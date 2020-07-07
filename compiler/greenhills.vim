" Vim compiler file
" Compiler:   Greenhills - Compiler
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" Description: Use build.cmd to re-route STDERR to STDOUT. The script includes
" the gbuild call as this one: `gbuild %* 2>&1`

set makeprg=make

" multiline
set errorformat=%W\"%f\"\\,\ line\ %l:\ %t%*[^0-9]%n-%m,%Z%m
set errorformat+=%E\"%f\"\\,\ line\ %l:\ %t%*[^0-9]%n-%m,%Z%m

" singleline
" set errorformat+=\"%f\"\\,\ line\ %l:\ %m
