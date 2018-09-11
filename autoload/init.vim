" Vim autload file

if !exists("g:welcome_text_file")
  let g:welcome_text_file = '~/Documents/welcome.txt'
endif

autocmd BufRead welcome.txt nmap <buffer> <CR> 1y$:<C-r>"<CR>

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
      silent! cnext
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
      silent! cprevious
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
  execute 'edit ' . g:welcome_text_file
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

if !exists("g:one_more_thing_file")
  let g:one_more_thing_file = '~/Documents/omt.md'
endif

function! init#ShowOneMoreThing()
  if filereadable(expand(g:one_more_thing_file, ":p:h"))
    execute "edit " . g:one_more_thing_file 
  else
    echomsg "No OneMoreThing?"
  endif
endfunction

" Description: Enter one-more-thing and store the text with file and line info
" in a file. This file/line info can be opend with a 'gF' command.
function! init#OneMoreThing()
  let l:reference = input(
        \ "Where? ", 
        \ printf('"%s" %d', bufname("%"), line(".")),
        \ "file")
  let l:comment = input(
        \ "What? ", 
        \ "", 
        \ "tag")
  if empty(l:reference)
    let l:new_item = printf('- %s', l:comment)
  else
    let l:new_item = printf('- %s -- %s', l:reference, l:comment)
  endif
  if !filereadable(expand(g:one_more_thing_file, ":p:h"))
    enew
    put='# One More Thing'
    execute 'w! ' . g:one_more_thing_file
  endif
  if !bufexists(g:one_more_thing_file)
    execute "edit " . g:one_more_thing_file
  else
    execute "buffer " . g:one_more_thing_file
  endif
  normal G
  put=l:new_item
  write
endfunction

" vim:sw=2:tw=0:nocindent:foldmethod=marker
