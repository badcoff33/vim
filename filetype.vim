" my filetype file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " ReStructuredText or Markdown?
  " " use ':setlocal filetype=' instead of ':setfiletype ' to overrule previous detected filetypes.
  " Read this ':h ftdetect' for more details
  autocmd BufNewFile,BufRead *.txt :exe 'setfiletype ' .. ((getline(1) =~ '^[#*=]\{3,\}') ? 'rst' : 'markdown')
  autocmd BufEnter *.850 :setfiletype asm850
  autocmd BufEnter *.800 :setfiletype asm850
augroup END
