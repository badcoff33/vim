" my filetype file
if exists("did_load_filetypes")
  finish
endif

" Description: ReStructuredText or Markdown? use ':setlocal filetype=' instead
" of ':setfiletype ' to overrule previous detected filetypes. Read this ':h
" ftdetect' for more details
function! s:WhoAreYouTxt()
  for linenr in range(1,5)
    if getline(linenr) =~ '^#\+\ \w\+'
      setfiletype markdown
      return
    endif
    if getline(linenr) =~ '^[#*=]\{3,\}$'
      setfiletype rst
      return
    endif
  endfor
endfunction


augroup filetypedetect
  autocmd BufNewFile,BufRead *.txt :call <SID>WhoAreYouTxt()
  autocmd BufEnter *.850 :setfiletype asm850
  autocmd BufEnter *.800 :setfiletype asm850
augroup END
