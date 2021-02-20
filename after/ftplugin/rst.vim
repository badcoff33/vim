" reStructuredText filetype plugin file

if exists("b:did_ftplugin_after")
  finish
endif

setlocal textwidth=78
setlocal shiftwidth=4
setlocal nocindent
" Make heading underlined
nnoremap <buffer> <LocalLeader>h0 0v$beyo<Esc>PVr=
nnoremap <buffer> <LocalLeader>h1 0v$beyo<Esc>PVr-

nnoremap <buffer> <LocalLeader>d i<C-r>=strftime("%Y-%m-%d")<CR><Esc>

let b:did_ftplugin_after = 1
