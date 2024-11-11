" Vim syntax file
" Language: Git logs
" Maintainer: Markus Prepens

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

syn match VcsGitOutputRef  "[a-f0-9]\{40,}"
syn match VcsGitOutputTime "\d\d:\d\d:\d\d"
syn match VcsGitOutputStage "^Changes \(to be committed\|not staged for commit\):"
syn match VcsGitOutputBranch "^On branch \w\+"
syn match VcsGitOutputString "'.*\'"
syn match VcsGitOutputInfo "(.*)"

syn match VcsHggLogAttrib "^\(changeset\|user\|date\|summary\):"
syn match VcsHgReference "\d\+:\w\+"
syn match VcsHgTime      "\d\d:\d\d:\d\d"
syn match VcsHgFileState "^\(R\|M\|A\)\s"
hi def link VcsHgLogAttrib Keyword
hi def link VcsHgReference Type
hi def link VcsHgTime Comment
hi def link VcsHgFileState Title

hi def link VcsGitOutputStage Keyword
hi def link VcsGitOutputTime Comment
hi def link VcsGitOutputInfo Comment
hi def link VcsGitOutputRef Comment
hi def link VcsGitOutputBranch Title
hi def link VcsGitOutputString Title

let b:current_syntax = "vcs_output"

