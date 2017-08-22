" A Workspace File

" #############################################################################
" prepare workspace {{{
" #############################################################################

" fresh start in workspace: wipe out all loaded buffers
%bwipeout

augroup Workspace
  " Forget the old Workspace autocmd's
  au!
  " Well, this is a little bit tricky for GEN4: When :make is entered
  " (pre-make) Push to uild directory. Vim runs make command.  (post-make 1)
  " Pop back to projects root dir of sources.  (post-make 2) Run the ctags
  " update.
  autocmd QuickFixCmdPre  make :UpdateTags
  autocmd QuickFixCmdPre  make :cd C_Application\Build
  autocmd QuickFixCmdPost make :cd ..\..

  " Create a session file while leaving Vim
  autocmd VimLeavePre * mksession! .last.vim
augroup END

" }}}

" #############################################################################
" workspace specific stuff {{{
" #############################################################################

" Highlight custom types of syntax file after/syntax/c.vim
let g:syntax_custom_c_types = 1

" plugins
let g:tagbar_left = 1
packadd tagbar

set path=.
set path+=C_HeaterCore\\HeaterCore\\**
set path+=C_HeaterCore\\HeaterCore
set path+=C_CDD\\**
set path+=C_CDD
set path+=C_Application\\Application\\**
set path+=C_Application\\Application
set path+=C_Application\\CDD\\**
set path+=C_Application\\CDD
set path+=C_Application\\CmdHandler\\**
set path+=C_Application\\CmdHandler
set path+=C_Application\\NvmHandler\\**
set path+=C_Application\\NvmHandler
set path+=C_CmdHandler\\**
set path+=C_CmdHandler
set path+=C_WBusCoreServices\\**
set path+=,

" #############################################################################
" tools {{{
" #############################################################################

" Set compiler for project
compiler! greenhills

""" Ripgrep
set grepformat=%f:%l:%c:%m
set grepprg=rg\ -tc\ --vimgrep

""" GNU Global
""" set grepprg=global\ --result=grep\ --grep
""" set cscopeprg=gtags-cscope

" Windows findstr
"""" if has("win32") || has("win64")
""""   set grepprg=findstr\ /N\ /F:.index
"""" endif

" }}}

" #############################################################################
" commands {{{
" #############################################################################

command! -nargs=0 UpdateTags :silent !start /MIN cmd /C ctags --language=C
command! -nargs=0 Gen4ListOfCmdhStates :tjump cmdhState_t
command! -nargs=0 Gen4ListWBusErrorCodes :tjump wtcmInternalErrorToWbusErrorCodeTable
command! -nargs=1 Gen4GrepAutosar :vimgrep /<args>/ C_AUTOSAR\AUTOSAR_tresos\workspace\Application\output\generated\**\*.[ch]
command! -nargs=0 HereAgainstPsa :SCRun diff -rub . c:\daten\TTEVO_GEN4\S_PSA_LIN_Trunk\Comp

" }}}

" #############################################################################
" source last session? {{{
" #############################################################################

if filereadable(".last.vim")
  while 1
    let answer = tolower(input("load last session [yes|no]? " ,"yes"))
    if answer == "yes"
      source .last.vim
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

