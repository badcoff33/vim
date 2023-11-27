vim9script

###############################################################################

set guifont=Cascadia\ Code:h11 linespace=2
# set guifont=JuliaMono:h11 linespace=3
# set guifont=Courier\ Prime:h12 linespace=2
set guifont=Fantasque\ Sans\ Mono:h13
set columns=110

set pythonthreehome=%LOCALAPPDATA%\\Programs\\Python\\Python311emb
set pythonthreedll=%LOCALAPPDATA%\\Programs\\Python\\Python311emb\\python311.dll
BlinkyOn

autocmd GuiEnter * set renderoptions=
autocmd VimEnter * execute "colorscheme" ( (&term == "builtin_gui") ? "twotone" : "tron" )
nnoremap <Leader>n <Cmd>drop $OneDriveCommercial/Dokumente/Notes/notes.markdown<CR>

###############################################################################

# autocmd SourcePost lsp.vim LspAddServer(g:lspServers)

g:lspServers = [
    {
        filetype: ['c', 'cpp'],
        path: 'clangd',
        args: ['--background-index']
    }
]

###############################################################################
# Navigate with Fuzzy
g:enable_fuzzyy_keymaps = 0
g:fuzzyy_menu_matched_hl = 'CurSearch'
g:fuzzyy_dropdown = 0

nnoremap <Leader>1 <cmd>FuzzyFiles<CR>
nnoremap <Leader>2 <cmd>FuzzyBuffers<CR>

###############################################################################
# NETRW variables
g:netrw_use_errorwindow = 0
g:netrw_banner = 0
g:netrw_liststyle = 3 # tree listing
g:netrw_browse_split = 2
g:netrw_altv = 1
