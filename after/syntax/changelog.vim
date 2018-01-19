" Vim syntax file
" Language: changelog
" Description: Additional highlighting
" Read this documentation how this is done :help mysyntaxfile-add

syntax keyword Todo TODO contained
syntax match   changelogFiles ".*"  contains=Todo
