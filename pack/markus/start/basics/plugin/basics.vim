" Vim plugin file
"
" Description: very basic functions called from init.vim as autoload functions
" to save startup time.

" Interfaces:
noremap <unique> <script> <Plug>ShowHighlightAttr       <SID>ShowHighlightAttr
noremap <unique> <script> <Plug>ToggleStickyCursorline  <SID>ToggleStickyCursorline
noremap <unique> <script> <Plug>ToggleQuickfix          <SID>ToggleQuickfix
noremap <unique> <script> <Plug>HighlightWord           <SID>HighlightWord

noremap <SID>HighlightWord          :call hiword#HighlightWord("<C-r><C-w>")<CR>
noremap <SID>ShowHighlightAttr      :call color#ShowHighlightAttr()<CR>
noremap <SID>ToggleStickyCursorline :call sticky#ToggleStickyCursorline()<CR>
noremap <SID>ToggleQuickfix         :call quickfix#ToggleQuickfix()<CR>

" Defaults: Key mappings
if !hasmapto('<Plug>ToggleQuickfix')
  nmap <Leader>q <Plug>ToggleQuickfix
endif

if !hasmapto('<Plug>HighlightWord')
  nmap <Leader><Leader> <Plug>HighlightWord
endif

command -nargs=0 ToggleStickyCursorline call sticky#ToggleStickyCursorline()
command -nargs=0 ShowHighlightAttr      call color#ShowHighlightAttr()

