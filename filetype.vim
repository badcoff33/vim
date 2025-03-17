" my filetype file
if exists("did_load_filetypes")
  finish
endif

" Description: ReStructuredText or Markdown? use ':setlocal filetype=' instead
" of ':setfiletype ' to overrule previous detected filetypes. Read this ':h
" ftdetect' for more details
function! s:WhichFile_Txt()
  let l:lines_to_scan = 10

  for linenr in range(1, l:lines_to_scan)
    if getline(linenr) =~? '.*\(cmake_minimum_required\|set(\|if(\|CMAKE\|include_\|add_\).*'
      setf cmake
      return
    endif
  endfor

  for linenr in range(1, l:lines_to_scan)
    if getline(linenr) =~ '^#\+\ \w\+'
      setf markdown
      return
    endif
  endfor

  for linenr in range(1, l:lines_to_scan)
    if getline(linenr) =~ '^[#*=]\{3,\}$'
      setf rst
      return
    endif
  endfor

endfunction


augroup filetypedetect
  autocmd BufNewFile,BufRead *.txt :call <SID>WhichFile_Txt()
  autocmd BufEnter *.850 :setfiletype asm_rh850
  autocmd BufNewFile,BufRead *.org setfiletype org
augroup END
