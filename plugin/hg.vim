command! -complete=file -nargs=+ Hg call run#Run(#{cmd: 'hg <args> -v', as_buffer: v:true})

nnoremap <A-x>vs :call run#Run(#{cmd: 'hg status', as_buffer: v:true})<CR>
nnoremap <A-x>vl :call run#Run(#{cmd: 'hg log -r "tip~3:tip"', as_buffer: v:true})<CR>
nnoremap <A-x>vL :call run#Run(#{cmd: 'hg compact"', as_buffer: v:true})<CR>
imap <A-x> <Esc><A-x>

