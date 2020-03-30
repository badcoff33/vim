" Vim plugin file
"
" Description: very basic functions called from init.vim as autoload functions
" to save startup time.

" Interfaces:
noremap <unique> <script> <Plug>ShowHiInfo             <SID>ShowHiInfo
noremap <unique> <script> <Plug>ToggleStickyCursorline <SID>ToggleStickyCursorline
noremap <unique> <script> <Plug>ToggleQuickfix         <SID>ToggleQuickfix
noremap <unique> <script> <Plug>PopupTerminal          <SID>PopupTerminal
noremap <unique> <script> <Plug>HighlightWord          <SID>HighlightWord
noremap <unique> <script> <Plug>SurroundSelection      <SID>SurroundSelection

noremap <SID>ShowHiInfo             :call <SID>ShowHiInfo()<CR>
noremap <SID>ToggleStickyCursorline :call <SID>ToggleStickyCursorline()<CR>
noremap <SID>ToggleQuickfix         :call <SID>ToggleQuickfix()<CR>
noremap <SID>PopupTerminal          :call <SID>PopupTerminal()<CR>
noremap <SID>HighlightWord          :call <SID>HighlightWord("<C-r><C-w>")<CR>
noremap <SID>SurroundSelection      :<C-u>call <SID>SurroundSelection()<CR>

" Defaults: Key mappings
if !hasmapto('<Plug>ShowHiInfo')
  nmap <leader><leader>h <Plug>ShowHiInfo
endif

if !hasmapto('<Plug>ToggleStickyCursorline')
  nmap <leader><leader>c <Plug>ToggleStickyCursorline
endif

if !hasmapto('<Plug>ToggleQuickfix')
  nmap <S-Tab> <Plug>ToggleQuickfix
endif

if !hasmapto('<Plug>PopupTerminal')
  nmap <leader>T <Plug>PopupTerminal
endif

if !hasmapto('<Plug>HighlightWord')
  nmap <leader>* <Plug>HighlightWord
endif

if !hasmapto('<Plug>SurroundSelection','v')
  vmap <CR> <Plug>SurroundSelection
endif

" Autocmd: put them in a dedicaed group
augroup basics
  autocmd!
  autocmd BufReadPost * :call <SID>RestoreCursor()
augroup END

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

function! s:ToggleStickyCursorline()
  if !exists("g:use_sticky_cursorline")
    let g:use_sticky_cursorline = 0
  endif
  if g:use_sticky_cursorline == 0
    let g:use_sticky_cursorline = 1
    set cursorline
    augroup ToggleStickyCursorline
      au!
      autocmd WinLeave * set nocursorline
      autocmd BufEnter,BufWinEnter,WinEnter * call <SID>TurnCursorLineOn()
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
function! s:RestoreCursor ()
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g`\""
  endif
endfunction

function! s:HighlightWord(word)
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

function! s:ToggleQuickfix()
  let l:save_win = win_getid()
  let l:qfIsOpen = 0
  windo if &buftype == 'quickfix' | let l:qfIsOpen = 1 | endif
  if l:qfIsOpen == 0
    topleft copen
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
function! s:PopupTerminal()
  let l:termBufNr = bufnr("^term:")
  if l:termBufNr == -1
    let l:termBufNr = bufnr("^\!")
  endif
  if l:termBufNr == -1
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

" Description: surround visual selection with double quote ("), quote ('),
" backtick (`), parentheses (), braces {} and brackets []
function! s:SurroundSelection()
  echomsg "Press key to surround visual selection ... "
  let l:nr = getchar()
  if (l:nr != "\<ESC>") && (l:nr != "\<C-c>")
    let l:opening_char = nr2char(l:nr)
    let l:closing_char = l:opening_char
    for pair in [ "()", "{}", "[]", "<>" ]
      if l:opening_char == pair[0]
        let l:closing_char = pair[1]
        break
      endif
    endfor
    call feedkeys('`>a' . l:closing_char, "x")
    call feedkeys('`<i' . l:opening_char, "x")
  endif
endfunction

function! s:OpenFloatingWin(string)
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

function! s:OpenFloatingHelp(help_arg)
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

" Description: Print highlighting information at current cursor position.
function! s:ShowHiInfo()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  echo "highlight name:" synIDattr(synidtrans, "name")
  echo "foreground:" synIDattr(synidtrans, "fg")
  echo "background:" synIDattr(synidtrans, "bg")
endfunction

