" Vim compiler file
" Compiler:   Pandoc
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" Description: Convert makrdown file to HTML5 file.
" Use it like this :make <out_file> <markdown_file>.

set makeprg=pandoc\ -r\ gfm\ -t\ html5\ -o\ %<.html\ $*
