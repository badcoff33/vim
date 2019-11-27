" GUI startup script

syntax on

set title

" Save when Neovim's losing or gaining focus
augroup ginit
  " clear group in case file sourced several times
  autocmd!
  " write all buffers when loosing focus
  autocmd FocusLost * :silent! wall
  " Reload changed buffers. Command rely on option 'autoread'
  autocmd FocusGained * :checktime
  " Option 'title' needs to be set for this
  autocmd BufEnter * :set titlestring=%t\ %f\ %H:%M\ %{strftime('%c',getftime(expand('%')))}
augroup END

if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'FreeMono 12')
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 1)
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 1)
  call rpcnotify(1, 'Gui', 'Option', 'Cmdline', 1)
elseif has("nvim") && exists('g:GuiLoaded') 
  if g:GuiLoaded == 1
    GuiLinespace 3
    GuiTabline 0
    GuiPopupmenu 0
  endif
elseif has('gui')
  set guioptions=!gt
  set guicursor=n-v:block-Cursor/lCursor-blinkon0
  set guicursor+=ve:ver35-Cursor-blinkon0
  set guicursor+=o:hor50-Cursor-blinkon0
  set guicursor=c:ver25-Cursor/lCursor-blinkon0
  set guicursor+=i-ci:ver25-Cursor/lCursor-blinkon0
  set guicursor+=r-cr:hor20-Cursor/lCursor-blinkon0
  set guicursor+=sm:block-Cursor-blinkon0
  set mousemodel=popup
  set mousefocus
endif

" vim:ft=vim
