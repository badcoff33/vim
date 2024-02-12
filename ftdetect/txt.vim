" ReStructuredText or Markdown?
" " use ':setlocal filetype=' instead of ':setfiletype ' to overrule previous detected filetypes.
" Read this ':h ftdetect' for more details
autocmd BufNewFile,BufRead *.txt :exe 'setlocal ft=' .. ((getline(1) =~ '^[#*=]\{3,\}') ? 'rst' : 'markdown')
