" Vim autoload file
"
" Description: very basic functions called from init.vim as autoload functions
" to save startup time. 

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

function! basic#ToggleStickyCursorLine()
  if !exists("g:use_sticky_cursorline")
    let g:use_sticky_cursorline = 0
  endif
  if g:use_sticky_cursorline == 0
    let g:use_sticky_cursorline = 1
    set cursorline
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

" Description: Jump to last location. Check out :help line(). Function checks
" if the '" marker is valid. Jump to the mark, but don't change the jumplist
" when jumping within the current buffer (:help g').
function! basic#RestoreCursor ()
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction

function! basic#HiName()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  echo synIDattr(synidtrans, "name")
endfunction

" Description: Create or move to buffer ClipboardTxt, start to write text,
" switch to another application and copy the clipboard, filled with
" ClipboardTxt.
function! basic#ClipboardBuffer()
  if bufexists("ClipboardTxt")
    buffer ClipboardTxt
  else
    edit ClipboardTxt
    setlocal buftype=nofile
    autocmd FocusLost ClipboardTxt  normal gg"*yG
  endif
endfunction

function! basic#HighlightWord(word)
  if !exists("s:thisHighlightWord")
    let s:thisHighlightWord = ""
  endif
  echo s:thisHighlightWord
  if a:word != s:thisHighlightWord
    let s:thisHighlightWord = a:word
    execute ":match HighlightWordGroup /\\<" . a:word . "\\>/"
  else
    let s:thisHighlightWord = ""
    match none
  endif
endfunction

function! basic#ToggleQuickfix()
  let l:save_win = win_getid()
  let l:qfIsOpen = 0
  windo if &buftype == 'quickfix' | let l:qfIsOpen = 1 | endif
  if l:qfIsOpen == 0
    botright copen
  else
    cclose
  endif
  if win_gotoid(l:save_win) == 0 
    wincmd p 
  endif 
endfunction

function! basic#ToggleStatusline()
  if !exists("b:saved_statusline")
    let b:saved_statusline = &statusline
    setlocal statusline=%1*%F\ %0*%=%l,%c%V\ %P
  else
    execute "setlocal statusline=" . escape(b:saved_statusline, ' ')
    unlet b:saved_statusline
  endif
endfunction

" vim:sw=2:tw=0:nocindent
