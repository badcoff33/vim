" Vim plugin file
"
" Description: very basic functions called from init.vim as autoload functions
" to save startup time.

" Interfaces:
noremap <unique> <script> <Plug>InfoHighlightAttr       <SID>InfoHighlightAttr
noremap <unique> <script> <Plug>ToggleStickyCursorline  <SID>ToggleStickyCursorline
noremap <unique> <script> <Plug>HighlightWord           <SID>HighlightWord

noremap <SID>HighlightWord          :call visuals#HighlightWord("<C-r><C-w>")<CR>
noremap <SID>ToggleStickyCursorline :call visuals#ToggleStickyCursorline()<CR>
noremap <SID>InfoHighlightAttr      :call color#InfoHighlightAttr()<CR>

" Defaults: Key mappings

if !hasmapto('<Plug>HighlightWord')
  nmap <Leader><Leader> <Plug>HighlightWord
endif

command -nargs=0 ToggleStickyCursorline call visuals#ToggleStickyCursorline()
command -nargs=0 InfoHighlightAttr      call color#InfoHighlightAttr()

autocmd BufEnter * call color#BlendDownWindow()

