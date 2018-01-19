" Vim color theme
" Name:         bleached
" Maintainer:   Markus Prepens (markus dot prepens at gmail dot com)
" Description:  This color theme uses color names, defined by X11 file
" 'rgb.txt'. Once you get used to the color names, it is quit easy to start or
" change a color theme file. IMO, more easier than hex numbers.
" TODO 

if exists("syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "bleached"

highlight Normal        guifg=grey25      guibg=snow1
highlight NonText       guifg=cyan3       guibg=bg
highlight Visual                          guibg=azure2

" cursor
highlight Cursor        guifg=white           guibg=slateblue4
highlight CursorLineNr  guifg=cornflowerblue  guibg=snow2   gui=bold
highlight CursorLine                          guibg=snow2

" decorations
highlight StatusLine    guifg=white           guibg=turquoise3      gui=bold
highlight User1         guifg=white           guibg=turquoise3      gui=bold
highlight User2         guifg=white           guibg=turquoise3      gui=italic
highlight StatusLineNC  guifg=turquoise4      guibg=paleturquoise2  gui=none
highlight VertSplit     guifg=paleturquoise3  guibg=bg              gui=none
highlight LineNr        guifg=lightblue2      guibg=bg              gui=bold
highlight FoldColumn    guifg=skyblue4        guibg=bg
highlight Folded        guifg=grey60          guibg=grey95
highlight SignColumn    guifg=skyblue4        guibg=bg

highlight! link WildMenu      PmenuSel
highlight! link TabLineFill   Normal
highlight! link TabLine       StatusLineNC
highlight! link TabLineSel    StatusLine
highlight! link CursorColumn  CursorLine

" popup menu set set
highlight! link Pmenu Search
highlight! link PmenuSel IncSearch
highlight  PmenuSbar guibg=grey50
highlight  PmenuThumb guifg=white

highlight Search guifg=cyan4 guibg=lightcyan2 gui=bold
highlight IncSearch guifg=hotpink4 guibg=pink1 gui=bold
highlight MatchParen guibg=bg gui=underline

highlight Statement     guifg=hotpink3 gui=bold
highlight Conditional   guifg=hotpink2 gui=bold
highlight Function      guifg=hotpink4 gui=bold
highlight Type          guifg=steelblue3 gui=none
highlight StorageClass  guifg=maroon2 gui=none
highlight PreProc       guifg=steelblue4 gui=none
highlight Comment       guifg=slategray
highlight Identifier    guifg=aquamarine4
highlight Special       guifg=skyblue3
highlight Constant      guifg=turquoise4

highlight Title     guifg=steelblue2
highlight Subtitle  guifg=steelblue3
highlight Todo      guifg=gold3 guibg=lightyellow gui=bold
highlight Error     guifg=coral2 guibg=bg gui=bold
highlight Directory guifg=steelblue3 gui=underline

highlight ErrorMsg    guifg=coral2    guibg=bg
highlight WarningMsg  guifg=goldenrod guibg=bg
highlight ModeMsg     guifg=fg        guibg=bg gui=bold
highlight Question    guifg=goldenrod guibg=bg

highlight qfLineNr     guifg=skyblue2
highlight qfFileName   guifg=skyblue4  gui=underline
highlight qfSeparator  guifg=grey30
highlight QuickFixLine gui=bold

" Tune Doxygen highlighting
highlight doxygenComment            guifg=steelblue4   gui=none
highlight doxygenBody               guifg=deepskyblue3 gui=none
highlight doxygenBrief              guifg=dodgerblue4  gui=none
highlight doxygenParam              guifg=skyblue1     gui=none
highlight doxygenSpecial            guifg=skyblue3 gui=none
highlight doxygenSpecialOnelineDesc guifg=skyblue3

highlight DiffChange             guibg=grey96
highlight DiffAdd                guibg=grey89
highlight DiffDelete guifg=pink1 guibg=pink1
highlight DiffText               guibg=grey89

highlight diffOldFile     guifg=red
highlight diffNewFile     guifg=dodgerblue4 guibg=bg
highlight diffFile        guifg=dodgerblue4 guibg=bg
highlight diffOnly        guifg=dodgerblue4 guibg=bg
highlight diffLine        guifg=fg          guibg=paleturquoise3
highlight diffIdentical   guifg=fg
highlight diffDiffer      guifg=darkslategray
highlight diffBDiffer     guifg=fg
highlight diffIsA         guifg=fg
highlight diffNoEOL       guifg=fg
highlight diffCommon      guifg=fg
highlight diffRemoved     guifg=coral3
highlight diffChanged     guifg=dodgerblue3
highlight diffAdded       guifg=turquoise3
highlight diffSubname     guifg=fg
highlight diffComment     guifg=grey50

" netrw
highlight netrwMarkFile gui=inverse

" filetype html
highlight htmlH1 guifg=skyblue1  gui=bold
highlight htmlH2 guifg=skyblue3  gui=none
highlight htmlH3 guifg=skyblue3  gui=none

" markdown
highlight! link markdownCode String
highlight! link markdownCodeBlock Comment

