" Vim compiler file
" Compiler:   Markdown
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" Description: Convert makrdown file to HTML file.
" Use it like this :make <out_file> 

set makeprg=markdown\ $*\ >\ %<.html
