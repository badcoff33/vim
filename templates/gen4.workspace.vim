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

" Evaluate unique session file name
let g:workspace_session_file = $TEMP. "/" . sha256(getcwd()) . ".vim"

augroup Workspace
  " Forget the old Workspace autocmd's
  au!

  autocmd QuickFixCmdPre make cd C_Application/Build

  autocmd QuickFixCmdPost make cd ../..
  autocmd QuickFixCmdPost botright cwindow
  autocmd QuickFixCmdPost make UpdateCtags

  " Create a session file while leaving Vim
  autocmd VimLeavePre * execute "mksession! " . g:workspace_session_file
augroup END

command! -nargs=0 ExportChangelogHtml silent !start /MIN pandoc -f markdown -t html -o S:\C\Users\prepensm\Downloads\ChangeLog.html C_HeaterCore\ChangeLog.txt
command! -nargs=0 ExportChangelogDoc silent !start /MIN pandoc -f markdown -t docx -o S:\C\Users\prepensm\Downloads\ChangeLog.docx C_HeaterCore\ChangeLog.txt

" Highlight custom types of syntax file after/syntax/c.vim
let g:syntax_custom_c_types = 1

" no tag info while useing tag completion in cmd line
set wildoptions=

" plugins
let g:tagbar_left = 1
nmap <Leader>T :TagbarToggle<CR>

packadd tagbar

iabbrev x16 (uint16)
iabbrev x8  (uint8)

set tags=TAGS
set tagcase=match
set foldcolumn=1

set title 
set titlestring=%{getcwd()}\ -\ Vim
set titlelen=70

set path=C_HeaterCore/HeaterCore/**
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
            \\ -g\ !TLSim
            \\ -g\ !TLProj
            \\ -g\ !_sfprj
nnoremap <f8>       :silent grep -g !C_AUTOSAR <C-r><C-w><CR>
nnoremap <Leader>g  :silent grep -g !C_AUTOSAR <C-r><C-w>
nnoremap <Leader>G  :silent grep -g !C_AUTOSAR<Space>

""" set grepprg=grep\ -Hn\ -r\ --include='*.[ch]'
"""             \\ --exclude-dir=TLProj
"""             \\ --exclude-dir=TLSim
"""             \\ --exclude-dir=Doc
"""             \\ --exclude-dir=C_AUTOSAR

""" GNU Global
""" set grepprg=global\ --result=grep\ --grep
""" set grepformat=%f:%l:%m
""" set cscopeprg=gtags-cscope
""" cscope kill 0
""" cscope add GTAGS

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
command! -nargs=1 GrepAutosar :vimgrep /<args>/ C_AUTOSAR\AUTOSAR_tresos\workspace\Application\output\generated\**\*.[ch]

" }}}

" #############################################################################
" source last session? {{{
" #############################################################################

echomsg "looking for session " . fnamemodify(g:workspace_session_file, ":t:r")
if filereadable(g:workspace_session_file)
  while 1
    let answer = tolower(input("load last session [yes|no]? " ,"yes"))
    if answer == "yes"
      execute "source " . g:workspace_session_file
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
