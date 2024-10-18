" Vim syntax file
" Language: Git logs
" Maintainer: Markus Prepens

"if exists("b:current_syntax")
"  finish
"endif

scriptencoding utf-8

syn case match
syn sync minlines=50
syn sync linebreaks=1

if has("spell")
  syn spell toplevel
endif

"syn match hgLogAttrib    "^\(\|user\|date\|summary\):"
"syn match hgReference "\d\+:\w\+"
syn match gitStatusTime "\d\d:\d\d:\d\d"
syn match gitStatusStage "^Changes \(to be committed\|not staged for commit\):"
syn match gitStatusBranch "^On branch \w\+"
syn match gitStatusString "'.*\'"

hi def link gitStatusStage Keyword
hi def link gitStatusTime Comment
hi def link gitStatusBranch Title
hi def link gitStatusString Title

let b:current_syntax = "gitlog"

