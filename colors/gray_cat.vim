" Vim color theme
"
" Description: A light one with fresh colors.

if exists("syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "gray_cat"

" basics
highlight Normal  guifg=grey30 guibg=white
highlight NonText guifg=grey50 guibg=grey96
highlight Visual  guifg=white  guibg=grey35
highlight Cursor  guifg=white  guibg=palevioletred3

highlight NormalFloat  guifg=black guibg=azure3

" window decoration
highlight StatusLine   guifg=grey90 guibg=grey10 gui=bold
highlight StatusLineNC guifg=grey30 guibg=grey90 gui=italic
highlight VertSplit    guifg=grey80 guibg=grey80 gui=italic
highlight! link WildMenu IncSearch
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC

" line numbers / side decorations
highlight LineNr       guifg=grey80 guibg=bg gui=bold,italic
highlight CursorLine                guibg=grey97
highlight CursorColumn              guibg=bg
highlight CursorLineNr guifg=grey30 guibg=bg gui=bold,italic
highlight SignColumn   guifg=grey30 guibg=bg
highlight! link FoldColumn Normal
highlight! link Folded NonText

" tabs
highlight TabLineFill guifg=grey30 guibg=bg gui=NONE
highlight TabLine     guifg=grey30 guibg=bg gui=none
highlight TabLineSel  guifg=grey30 guibg=bg gui=bold,underline

" popup Menu
highlight Pmenu      guifg=black guibg=turquoise2 gui=none
highlight PmenuSel   guifg=white guibg=turquoise4 gui=bold
highlight PmenuSbar  guibg=fg
highlight PmenuThumb guifg=grey30

" search
highlight IncSearch  guifg=black  guibg=yellow1 gui=bold
highlight Search     guifg=white  guibg=grey60  gui=none
highlight MatchParen guifg=grey10 guibg=bg      gui=underline

" code
highlight Statement    guifg=grey10      gui=bold
highlight Conditional  guifg=grey20      gui=bold
highlight Type         guifg=aquamarine4 gui=none
highlight StorageClass guifg=grey60      gui=bold
highlight PreProc      guifg=grey10      gui=bold
highlight Comment      guifg=grey65
highlight Identifier   guifg=grey55      gui=italic
highlight Special      guifg=grey30
highlight Constant     guifg=palevioletred3

" misc
highlight Title     guifg=grey30
highlight Subtitle  guifg=grey30
highlight todo      guifg=grey30         guibg=bg
highlight Error     guifg=palevioletred3 guibg=bg gui=undercurl
highlight Directory guifg=dodgerblue3    guibg=bg gui=underline

" messages
highlight WarningMsg guifg=steelblue      guibg=bg gui=none
highlight ErrorMsg   guifg=orangered      guibg=bg gui=none
highlight ModeMsg    guifg=palevioletred4 guibg=bg gui=bold
highlight Question   guifg=palevioletred4 guibg=bg gui=bold

" quickfix colors
highlight QuickFixLine guibg=bg          gui=bold
highlight qfFileName   guifg=dodgerblue4 gui=none
highlight qfLineNr     guifg=grey40
highlight qfSeparator  guifg=grey50

" Doxygen highlighting
highlight doxygenComment            guifg=grey40 gui=none
highlight doxygenBrief              guifg=black  gui=bold
highlight doxygenParam              guifg=grey60 gui=italic
highlight doxygenRefWord            guifg=grey40 gui=underline
highlight doxygenSpecial            guifg=grey50 gui=none
highlight doxygenSpecialOnelineDesc guifg=grey30

highlight diffRemoved guifg=firebrick3
highlight diffChanged guifg=steelblue3
highlight diffAdded guifg=forestgreen

" Diff highlighting
highlight DiffText guifg=grey30 guibg=grey85 gui=none
highlight! link DiffChange diffChanged
highlight! link DiffAdd diffAdded
highlight! link DiffDelete diffRemoved

" netrw
highlight netrwMarkFile gui=inverse

" html
highlight htmlH1     guifg=black      gui=bold
highlight htmlH2     guifg=steelblue3 gui=bold
highlight htmlH3     guifg=steelblue4 gui=none
highlight htmlBold   gui=bold
highlight htmlItalic gui=italic

" markdown
highlight! link markdownCode String
highlight! link markdownCodeBlock Comment
