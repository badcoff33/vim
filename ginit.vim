" GUI startup script

syntax on
set title

" Save when Vim is losing or gaining focus
augroup ginit
  " clear group in case file sourced several times
  autocmd!
  " write all buffers when loosing focus
  autocmd FocusLost * :silent! wall
  " Reload changed buffers. Command rely on option 'autoread'
  autocmd FocusGained * :checktime
  " Option 'title' needs to be set for this
  autocmd BufEnter * :set titlestring=%t\ %{expand('%:h')}\ %{strftime('%c',getftime(expand('%')))}
augroup END

if has('gui')
  set guioptions=a
  set mousemodel=popup
elseif has("nvim") 
  if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'Courier 11')
    call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 1)
    call rpcnotify(1, 'Gui', 'Option', 'Cmdline', 0)
  elseif exists('g:GuiLoaded') 
    if g:GuiLoaded == 1
      GuiLinespace 3
      GuiTabline 0
      GuiPopupmenu 0
    endif
  endif
endif
" vim:ft=vim
