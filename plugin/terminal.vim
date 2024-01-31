vim9script

import autoload "utils.vim"

def g:NewTermHere()
  var save_cwd = getcwd()

  execute "noautocmd cd" expand("%:h")
  terminal
  wincmd J
  startinsert
  execute "noautocmd cd" save_cwd
enddef

def g:PopupTermHere()
  var buf = term_start(['cmd'], {
    hidden: 1,
    term_finish: 'close',
    cwd: expand("%:h") == "" ? "." : expand("%:h")
  })
  var winopts = {
    minwidth: &columns - 10,
    minheight: 10,
    maxheight: &lines - 10,
    border: [0, 0, 0, 0],
    padding: [1, 1, 1, 1],
    highlight: "StatusLine",
    title: "cmd"
  }
  g:popup_terminal_winid = popup_create(buf, winopts)
  autocmd VimResized <buffer> popup_move(g:popup_terminal_winid, winopts)
enddef

def g:Execute(opt_cmd = "")
  var term_bufnrs = term_list()
  if len(term_bufnrs) == 0
    g:NewTermHere()
    term_bufnrs = term_list()
  endif
  var winnr = bufwinnr(term_bufnrs[0])
  if winnr >= 1
    execute ":" .. string(winnr) .. "wincmd w"
  else
    wincmd s
    wincmd J
    execute "buffer" term_bufnrs[0]
  endif
  feedkeys(((mode() == "n") ? "i" : "") .. opt_cmd .. "\<CR>")
enddef

augroup GroupTerminal
  au!
  au TerminalOpen * setlocal signcolumn=no
  au TerminalOpen * setlocal nonumber
  au TerminalOpen * setlocal norelativenumber
  au TerminalOpen * setlocal foldcolumn=0
  au TerminalOpen * tnoremap <buffer> <silent> <CR>   <C-w>:execute "let b:line =" line("$")<CR><CR>
  au TerminalOpen * tnoremap <buffer> <silent> <C-CR> <C-w>:execute b:line .. ",$ write! $TEMP/term.log"<CR><C-w>:cfile $TEMP/term.log<CR>
  au TerminalOpen * nnoremap <buffer> <silent> <C-CR>      :execute b:line .. ",$ write! $TEMP/term.log"<CR><C-w>:cfile $TEMP/term.log<CR>
augroup END

utils.Map('nnoremap', '<Leader>T', ':PopupTermHere<CR>')
utils.Map('nnoremap', '<Leader>X', ':call g:Execute(input("command: "))<CR>')

command! -nargs=* Execute  g:Execute('<args>')
command! -nargs=0 PopupTermHere  g:PopupTermHere()

defcompile
