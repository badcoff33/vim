" Vim resource file when GUI version is running
finish
" Description: Make the actual window more obvious.
" Active 'cursorline' option in diff buffers overrules highlighting of
" differences. Buffers with 'diff' option shall not use 'cursorline'.
" Note: 'cursorline' may delay cursor movement in buffer with filetype 'c'.
" This behavior may be caused by Doxygen syntax highlighting.
function! s:TurnCursorLineOn()

  if g:use_sticky_cursorline !=0 && &diff == 0 && &buftype == ""
    set cursorline
  endif

endfunction

function! s:ToggleStickyCursorLine()

  if !exists("g:use_sticky_cursorline")
    let g:use_sticky_cursorline = 0
  endif

  if g:use_sticky_cursorline == 0
    let g:use_sticky_cursorline = 1
    if &diff == 0 && &buftype == ""
      set cursorline
    endif
    augroup ToggleStickyCursorline
      au!
      autocmd WinLeave * set nocursorline
      autocmd BufEnter,BufWinEnter,WinEnter * call s:TurnCursorLineOn()
    augroup END
  else
    let g:use_sticky_cursorline = 0
    set nocursorline
    augroup ToggleStickyCursorline
      au!
    augroup END
  endif

endfunction

command! ToggleStickyCursorline :call s:ToggleStickyCursorLine()

function! ToggleGUIMenu()
  if match(&guioptions, "m",) > 0
    set guioptions-=m
    set winaltkeys&
  else
    set guioptions+=m
    " Use not Alt mappings for gVims menu bar.
    set winaltkeys=no
  endif
endfunction
nnoremap <F10> :silent call ToggleGUIMenu()<CR>

nnoremap <C-F10> :silent set guifont=*<CR>

" Optional (but favorite) font: not installed on every machine
command! FiraBig    :GuiFont Fira\ Mono:h11
command! FiraMedium :GuiFont Fira\ Mono:h10
command! FiraSmall  :GuiFont Fira\ Mono:h9

set guifont=Consolas:h11

" Save when losing focus
autocmd FocusLost * :silent! wall

syntax on
colorscheme bleached

