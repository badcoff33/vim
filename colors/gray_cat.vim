" Vim color theme
"
" Description: I like cats
"
"             |\\   _,,,---,,_
"     ZZzzz /,`.-'`'    -.  ;-;;,_
"          |,4-  ) )-,_. ,\\ (  `'-'
"         '---''(_/--'  `-'\\_)       ")

if exists("syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "gray_cat"

" basics
highlight Normal  guifg=grey25 guibg=grey95
highlight NonText guifg=paleturquoise2 guibg=grey97
highlight Visual  guifg=white  guibg=grey35
highlight Cursor  guifg=white  guibg=black

highlight NormalFloat  guifg=black guibg=azure3

" window decoration
highlight StatusLine   guifg=black guibg=grey80 gui=none
highlight StatusLineNC guifg=grey30 guibg=grey90 gui=none
highlight VertSplit    guifg=grey60 guibg=bg gui=none
highlight! link WildMenu IncSearch
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC

" line numbers / side decorations
highlight LineNr       guifg=grey80 guibg=bg gui=bold,italic
highlight CursorLine                guibg=grey97
highlight CursorLineNr guifg=grey30 guibg=bg gui=bold,italic
highlight SignColumn   guifg=grey30 guibg=bg
highlight! link FoldColumn Normal
highlight! link Folded NonText
highlight! link CursorColumn CursorLine

" tabs
highlight! link  TabLineFill StatusLineNC
highlight! link TabLine      StatusLineNC
highlight! link TabLineSel   StatusLine

" popup Menu
highlight Pmenu      guifg=black guibg=turquoise2 gui=none
highlight PmenuSel   guifg=white guibg=grey20 gui=bold
highlight PmenuSbar  guibg=fg
highlight PmenuThumb guifg=turquoise2

" search
highlight IncSearch  guifg=white guibg=dodgerblue gui=underline
highlight Search     guifg=black guibg=lightcyan3    gui=none
highlight MatchParen guifg=black guibg=lightcyan2 gui=bold

" code
highlight Statement    guifg=grey10      gui=bold
highlight Conditional  guifg=grey10      gui=bold
highlight Type         guifg=gray35      gui=none
highlight StorageClass guifg=grey40      gui=bold
highlight PreProc      guifg=black       gui=bold
highlight Comment      guifg=grey50      gui=none
highlight Identifier   guifg=grey30      gui=none
highlight Function     guifg=grey20      gui=none
highlight Special      guifg=grey30
highlight Constant     guifg=pink4

" misc
highlight Title     guifg=grey30
highlight Subtitle  guifg=grey30
highlight todo      guifg=grey30         guibg=bg
highlight Error     guifg=pink3 guibg=bg gui=undercurl
highlight Directory guifg=dodgerblue3    guibg=bg gui=underline

" messages
highlight WarningMsg guifg=black guibg=yellow2 gui=none
highlight ErrorMsg   guifg=black guibg=pink2 gui=none
highlight ModeMsg    guifg=white guibg=lightyellow4 gui=none
highlight Question   guifg=black guibg=lightyellow2 gui=none

" quickfix colors
highlight! link  QuickFixLine CursorLine
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

" Diff highlighting
highlight DiffText   guifg=black guibg=paleturquoise2 gui=bold
highlight DiffChange guifg=black guibg=paleturquoise1 gui=none
highlight DiffAdd    guifg=black guibg=paleturquoise1 gui=bold
highlight DiffDelete guifg=pink1 guibg=pink1

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
