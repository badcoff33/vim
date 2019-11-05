" Vim color theme
" Name:        Angry Bee
" Maintainer:  Markus Prepens

if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark
let g:colors_name = "angrybee"

" basics
highlight Normal    guifg=#d8d8d8  guibg=#2d2d3a gui=none
highlight NonText   guifg=#4285F4  guibg=#18242e gui=none
highlight Cursor    guifg=#000000  guibg=#ffffff gui=none
highlight Visual    guifg=#bfbfca  guibg=#585863 gui=none

" used if Nvim's option 'winhighlight' exists (Nvim)
if has ('nvim')
  highlight NormalFloat   guifg=#aad0b8 guibg=#28202f 
  highlight NormalFocus   guibg=#2d2d3a
  highlight NormalNoFocus guibg=#18242e
  "set winhighlight=Normal:Normal,NormalNC:NormalNoFocus
endif

" Decoration
highlight StatusLineNC  guifg=#a0a000   guibg=#1f2836  gui=none
highlight StatusLine    guifg=#eeee00   guibg=#434356  gui=none
highlight User1         guifg=#ddeeff   guibg=#405880  gui=none
highlight User2         guifg=#40eeee   guibg=#405880  gui=none
highlight User3         guifg=#40eeee   guibg=#405880  gui=none
highlight VertSplit     guifg=#606060   guibg=bg       gui=none
highlight LineNr        guifg=#405060   guibg=bg       gui=none
highlight CursorLineNr  guifg=#506575   guibg=#303540  gui=bold
highlight CursorLine                    guibg=#202020
highlight QuickFixLine  guifg=#e0c040   guibg=bg       gui=bold
highlight FoldColumn    guifg=#405060   guibg=bg       gui=none
highlight Folded        guifg=fg        guibg=bg       gui=none
highlight SignColumn    guifg=#e0e0e0   guibg=bg       gui=none
highlight PmenuSel      guifg=#000000   guibg=#80e0e0  gui=bold
highlight Pmenu         guifg=#000000   guibg=#40a0a0  gui=none
highlight PmenuSbar     guifg=#ffffff   guibg=#6090f8  gui=none
highlight PmenuThumb    guifg=#ffffff   guibg=#2050c0  gui=none

highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link CursorColumn CursorLine
highlight! link WildMenu     PmenuSel
highlight! link TabLineFill  Normal
highlight! link TabLine      StatusLineNC
highlight! link TabLineSel   StatusLine

" Search
highlight IncSearch     guifg=#202020  guibg=#d0d0d0 gui=none
highlight Search        guifg=#d0e0e0  guibg=#204850 gui=underline
highlight MatchParen    guifg=#40e0e0  guibg=bg      gui=underline

" Structure
highlight Statement     guifg=#e0c040   guibg=bg      gui=bold
highlight Conditional   guifg=#c0c000   guibg=bg      gui=bold
highlight Type          guifg=#70d0d0   guibg=bg      gui=none
highlight Structure     guifg=#808080   guibg=bg      gui=none
highlight StorageClass  guifg=#b0d040   guibg=bg      gui=none
highlight PreProc       guifg=#d0d040   guibg=bg      gui=none
highlight PreCondit     guifg=#d0d040   guibg=bg      gui=bold
highlight Comment       guifg=#6090b0   guibg=bg      gui=none
highlight Function      guifg=#f8f8f8   guibg=bg      gui=bold
highlight Identifier    guifg=#00c8d8   guibg=bg      gui=none
highlight Special       guifg=#c0c040   guibg=bg      gui=none
highlight Constant      guifg=#88e0e0   guibg=bg      gui=none
highlight Number        guifg=#f0c070   guibg=bg      gui=none

highlight Title         guifg=fg        guibg=bg      gui=bold
highlight Subtitle      guifg=fg        guibg=bg      gui=bold,underline
highlight Todo          guifg=#f0f000   guibg=#505000 gui=none
highlight Error         guifg=#c00000   guibg=bg      gui=none
highlight Directory     guifg=fg        guibg=bg      gui=none

highlight ErrorMsg      guifg=fg        guibg=bg      gui=bold
highlight WarningMsg    guifg=fg        guibg=bg      gui=bold
highlight ModeMsg       guifg=fg        guibg=bg      gui=bold
highlight Question      guifg=fg        guibg=bg      gui=bold

" quickfix
highlight qfFileName  guifg=#a0a0a0     guibg=bg    gui=none
highlight qfSeparator guifg=#808080     guibg=bg    gui=none

highlight! link qfLineNr LineNr

" Filetype Vim
highlight vimHiKeyList      guifg=#e0e0e0
highlight vimCommentTitle   guifg=#e0e0e0 gui=bold

" Filetype C
highlight cCppOut       guifg=#00c0c0
highlight cCppOutIf2    guifg=#00c0c0
highlight cParen        guifg=#00c0c0
highlight cBlock        guifg=#00c0c0

" Doxygen highlighting used when let b:load_doxygen_syntax=1
highlight doxygenComment            guifg=#009090 gui=none
highlight doxygenBody               guifg=#40b0b0 gui=none
highlight doxygenBrief              guifg=#00c0c0 gui=bold
highlight doxygenParam              guifg=#009090 gui=none
highlight doxygenParamName          guifg=#00d0c0 gui=none
highlight doxygenParamDirection     guifg=#009090 gui=none
highlight doxygenSpecial            guifg=#009090 gui=none
highlight doxygenSpecialOnelineDesc guifg=#008181 gui=none
highlight doxygenRefWord            guifg=#009090 gui=underline

highlight! link doxygenParamName doxygenRefWord
highlight! link doxygenHeaderLine doxygenBrief

" Vimdiff
highlight DiffChange    guifg=#f0f0f0 guibg=#1e2e38 gui=none
highlight DiffText      guifg=#c0c090 guibg=#2e4040 gui=none
highlight DiffAdd       guifg=#90c090 guibg=#2e3e48 gui=none
highlight DiffDelete    guifg=#981e2e guibg=bg gui=none

" Diff buffer
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
highlight diffRemoved   guifg=fg      gui=italic
highlight diffChanged   guifg=fg
highlight diffAdded     guifg=white   gui=bold
highlight diffLine      guifg=yellow1
highlight diffSubname   guifg=fg
highlight diffComment   guifg=fg

" netrw
highlight netrwMarkFile          gui=inverse

" filetype html
highlight htmlH1 guifg=skyblue1  gui=bold
highlight htmlH2 guifg=skyblue3  gui=bold
highlight htmlH3 guifg=skyblue3  gui=bold
highlight htmlBold               gui=bold
highlight htmlItalic             gui=italic

" markdown
highlight! link markdownCode String
highlight! link markdownCodeBlock Comment
