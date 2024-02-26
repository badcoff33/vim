" my filetype file
if exists("did_load_filetypes")
  finish
endif

let IsMd = { line1 -> (line1 =~ '^#\+\ \w\+') ? v:true : v:false }
let IsRst = { line1 -> (line1 =~ '^[#*=]\{3,\}$') ? v:true : v:false }

augroup filetypedetect
  " ReStructuredText or Markdown?
  " " use ':setlocal filetype=' instead of ':setfiletype ' to overrule previous detected filetypes.
  " Read this ':h ftdetect' for more details
  autocmd BufNewFile,BufRead *.txt :exe 'setfiletype ' .. (IsMd ? 'markdown' : (IsRst ? 'rst' : 'txt'))
  autocmd BufEnter *.850 :setfiletype asm850
  autocmd BufEnter *.800 :setfiletype asm850
augroup END
