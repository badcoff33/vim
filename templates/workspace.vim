" A Workspace File

augroup Workspace
  " Forget the old Workspace autocmd's
  au!
 autocmd BufEnter *.c,*.h setlocal number foldcolumn=2
augroup END

let g:c_use_simple_tag_preview=0

" Highlight custom types of syntax file after/syntax/c.vim
let g:syntax_custom_c_types = 1

let g:one_more_thing_file = "~\\Documents\\omt_gen4.md"

" no tag info while useing tag completion in cmd line
set wildoptions=

set suffixes=*.vim,,

iabbrev x16 (uint16)
iabbrev x8  (uint8)

set tagcase=match
set foldcolumn=1

set title 
set titlestring=%{getcwd()}
set titlelen=70

set path=.
set path+=C_HeaterCore/HeaterCore/**
set path+=C_HeaterCore/HeaterCore
set path+=C_CDD/**
set path+=C_CDD
set path+=C_Application/Application/**
set path+=C_Application/Application
set path+=C_Application/CDD/**
set path+=C_Application/CDD
set path+=C_Application/CmdHandler/**
set path+=C_Application/CmdHandler
set path+=C_Application/NvmHandler/**
set path+=C_Application/NvmHandler
set path+=C_CmdHandler/**
set path+=C_CmdHandler
set path+=C_WBusCoreServices/**
set path+=,

" Set compiler for project
compiler! greenhills

""" set grepprg=grep\ -Hn\ -r\ --include='*.[ch]'
"""             \\ --exclude-dir=TLProj
"""             \\ --exclude-dir=TLSim
"""             \\ --exclude-dir=Doc
"""             \\ --exclude-dir=C_AUTOSAR

" Windows findstr
"""" if has("win32") || has("win64")
""""   set grepprg=findstr\ /N\ /F:.index
"""" endif

" vim:sw=2:tw=0:nocindent:foldmethod=marker
