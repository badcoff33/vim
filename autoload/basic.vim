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

function! basic#HighlightWord(word)
  let s:thisHighlightWord = get(s:, 'thisHighlightWord', "")
  highlight HighlightWordGroup gui=underline
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

" Description: Popup term buffer.
" If no term buffer open, open a new one.
" TODO: handle multiple term buffers.
function! basic#PopupTerminal()
  let l:termBufNr = bufnr("^term:*")
  if l:termBufNr < 0
    terminal
    return
  endif
  let l:termWinNr = win_findbuf(l:termBufNr)
  if empty(l:termWinNr)
    execute l:termBufNr . "buffer"
  else
    noautocmd call win_gotoid(l:termWinNr[0])
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

function! basic#SurroundSelection()
  echomsg "Press key to surround visual selection ... "
  let l:nr = getchar()
  if (l:nr != "\<ESC>") && (l:nr != "\<C-c>")
    let l:opening_char = nr2char(l:nr)
    let l:closing_char = l:opening_char
    for pair in [ "()", "{}", "[]", "<>" ]
      if l:opening_char == pair[1]
        let l:closing_char = pair[0]
        break
      endif
    endfor
    call feedkeys('`>a' . l:closing_char, "x")
    call feedkeys('`<i' . l:opening_char, "x")
  endif
endfunction

function! basic#OpenFloatingWin(string)
  if !has('nvim')
    call popup_create(split(a:string, '\n'), #{ pos: 'topleft',
      \ line: 'cursor+1', col: 'cursor', moved: 'WORD' })
    return
  endif
  let l:opts = {
        \ 'relative': 'cursor',
        \ 'row': 1,
        \ 'col': 1,
        \ 'anchor': 'NW',
        \ 'height': 10,
        \ 'width': 40,
        \ 'style': 'minimal'
        \ }

  let l:buf = nvim_create_buf(v:false, v:true)
  let l:win = nvim_open_win(l:buf, v:true, l:opts)
  call nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
  call nvim_win_set_option(win, 'winblend', 20)

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ signcolumn=no
  0put =printf('%s', a:string)
  normal gg
  autocmd BufLeave <buffer> bwipeout!
  nmap <buffer> <Esc> :bwipeout!<CR>
  nmap <buffer> <CR>  :bwipeout!<CR>
endfunction

function! basic#OpenFloatingHelp(help_arg)
  if !has('nvim')
    echo "sorry, nvim only."
  endif
  let width = min([&columns - 4, max([80, &columns - 20])])
  let height = min([&lines - 4, max([20, &lines - 10])])
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor',
        \'row': top,
        \'col': left,
        \'width': width,
        \'height': height,
        \'style': 'minimal'}
  let s:buf = nvim_create_buf(v:false, v:true)
  let l:win = nvim_open_win(s:buf, v:true, opts)
  call nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
  setlocal nonumber norelativenumber buftype=help
  exe "help " . a:help_arg
endfunction


" vim:sw=2:tw=0:nocindent
