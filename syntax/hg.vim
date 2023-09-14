" Vim syntax file
" Language: Hg logs
" Maintainer:   Markus Prepens

if exists("b:current_syntax")
  finish
endif

scriptencoding utf-8

syn case match
syn sync minlines=50
syn sync linebreaks=1

if has("spell")
  syn spell toplevel
endif

syn match hgLogAttrib    "^\(changeset\|user\|date\|summary\):"
syn match hgReference "\d\+:\w\+"
syn match hgTime "\d\d:\d\d:\d\d"

hi def link hgLogAttrib Keyword
hi def link hgReference Type
hi def link hgTime Comment

let b:current_syntax = "hglog"
