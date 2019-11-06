" Vim compiler file
" Compiler:   Python Interpreter
" Maintainer: Markus Prepens (markus.prepens@gmail.com)

set makeprg=python
set errorformat=\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m


function! CheckPythonSyntax()
  let curfile = bufname("%")
  exec ":make " . "-c " . "\"import py_compile; py_compile.compile(r'" . bufname("%") . "')\""
endfunction
