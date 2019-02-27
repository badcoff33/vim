" Vim ftplugin file

if exists("b:did_ftplugin_after")
    finish
endif

" Wrapping and tabs.
setlocal textwidth=78
setlocal tabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab
setlocal softtabstop=4
setlocal noautoindent
setlocal formatoptions=cq
setlocal foldignore=
setlocal wildignore+=*.py[co]
setlocal keywordprg=pydoc

" More syntax highlighting.
let python_highlight_all = 1

" statusline with cursors scope info
setlocal statusline=%t%m%r%y%w\ %{ScopeParserPython()}%=%l,%c%V\ %P

" Use :make % to check the script. (:cn and :cp to move around)
setlocal makeprg=pylint\ --reports=no\ --output-format=parseable
" Parse for errors with s 'errorformat'.
compiler gcc

" How to display unprintable charcters
setlocal list
setlocal listchars=tab:>-,trail:.,extends:#

let b:did_ftplugin_after = 1
