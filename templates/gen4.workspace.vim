" A Workspace File
"
" Create a .vim directory on the same level as the project root.
" Session files, undo files and backups go there.

" #############################################################################
" prepare workspace {{{
" #############################################################################

" fresh start in workspace: wipe out all loaded buffers
%bwipeout

" }}}

" #############################################################################
" workspace specific stuff {{{
" #############################################################################
 
augroup Workspace
  " Forget the old Workspace autocmd's
  au!

  autocmd QuickFixCmdPre make cd C_Application/Build

  autocmd QuickFixCmdPost make cd ../..
  autocmd QuickFixCmdPost botright cwindow
  autocmd QuickFixCmdPost make UpdateCtags

  " Create a session file while leaving Vim
  autocmd VimLeavePre * mksession! .session.vim
augroup END

" Highlight custom types of syntax file after/syntax/c.vim
let g:syntax_custom_c_types = 1

" no tag info while useing tag completion in cmd line
set wildoptions=

" plugins
let g:tagbar_left = 1
packadd tagbar

iabbrev x16 (uint16)
iabbrev x8  (uint8)

set tags=TAGS
set tagcase=match
set foldcolumn=1

set title titlestring=%{getcwd()}\ -\ Vim titlelen=70
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

" }}}

" #############################################################################
" tools {{{
" #############################################################################

" Set compiler for project
compiler! greenhills

""" Ripgrep
set grepformat=%f:%l:%c:%m,%f:%l:%m
set grepprg=rg
            \\ --vimgrep
            \\ -t\ c
            \\ -g\ !C_AUTOSAR
            \\ -g\ !TLSim
            \\ -g\ !TLProj
            \\ -g\ !_sfprj

""" set grepprg=grep\ -Hn\ -r\ --include='*.[ch]'
"""             \\ --exclude-dir=TLProj
"""             \\ --exclude-dir=TLSim
"""             \\ --exclude-dir=Doc
"""             \\ --exclude-dir=C_AUTOSAR

""" GNU Global
""" set grepprg=global\ --result=grep\ --grep
""" set grepformat=%f:%l:%m
""" set cscopeprg=gtags-cscope

" Windows findstr
"""" if has("win32") || has("win64")
""""   set grepprg=findstr\ /N\ /F:.index
"""" endif

" }}}

" #############################################################################
" commands {{{
" #############################################################################

command! -nargs=0 UpdateCtags :silent !start /MIN cmd /C ctags -R .
command! -nargs=0 UpdateGlobal :silent !start /MIN cmd /C global --update
command! -nargs=0 Gen4ListOfCmdhStates :tjump cmdhState_t
command! -nargs=0 Gen4ListWBusErrorCodes :tjump wtcmInternalErrorToWbusErrorCodeTable
command! -nargs=1 Gen4GrepAutosar :vimgrep /<args>/ C_AUTOSAR\AUTOSAR_tresos\workspace\Application\output\generated\**\*.[ch]
command! -nargs=0 HereAgainstPsa :SCRun diff -rub . c:\daten\TTEVO_GEN4\S_PSA_LIN_Trunk\Comp
command! -nargs=* Astyle :SCRun astyle --type=bsd -P

" }}}

" #############################################################################
" source last session? {{{
" #############################################################################

if filereadable(".session.vim")
  while 1
    let answer = tolower(input("load last session [yes|no]? " ,"yes"))
    if answer == "yes"
      source .session.vim
      break
    elseif answer == "no"
      break
    endif
  endwhile
else
  echomsg "no session file found."
endif

" }}}

" vim:sw=2:tw=0:nocindent:foldmethod=marker
