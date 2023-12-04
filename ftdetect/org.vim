autocmd BufEnter *.txt if getline(1) =~ '^\*\+\s' | setfiletype org | else | setfiletype text | endif


