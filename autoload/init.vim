" Vim autload file

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

function! init#ToggleStickyCursorLine()
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
function! init#RestoreCursor ()
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction

" Description: A context sensitve file movement function.
function! init#FastForwardAndRewind(direction)
  if a:direction == "fastforward"
    if &diff
      normal ]czz
    elseif &filetype == "diff"
      execute search('^\(diff\|@@\)','W')
    elseif &filetype == "help"
      execute search('^[0-9\.]\+\s\+[A-Z]\+.*\*[a-z-]\+\*','W')
		elseif &filetype == "markdown"
			execute search('^#\+\s\+','W')
    else
      normal ]]
    endif
  elseif a:direction == "rewind"
    if &diff
      normal [czz
    elseif &filetype == "diff"
      execute search('^\(diff\|@@\)','bW')
    elseif &filetype == "help"
      execute search('^[0-9\.]\+\s\+[A-Z]\+.*\*[a-z-]\+\*','bW')
		elseif &filetype == "markdown"
			execute search('^#\+\s\+','bW')
    else
      normal [[
    endif
  endif
endfunction

function! init#HiName()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  echo synIDattr(synidtrans, "name")
endfunction

" Description: My splash screen (with one-liner Vim script in it)
function! init#Welcome()
  let l:welcome_text_file = '~/Documents/welcome.txt'
  if filereadable(expand(l:welcome_text_file))
    execute 'edit ' . l:welcome_text_file
    nmap <buffer> <CR> 0y$:<C-r>"<CR>
  endif
endfunction

" Description: Create or move to buffer ClipboardTxt, start to write text,
" switch to another application and copy the clipboard, filled with
" ClipboardTxt.
function! init#ClipboardBuffer()
  if bufexists("ClipboardTxt")
    buffer ClipboardTxt
  else
    edit ClipboardTxt
    setlocal buftype=nofile
    autocmd FocusLost ClipboardTxt  normal gg"*yG
  endif
endfunction

function! init#HighlightWord(word)
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

" vim:sw=2:tw=0:nocindent:foldmethod=marker