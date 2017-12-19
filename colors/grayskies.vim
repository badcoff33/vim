" Vim color theme
"
" Name:        Grayskies
" Maintainer:  Markus Prepens

if exists("syntax_on")
 syntax reset
endif

hi clear
set background=light
let g:colors_name = "grayskies"

" Basics
highlight  Normal       gui=none    guifg=#404040   guibg=#ffffff
highlight  NonText      gui=none    guifg=#4285F4   guibg=bg
highlight  Cursor       gui=none    guifg=#ffffff   guibg=#454565
highlight  Visual       gui=none    guifg=fg        guibg=#b9b9b9

" Decoration
highlight StatusLine    guifg=#f0f0f0   guibg=#505050  gui=none
highlight User1         guifg=#f0f0f0   guibg=#505050  gui=bold
highlight User2         guifg=#f0f0f0   guibg=#505050  gui=italic
highlight StatusLineNC  guifg=#f8f8f8   guibg=#b9b9c0  gui=none
highlight VertSplit     guifg=#a8a8a8   guibg=bg       gui=none
highlight WildMenu      guifg=#000000   guibg=#80c0ff  gui=none
highlight LineNr        guifg=#aaaaa0   guibg=bg       gui=none
highlight CursorLine                    guibg=#efefef
highlight CursorLineNr  guifg=#cc0000   guibg=bg       gui=none
highlight FoldColumn    guifg=#c0c0e0   guibg=bg       gui=none
highlight Folded        guifg=fg        guibg=bg       gui=none
highlight SignColumn    guifg=#e0e0e0   guibg=bg       gui=none
highlight Pmenusel      guifg=#ffffff   guibg=#30a0d0  gui=bold
highlight Pmenu         guifg=#ffffff   guibg=#30d0ff  gui=none
highlight PmenuSbar     guifg=#ffffff   guibg=#6090f8  gui=none
highlight PmenuThumb    guifg=#ffffff   guibg=#2050c0  gui=none

highlight! link CursorColumn CursorLine
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel StatusLine

" Search
highlight IncSearch     guifg=#ffffff   guibg=#404040   gui=underline,bold
highlight Search        guifg=#303050   guibg=#e0e0e8   gui=none
highlight MatchParen    guisp=#000090   guibg=bg        gui=underline,bold

" Structure
highlight Statement     guifg=#656585    guibg=bg    gui=bold
highlight Conditional   guifg=#606090    guibg=bg    gui=bold
highlight Type          guifg=#709070    guibg=bg    gui=none
highlight Structure     guifg=#404040    guibg=bg    gui=none
highlight StorageClass  guifg=#707090    guibg=bg    gui=none
highlight PreProc       guifg=#606060    guibg=bg    gui=bold
highlight Comment       guifg=#505090    guibg=bg    gui=none
highlight Identifier    guifg=#b09090    guibg=bg    gui=none
highlight Function      guifg=#b09090    guibg=bg    gui=bold
highlight Special       guifg=#303060    guibg=bg    gui=none
highlight Constant      guifg=#506040    guibg=bg    gui=none

highlight Title         guifg=#c09090    guibg=bg   gui=none
highlight Subtitle      guifg=#c09090    guibg=bg   gui=none
highlight Todo          guifg=#c09090    guibg=bg   gui=none
highlight Error         guifg=#c09090    guibg=bg   gui=none
highlight Directory     guifg=#506080    guibg=bg   gui=underline

highlight ErrorMsg      guifg=#a07070   guibg=bg    gui=bold
highlight WarningMsg    guifg=#70a070   guibg=bg    gui=bold
highlight ModeMsg       guifg=#a0a0a0   guibg=bg    gui=bold
highlight Question      guifg=#7070a0   guibg=bg    gui=bold

" quickfix
highlight qfLineNr    guifg=#9090c0     guibg=bg    gui=none
highlight qfFileName  guifg=#b0b0b0     guibg=bg    gui=underline
highlight qfSeparator guifg=#909090     guibg=bg    gui=none

" C
highlight cCppOut guibg=#f0f0f0 guifg=#909090
highlight cCppOutIf2 guibg=#e3e3e3
highlight cParen guifg=deepskyblue3
highlight cBlock guifg=deepskyblue4

" Doxygen highlighting used when let b:load_doxygen_syntax=1
highlight doxygenComment            guifg=#505080 gui=none
highlight doxygenBody               guifg=#505080 gui=none
highlight doxygenBrief              guifg=#408040 gui=none
highlight doxygenParam              guifg=#505080 gui=none
highlight doxygenParamDirection     guifg=#505080 gui=none
highlight doxygenSpecial            guifg=#505080 gui=none
highlight doxygenSpecialOnelineDesc guifg=#505080 gui=none
highlight doxygenRefWord            guifg=#505080 gui=underline

highlight! link doxygenParamName doxygenRefWord
highlight! link doxygenHeaderLine doxygenBrief

" VimDiff
highlight DiffChange    guifg=#000000 guibg=bg      gui=none
highlight DiffAdd       guifg=#000000 guibg=#e0f8f8 gui=none
highlight DiffDelete    guifg=bg      guibg=bg     gui=none
highlight DiffText      guifg=#000000 guibg=#ffe0e0 gui=none

" Highlight Diffs
highlight diffOldFile   guifg=red guibg=bg      gui=none
highlight diffNewFile   guifg=#3080a0   guibg=bg gui=bold
highlight diffFile      guifg=#30a080   guibg=bg gui=bold
highlight diffLine      guifg=#101030   guibg=bg gui=bold
highlight diffAdded     guifg=#202040   guibg=bg gui=bold
highlight diffRemoved   guifg=#606070   guibg=bg gui=italic
highlight diffChanged   guifg=#404070   guibg=bg gui=bold
highlight diffOnly      guifg=#404070   guibg=bg gui=none
highlight diffIdentical guifg=#606090   guibg=bg gui=none
highlight diffDiffer    guifg=#101040   guibg=bg gui=none

"  vim
hi vimHiAttrib          guifg=#406040 guibg=bg gui=none

" netrw
highlight netrwMarkFile gui=inverse

" html
highlight htmlH1 guifg=skyblue1  gui=bold
highlight htmlH2 guifg=skyblue3  gui=none
highlight htmlH3 guifg=skyblue3  gui=none

" markdown
highlight! link markdownCode String
highlight! link markdownCodeBlock Comment

