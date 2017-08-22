" Vim color theme

if exists("syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "breeze"

" basics
highlight Normal  guifg=grey30 guibg=white
highlight NonText guifg=cyan4  guibg=bg
highlight Visual  guifg=white  guibg=cornflowerblue
highlight Cursor  guifg=white  guibg=orange1

" window decoration
highlight StatusLine   guifg=white  guibg=cornflowerblue gui=none
highlight User1        guifg=white  guibg=cornflowerblue gui=bold
highlight User2        guifg=white  guibg=cornflowerblue gui=none
highlight StatusLineNC guifg=grey50 guibg=grey85         gui=none
highlight VertSplit    guifg=grey85 guibg=grey85
highlight! link WildMenu IncSearch

" line numbers / side decorations
highlight LineNr        guifg=azure3    guibg=bg      gui=bold,italic
highlight CursorLine                    guibg=grey96
highlight CursorColumn                  guibg=grey96
highlight CursorLineNr  guifg=azure3    guibg=grey96  gui=bold,italic
highlight SignColumn    guifg=skyblue4  guibg=bg
highlight FoldColumn    guifg=skyblue4  guibg=bg
highlight Folded        guifg=fg        guibg=bg      gui=NONE

" tabs
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel StatusLine

" popup Menu
highlight Pmenu       guibg=grey90
highlight PmenuSel    guibg=grey70
highlight PmenuSbar   guibg=grey50
highlight PmenuThumb  guifg=white

" search
highlight IncSearch   guifg=white  guibg=dodgerblue3  gui=none
highlight Search      guifg=azure4 guibg=azure2       gui=none
highlight MatchParen  guifg=fg     guibg=bg           gui=underline

" code
highlight Statement     guifg=maroon3     gui=none
highlight Conditional   guifg=maroon3     gui=none
highlight Type          guifg=skyblue3    gui=none
highlight StorageClass  guifg=blue4       gui=none
highlight PreProc       guifg=dodgerblue2 gui=none
highlight Comment       guifg=forestgreen
highlight Identifier    guifg=aquamarine4
highlight Special       guifg=aquamarine4
highlight Constant      guifg=goldenrod4

" misc
highlight Title     guifg=steelblue2
highlight Subtitle  guifg=steelblue3
highlight todo      guifg=darkseagreen4 guibg=darkseagreen1
highlight Error     guifg=deeppink3     guibg=pink1 gui=none
highlight Directory guifg=steelblue3                gui=underline

" messages
highlight  WarningMsg guifg=forestgreen guibg=bg  gui=none
highlight  ErrorMsg   guifg=coral3      guibg=bg  gui=none
highlight! link ModeMsg   StatusLine
highlight! link Question  StatusLine

" quickfix colors
highlight qfFileName  guifg=dodgerblue3 gui=underline
highlight qfLineNr    guifg=dodgerblue4
highlight qfSeparator guifg=dodgerblue4

" Doxygen highlighting
highlight doxygenComment            guifg=darkseagreen4 gui=none
highlight doxygenBrief              guifg=seagreen4     gui=bold
highlight doxygenParam              guifg=seagreen3     gui=none
highlight doxygenSpecial            guifg=darkseagreen3 gui=none
highlight doxygenSpecialOnelineDesc guifg=darkseagreen3

" Diff highlighting
highlight DiffChange  guifg=black       guibg=yellow2     gui=none
highlight DiffAdd     guifg=black       guibg=lightblue1  gui=none
highlight DiffDelete  guifg=bg          guibg=bg          gui=none
highlight DiffText    guifg=black       guibg=yellow3     gui=none

highlight diffOldFile   guifg=red
highlight diffNewFile   guifg=seagreen4
highlight diffFile      guifg=dodgerblue3
highlight diffOnly      guifg=fg
highlight diffIdentical guifg=fg
highlight diffDiffer    guifg=darkslategray
highlight diffBDiffer   guifg=fg
highlight diffIsA       guifg=fg
highlight diffNoEOL     guifg=fg
highlight diffCommon    guifg=fg
highlight diffRemoved   guifg=seagreen3
highlight diffChanged   guifg=slategray
highlight diffAdded     guifg=skyblue3
highlight diffLine      guifg=grey50
highlight diffSubname   guifg=fg
highlight diffComment   guifg=grey50

highlight netrwMarkFile     gui=inverse
highlight AutoPreviewTagHl  guibg=yellow
