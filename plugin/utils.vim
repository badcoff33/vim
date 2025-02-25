vim9script

import autoload "quickfix.vim"

g:last_search = ""

def g:SaveLastSearch()
  g:last_search = getreg('/')
enddef

def g:RestoreLastSearch()
  histdel('searcH', -1)
  setreg('/', g:last_search)
enddef

def g:BackwardSlashToForward()
  var save_modifiable: bool
  var save_readonly: bool
  save_modifiable = &modifiable
  save_readonly = &readonly
  setlocal modifiable noreadonly
  s#\\#/#ge
  call histdel("/", -1)
  if save_modifiable == false
    setlocal nomodifiable
  endif
  if save_readonly == true
    setlocal readonly nomodified
  endif
enddef

def g:ForwardSlashToBackward()
  var save_modifiable: bool
  var save_readonly: bool
  save_modifiable = &modifiable
  save_readonly = &readonly
  setlocal modifiable noreadonly
  s#/#\\#ge
  call histdel("/", -1)
  if save_modifiable == false
    setlocal nomodifiable
  endif
  if save_readonly == true
    setlocal readonly nomodified
  endif
enddef

var cwd_stored: string

augroup GroupUtils
  autocmd!
  autocmd TerminalOpen * setlocal scrolloff=0 signcolumn=no nocursorline foldcolumn=0
  autocmd TerminalOpen * setlocal nonumber norelativenumber
  autocmd WinLeave     cmd.exe* wincmd c
  # autocmd WinLeave     * {
  #   if &buftype == 'terminal'
  #     wincmd c
  #   endif
  # }
augroup END " }}}

# Description: Run a diff of current buffer content and file content.
# Taken from Vims help file diff.txt:
def g:ShowUnsavedChanges()
  vert new
  set bt=nofile
  execute "read ++edit" bufname('#')
  normal "0d_"
  diffthis
  wincmd p
  diffthis
enddef

def g:RunTerminal()
  var term_tbufnrs = term_list()
  var tbufnr = 0
  for b in term_list()
    if term_getstatus(b) =~ '.*running.*'
      tbufnr = b
      break
    endif
  endfor
  if tbufnr != 0
    var twinnr = bufwinnr(tbufnr)
    if twinnr == -1
      wincmd s
      wincmd J
      execute "buffer" tbufnr
    else
      execute ":" .. string(twinnr) .. "wincmd w"
    endif
    feedkeys((mode() == "n") ? "i" : "")
  else
    echomsg 'No terminal running -- Open terminal with command :terminal'
  endif
enddef

# Description: Change background of 24bit hex-coded color under cursor,
def ColorizeCodeUnderCursor()
  var rgb_24bit = expand('<cword>')
  execute $"highlight Color24 guifg=black guibg={rgb_24bit}"
  execute $"match Color24 /{rgb_24bit}/"
enddef

command -nargs=0 ShowColorUnderCursor call ColorizeCodeUnderCursor()

assert_true(mapcheck("<Leader>ux") == "", "mapping overwritten")
nnoremap <Leader>ux :call g:RunTerminal()<CR>

nnoremap <Leader>/ :call ForwardSlashToBackward()<CR>
nnoremap <Leader>\ :call BackwardSlashToForward()<CR>
nnoremap <Leader>q :call quickfix#ToggleQuickfix()<CR>

command! -nargs=0 ShowUnsavedChanges g:ShowUnsavedChanges()

defcompile
