" Vim compiler file
" Compiler:		Pandoc for markdown
" Maintainer:	Markus Prepens (prepensm@yahoo.de)
" Last Change: 2019-10-09	

set makeprg=pandoc\ -f\ markdown\ -t\ html5  
set errorformat=%f:%l:\ %m
