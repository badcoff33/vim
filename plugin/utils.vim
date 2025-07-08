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

def g:OpenTerminal()
  var term_bufnr: number
  var not_found: bool

  not_found = true
  term_bufnr = -1

  for b in term_list()
    if term_getstatus(b) =~ '.*running.*'
      term_bufnr = b
      break
    endif
  endfor

  if term_bufnr == -1

    echomsg 'No terminal running -- Open one with :terminal'

  else

    for t in range(1, tabpagenr("$"))
      if match(tabpagebuflist(t), string(term_bufnr)) > -1
        execute(":" .. string(t) .. "tabnext")
        execute(":" .. string(bufwinnr(term_bufnr)) .. "wincmd w")
        feedkeys((mode() == "n") ? "i" : "")
        not_found = false
        break
      endif
    endfor
    if not_found == true
      wincmd s
      wincmd J
      execute "buffer" term_bufnr
    endif
  endif
enddef

var switch_back_bufnr: number

def ExploreHere()
  var b = bufname()
  var t = fnamemodify(b, ":t")

  execute $"edit {filereadable(b) ? fnamemodify(b, ':p:h') : getcwd()}"
  normal gg
  search(t, "")
  execute "match IncSearch /\\<" .. t .. "\\>/"
  timer_start(300, (timer) => execute("match none") )

enddef

augroup GroupTerminal
  autocmd!
  autocmd TerminalOpen * setlocal scrolloff=0 signcolumn=no nocursorline foldcolumn=0
  autocmd TerminalOpen * setlocal nonumber norelativenumber
  # autocmd WinLeave     * {
  #   if &buftype == 'terminal' && winnr("$") > 1
  #     wincmd c
  #   endif
  # }
augroup END " }}}

command -nargs=0 ExploreHere call ExploreHere()

nnoremap <F5> :call OpenTerminal()<CR>

nnoremap <Leader>E <Cmd>ExploreHere<CR>
nnoremap <Leader>/ <Cmd>ForwardSlashToBackward()<CR>
nnoremap <Leader>\ <Cmd>BackwardSlashToForward()<CR>

command! -nargs=0 ShowUnsavedChanges g:ShowUnsavedChanges()

defcompile
