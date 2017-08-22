" Vim color theme
" Name:         bleached
" Maintainer:   Markus Prepens (markus dot prepens at gmail dot com)
" Description:  This color theme uses color names, defined by X11 file
" 'rgb.txt'. Once you get used to the color names, it is quit easy to start or
" change a color theme file. IMO, more easier than hex numbers.

if exists("syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "bleached"

highlight Normal        guifg=grey25  guibg=white
highlight NonText       guifg=cyan3   guibg=bg
highlight Visual                      guibg=snow2

" cursor
highlight Cursor        guifg=white   guibg=cornflowerblue
highlight CursorLineNr  guibg=lightcyan1  guifg=cornflowerblue  gui=bold
highlight CursorLine    guibg=lightcyan1

" decorations
highlight StatusLine    gui=bold    guibg=paleturquoise4 guifg=paleturquoise1
highlight User1         gui=bold    guibg=paleturquoise4 guifg=paleturquoise1
highlight User2         gui=italic  guibg=paleturquoise4 guifg=paleturquoise1
highlight StatusLineNC  gui=none    guibg=paleturquoise3 guifg=white
highlight VertSplit     guibg=bg    guifg=grey85          gui=none
highlight LineNr        guibg=bg    guifg=lightblue2      gui=bold
highlight FoldColumn    guifg=skyblue4 guibg=bg
highlight Folded        guifg=grey60   guibg=grey95
highlight SignColumn    guifg=skyblue4 guibg=bg

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
highlight Todo      guifg=white guibg=gold2
highlight Error     guifg=coral2 guibg=bg gui=bold
highlight Directory guifg=steelblue3 gui=underline

highlight ErrorMsg    guifg=coral2    guibg=bg
highlight WarningMsg  guifg=goldenrod guibg=bg
highlight ModeMsg     guifg=fg        guibg=bg gui=bold
highlight Question    guifg=goldenrod guibg=bg

highlight qfLineNr    guifg=skyblue2
highlight qfFileName  guifg=skyblue4  gui=underline
highlight qfSeparator guifg=grey30

" Tune Doxygen highlighting
highlight doxygenComment            guifg=steelblue4   gui=none
highlight doxygenBody               guifg=deepskyblue3 gui=none
highlight doxygenBrief              guifg=dodgerblue4  gui=none
highlight doxygenParam              guifg=skyblue1     gui=none
highlight doxygenSpecial            guifg=skyblue3 gui=none
highlight doxygenSpecialOnelineDesc guifg=skyblue3

highlight DiffChange guifg=black guibg=bg         gui=none
highlight DiffAdd    guifg=black guibg=grey85     gui=bold
highlight DiffDelete guifg=pink1 guibg=pink1      gui=none
highlight DiffText   guifg=black guibg=grey85     gui=bold

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

highlight netrwMarkFile gui=inverse

" html
highlight htmlH1 guifg=skyblue1  gui=bold
highlight htmlH2 guifg=skyblue3  gui=none
highlight htmlH3 guifg=skyblue3  gui=none

