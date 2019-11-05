" GUI startup script

syntax on

if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Consolas 11')
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 1)
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 1)
  call rpcnotify(1, 'Gui', 'Option', 'Cmdline', 1)
endif

if has("nvim") && exists('g:GuiLoaded') 
  if g:GuiLoaded == 1
    GuiLinespace 3
    GuiTabline 0
    GuiPopupmenu 0
  endif
endif

" vim:ft=vim
