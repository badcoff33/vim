" Vim compiler file
" Compiler:   Pandoc
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" Description: Convert makrdown file to HTML5 file.
" Use it like this :make <out_file> <markdown_file>.

setlocal makeprg=plantuml\ -f\ markdown\ -t\ html5\ -o
