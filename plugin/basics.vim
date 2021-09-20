" Vim plugin file
"
" Description: very basic functions called from init.vim as autoload functions
" to save startup time.

" Interfaces:
noremap <unique> <script> <Plug>ShowHiInfo             <SID>ShowHiInfo
noremap <unique> <script> <Plug>ToggleStickyCursorline <SID>ToggleStickyCursorline
noremap <unique> <script> <Plug>ToggleQuickfix         <SID>ToggleQuickfix
noremap <unique> <script> <Plug>HighlightWord          <SID>HighlightWord

noremap <SID>ShowHiInfo             :call <SID>ShowHiInfo()<CR>
noremap <SID>ToggleStickyCursorline :call <SID>ToggleStickyCursorline()<CR>
noremap <SID>ToggleQuickfix         :call <SID>ToggleQuickfix()<CR>
noremap <SID>HighlightWord          :call <SID>HighlightWord("<C-r><C-w>")<CR>

" Defaults: Key mappings
if !hasmapto('<Plug>ToggleQuickfix')
  nmap <Leader>q <Plug>ToggleQuickfix
endif

if !hasmapto('<Plug>HighlightWord')
  nmap <Leader><Leader> <Plug>HighlightWord
endif

command -nargs=0 ToggleStickyCursorline call <SID>ToggleStickyCursorline()
command -nargs=0 ShowHiInfo             call <SID>ShowHiInfo()

" Autocmd: put them in a dedicated group
augroup basics
  autocmd!
  autocmd BufReadPost * :call <SID>RestoreCursor()
  autocmd QuickFixCmdPre * :cclose
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
      autocmd!
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
  let save_win = win_getid()
  let qfIsOpen = 0
  windo if &buftype == 'quickfix' | let qfIsOpen = 1 | endif
  if qfIsOpen == 0
    let max_lines = (40 * getwininfo()['variables']['height'] ) / 100
    if len(getqflist()) == 0
      cclose
    if len(getqflist()) <= max_lines
      execute "botright copen"  len(getqflist())
    else
      execute "botright copen"  max_lines
    endif
  else
  cclose
endif
if win_gotoid(save_win) == 0
  wincmd p
endif
endfunction

" Description: Print highlighting information at current cursor position.
function! s:ShowHiInfo()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  echo "highlight name:" synIDattr(synidtrans, "name")
  echo "foreground:" synIDattr(synidtrans, "fg")
  echo "background:" synIDattr(synidtrans, "bg")
endfunction

