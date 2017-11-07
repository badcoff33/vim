" Vim syntax file
"
" Language: Asciidoc
" Description: Additional highlighting for DONE
" Read this documentation how this is done :help mysyntaxfile-add

"syn keyword asciidocDone DONE

""" syn region asciidocLiteralParagraph start=/\(\%^\|\_^\s*\n\)\@<=\s\+\S\+/ end=/\(^\(+\|--\)\?\s*$\)\@=/ contains=asciidocDone
"""
""" syn region asciidocLiteralBlock start=/^\.\{4,}$/ end=/^\.\{4,}$/ contains=asciidocDone keepend
""" syn region asciidocListingBlock start=/^-\{4,}$/ end=/^-\{4,}$/ contains=asciidocDone keepend
"""
""" syn region asciidocCommentBlock start="^/\{4,}$" end="^/\{4,}$" contains=asciidocDone
"""
""" syn match asciidocCommentLine "^//\([^/].*\|\)$" contains=asciidocDone
"""
""" syn region asciidocList start=/^\s*\(-\|\*\{1,5}\)\s/ start=/^\s*\(\(\d\+\.\)\|\.\{1,5}\|\(\a\.\)\|\([ivxIVX]\+)\)\)\s\+/ start=/.\+\(:\{2,4}\|;;\)$/ end=/\(^[=*]\{4,}$\)\@=/ end=/\(^\(+\|--\)\?\s*$\)\@=/ contains=asciidocDone

"hi def link asciidocDone Todo
