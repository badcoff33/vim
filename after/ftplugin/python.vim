" Vim ftplugin file

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

" How to display unprintable charcters
setlocal list
setlocal listchars=tab:>-,trail:.,extends:#

