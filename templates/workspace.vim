" A Workspace File

augroup Workspace
  " Forget the old Workspace autocmd's
  au!
 autocmd BufEnter *.c,*.h setlocal number foldcolumn=2
 autocmd BufEnter ChangeLog.txt execute 'setlocal makeprg=' . escape('pandoc -f markdown -t docx -t docx -o s:\c\Users\prepensm\Downloads\ChangeLog.docx C_HeaterCore\ChangeLog.txt', ' \')
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

"""""""""""
" TOOLS {{{
"""""""""""

" Set compiler for project
compiler! greenhills

" Ripgrep
set grepformat=%f:%l:%c:%m,%f:%l:%m
set grepprg=rg
            \\ --vimgrep
            \\ -t\ c
            \\ -g\ !TLSim
            \\ -g\ !TLProj
            \\ -g\ !_sfprj
            \\ $*

nnoremap <silent> <f11> :let @/="<C-r><C-w>"<CR>:silent grep -g !C_AUTOSAR <C-r><C-w> . <CR>
nnoremap <silent> <f12> :cnext<CR>
nnoremap <silent> <S-f12> :cprevious<CR>
nnoremap <silent> <Leader>T : TagbarToggle<CR>
nnoremap <silent> <Leader>g :let @/="<C-r><C-w>"<CR>:silent grep -g !C_AUTOSAR <C-r><C-w> . <CR>
nnoremap <Leader>G :silent grep -g !C_AUTOSAR  .<left><left>

let g:workspace_make_str = "Debug.gpj"
nnoremap <Leader>m :cd C_Application/Build <CR>:sil make <C-r>=g:workspace_make_str<CR><CR>:cd ../..<CR> :clist<CR>
nnoremap <Leader>M :let g:workspace_make_str = input("Make command? ", g:workspace_make_str)<CR>

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

" vim:sw=2:tw=0:nocindent:foldmethod=marker
