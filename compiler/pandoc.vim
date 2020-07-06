" Vim compiler file
" Compiler:   Pandoc
" Maintainer: Markus Prepens (markus.prepens@gmail.com)
"
" Description: Convert makrdown file to HTML5 file.
" Use it like this :make <out_file> <markdown_file>.

set makeprg=pandoc\ -f\ gfm\ -t\ html5\ -o\ \%TEMP\%\\preview.html\ $*
" set makeprg=pandoc\ -f\ gfm\ -t\ html5\ -o\ %<.html\ $*
"set makeprg=pandoc\ -f\ gfm\ -t\ docx\ -o\ %<.docx\ $*
