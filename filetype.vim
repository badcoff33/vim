" my filetype file
if exists("did_load_filetypes")
  finish
endif

" Description: ReStructuredText or Markdown? use ':setlocal filetype=' instead
" of ':setfiletype ' to overrule previous detected filetypes. Read this ':h
" ftdetect' for more details
function! s:WhoAreYouTxt()
  let cnt_cmake = 0
  let cnt_markdown = 0
  let cnt_rst = 0
  for linenr in range(1,5)
    if getline(linenr) =~? '.*\(set(\|if(\|CMAKE\|include_\|add_\).*'
      let cnt_cmake += 1
    endif
    if getline(linenr) =~ '^#\+\ \w\+'
      let cnt_markdown += 1
    endif
    if getline(linenr) =~ '^[#*=]\{3,\}$'
      let cnt_rst += 1
    endif
  endfor
  " Three counters. Who wins?
  if cnt_cmake > 0  " CMake has highest prio with unique patterns
    setf cmake
  elseif cnt_rst > 0 " Markdownseldom uses multiple seperators in a row
    setf rst
  else
    setf markdown " Take the rest
  endif
endfunction


augroup filetypedetect
  autocmd BufNewFile,BufRead *.txt :call <SID>WhoAreYouTxt()
  autocmd BufEnter *.850 :setfiletype asm_rh850
  autocmd BufEnter *.800 :setfiletype asm_rh850
  autocmd BufNewFile,BufRead *.org setfiletype org
augroup END

