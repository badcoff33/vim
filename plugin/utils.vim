vim9script

import autoload "popnews.vim"
import autoload "quickfix.vim"

g:last_search = ""
g:user_vimrc = expand(g:vim_home .. '/pack/user/start/' .. getenv('USERNAME') .. '/plugin/user.vim')

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

if !filereadable(g:user_vimrc)
  mkdir(fnamemodify(g:user_vimrc, ':p:h'), 'p')
  execute "edit" expand(g:vim_home .. "/templates/user_vimrc.vim")
  execute "write" g:user_vimrc
endif

var cwd_stored: string

augroup GroupUtils
  autocmd!
  # autocmd CmdlineEnter / GetSearchMode()
  # autocmd CmdlineEnter ? GetSearchMode()
  autocmd BufNewFile .vimrc execute ":0read " expand(g:vim_home .. "/templates/local_vimrc.vim")
  autocmd DirChanged global {
    if getcwd() != cwd_stored
      if filereadable(".vimrc")
        call popnews.Open("local .vimrc available")
      endif
      if filereadable(".session.vim")
        call popnews.Open("local .session.vim available")
      endif
    endif
    cwd_stored = getcwd()
  }
  autocmd SourcePost .vimrc popnews.Open('sourced ' .. expand('<afile>:t'))
  autocmd SourcePost .session.vim popnews.Open('sourced ' .. expand('<afile>:t'))
  autocmd TerminalOpen * setlocal signcolumn=no nocursorline foldcolumn=0
  autocmd TerminalOpen * setlocal nonumber norelativenumber
  autocmd WinEnter     * {
    if &buftype == 'terminal'
      normal i
    endif
  }
augroup END " }}}

if filereadable(".vimrc")
  call popnews.Open("local .vimrc available")
endif
if filereadable(".session")
  call popnews.Open("local .session available")
endif

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

hi PostIt guifg=black guibg=yellow gui=italic
if prop_type_get('text_prop_postit') == {}
  prop_type_add('text_prop_postit', {
    highlight: 'PostIt'
  })
endif

def PostIt(arg_text: string = "")
  def PinText(t: string)
    prop_add(line('.'), 0, {
      bufnr: bufnr('%'),
      type: "text_prop_postit",
      text: t,
      text_align: 'below',
      text_padding_left: col('.')
    })
  enddef
  if len(arg_text) > 0
    PinText(arg_text)
    return
  endif
  var text: string
  var prompt: string
  prompt = "POSTIT "
  while true
    text = input("Post it (press <CR> only to leave): ")
    if text == ""
      break
    endif
    PinText(prompt .. text)
    prompt = substitute(prompt, ".", " ", "g")
  endwhile
enddef

export def PostItRemove()
    prop_clear(line("."))
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
    popnews.Open('No terminal running -- Open terminal with command :terminal')
  endif
enddef

def GetSearchMode()
  if &ignorecase == true && &smartcase == true
    popnews.Open('smartcase')
  elseif &ignorecase == false
    popnews.Open('case sensetive')
  else
    popnews.Open('ignore case')
  endif
enddef

assert_true(mapcheck("<Leader>x"), "mapping overwritten")
nnoremap <Leader>x :call g:RunTerminal()<CR>

assert_true(mapcheck("<Leader>v"), "mapping overwritten")
nnoremap <Leader>vv :edit <C-r>=expand("~/vimfiles/vimrc")<CR><CR>
nnoremap <Leader>vu :edit <C-r>=g:user_vimrc<CR><CR>
nnoremap <Leader>vf :edit <C-r>=expand("~/vimfiles/after/ftplugin/" .. &ft .. ".vim")<CR><CR>
nnoremap <Leader>vc :edit <C-r>=expand("~/vimfiles/colors/" .. g:colors_name .. ".vim")<CR><CR>

nnoremap <Leader>/ :call ForwardSlashToBackward()<CR>
nnoremap <Leader>\ :call BackwardSlashToForward()<CR>
nnoremap <Leader>? <Cmd>call popnews#PopupFiletypeHelp()<CR>
nnoremap <C-Tab> :call quickfix#ToggleQuickfix()<CR>

# nice presentation of v:errors, filled by assert functions
command! -nargs=0 PrintErrors for e in v:errors | echo e | endfor
command! -nargs=0 ClearErrors v:errors = []

command! -nargs=* PostIt PostIt(<q-args>)
command! -nargs=0 PostItRemove PostItRemove()
command! -nargs=0 ShowUnsavedChanges g:ShowUnsavedChanges()

defcompile

