" Vim color theme
"
" Description:  This color theme uses color names, defined by X11 file
" 'rgb.txt'. Once you get used to the color names, it is quit easy to start or
" change a color theme file. IMO, more easier than hex numbers.

if exists("syntax_on")
  syntax reset
endif

highlight clear
set background=dark
let g:colors_name = "glimmer"

" very basic things
highlight Normal  guifg=grey85      guibg=grey13          ctermbg=black
highlight NonText guifg=dodgerblue1 guibg=bg              gui=none
highlight Visual  guifg=white       guibg=dodgerblue3

" where is the cursor?
highlight LineNr        guifg=grey38    guibg=bg          gui=none
highlight Cursor        guifg=black     guibg=powderblue
highlight CursorLineNr  guifg=grey38    guibg=grey17      gui=bold
highlight QuickFixLine                  guibg=bg          gui=bold
highlight CursorLine                    guibg=grey19
highlight! link CursorColumn CursorLine

" decorations
highlight VertSplit    guifg=grey27     guibg=bg     gui=none
highlight StatusLineNC guifg=grey48     guibg=grey20 gui=none
highlight StatusLine   guifg=white      guibg=grey30 gui=none
highlight User1        guifg=white      guibg=grey30 gui=bold cterm=inverse
highlight User2        guifg=white      guibg=grey30 gui=none cterm=inverse
highlight FoldColumn   guifg=cyan3      guibg=bg     gui=none ctermbg=bg
highlight Folded       guifg=cyan3      guibg=bg     gui=NONE
highlight SignColumn   guifg=skyblue4   guibg=bg

" search
highlight IncSearch  guifg=white        guibg=dodgerblue3 gui=bold
highlight Search     guifg=cyan1        guibg=bg          gui=underline
highlight MatchParen guifg=deepskyblue2 guibg=bg          gui=underline

" popup Menu
highlight Pmenu      guifg=white  guibg=grey33         gui=none
highlight PmenuSel   guifg=white  guibg=cornflowerblue gui=bold
highlight PmenuSbar               guibg=grey50
highlight PmenuThumb guifg=white
highlight! link WildMenu IncSearch

" tab line
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel StatusLine

" code
highlight Statement     guifg=yellow2         gui=bold
highlight Conditional   guifg=yellow2         gui=bold
highlight PreProc       guifg=green3          gui=bold
highlight Comment       guifg=grey45
highlight Type          guifg=deepskyblue1    gui=none
highlight StorageClass  guifg=green2          gui=none
highlight Function      guifg=green1          gui=bold
highlight Identifier    guifg=violetred1
highlight Special       guifg=magenta2
highlight Constant      guifg=cornflowerblue
highlight! link SpecialKey Special

highlight Title         guifg=goldenrod                   gui=none
highlight Subtitle      guifg=darkgoldenrod
highlight ToDo          guifg=cyan2      		guibg=black   gui=bold
highlight Error         guifg=white         guibg=tomato3
highlight Directory     guifg=skyblue2                    gui=underline

" messages
highlight ErrorMsg    gui=none guifg=tomato1      guibg=bg
highlight WarningMsg  gui=none guifg=deepskyblue2 guibg=bg
highlight ModeMsg     gui=none guifg=deepskyblue2 guibg=bg
highlight Question    gui=none guifg=deepskyblue2 guibg=bg
highlight MoreMsg     gui=none guifg=deepskyblue2 guibg=bg

" quickfix
highlight qfLineNr    guifg=steelblue3
highlight qfFileName  guifg=steelblue2 gui=underline
highlight qfSeparator guifg=fg
highlight qfError     guifg=grey60

" Vim script
highlight vimCommentTitle guifg=grey90      gui=bold
highlight vimGroupName    guifg=cornflowerblue

" C code
highlight cCppOut     guifg=#6060e0       guibg=#333340
highlight cCppOutIf2  guifg=#c0c0e0       guibg=#333340
highlight cParen      guifg=deepskyblue3
highlight cBlock      guifg=deepskyblue4

" Doxygen 
highlight doxygenComment    guifg=deepskyblue3  gui=none
highlight doxygenBrief      guifg=deepskyblue1  gui=none
highlight doxygenParam      guifg=grey38        gui=none
highlight doxygenOtherTODO  guifg=maroon3       gui=bold,underline
highlight doxygenOtherWARN  guifg=maroon3       gui=bold,underline
highlight! link doxygenSpecialOnelineDesc doxygenBrief

" vimdiff
highlight DiffChange    guifg=#f0f0f0 guibg=bg      gui=none
highlight DiffText      guifg=#c0c000 guibg=#303030 gui=none
highlight DiffAdd       guifg=#00c000 guibg=#383838 gui=none
highlight DiffDelete    guifg=bg      guibg=bg      gui=none

" diff buffer
highlight diffOldFile   guifg=fg
highlight diffNewFile   guifg=yellow2
highlight diffFile      guifg=yellow2
highlight diffOnly      guifg=yellow2
highlight diffIdentical guifg=fg
highlight diffDiffer    guifg=fg
highlight diffBDiffer   guifg=fg
highlight diffIsA       guifg=fg
highlight diffNoEOL     guifg=fg
highlight diffCommon    guifg=fg
highlight diffRemoved   guifg=fg gui=italic
highlight diffChanged   guifg=fg
highlight diffAdded     guifg=white gui=bold
highlight diffLine      guifg=yellow1
highlight diffSubname   guifg=fg
highlight diffComment   guifg=fg

" netrw
highlight netrwMarkFile gui=inverse

" asciidoc
highlight! link asciidocTitleUnderline Type

" html
highlight htmlH1 guifg=slateblue1 gui=bold
highlight htmlH2 guifg=slateblue1
highlight htmlH3 guifg=slateblue2
highlight htmlBold                gui=bold
highlight htmlItalic              gui=italic

" markdown
highlight! markdownCode guifg=green3 gui=italic
highlight! link markdownCodeBlock Comment
