
"
" Description:  This color theme uses color names, defined by X11 file
" 'rgb.txt'. Once you get used to the color names, it is quit easy to start or
" change a color theme file. IMO, more easier than hex numbers.

if exists("syntax_on")
  syntax reset
endif

highlight clear
set background=dark
let g:colors_name = "flintstone"

" very basic things
highlight Normal  guifg=white       guibg=grey15
highlight NonText guifg=dodgerblue1 guibg=bg              gui=none
highlight Visual                    guibg=grey24

" where is the cursor?
highlight LineNr        guifg=grey38    guibg=grey12      gui=none
highlight Cursor        guifg=black     guibg=goldenrod
highlight CursorLineNr  guifg=goldenrod guibg=grey16      gui=none
highlight CursorLine                    guibg=grey19
highlight! link CursorColumn CursorLine

" decorations
highlight VertSplit    guifg=grey27     guibg=bg          gui=none
highlight StatusLineNC guifg=white      guibg=grey20      gui=none
highlight StatusLine   guifg=white      guibg=grey30 gui=none
highlight User1        guifg=white      guibg=grey30 gui=bold
highlight User2        guifg=white      guibg=grey30 gui=none
highlight FoldColumn   guifg=grey80     guibg=bg
highlight Folded       guifg=grey27     guibg=bg          gui=NONE
highlight SignColumn   guifg=skyblue4   guibg=bg

" search
highlight IncSearch  guifg=white        guibg=dodgerblue3 gui=bold,underline
highlight Search     guifg=white        guibg=grey30 gui=none
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
highlight Statement     guifg=coral1          gui=none
highlight Conditional   guifg=coral2          gui=none
highlight PreProc       guifg=lightblue3      gui=bold
highlight Comment       guifg=slategray
highlight Type          guifg=paleturquoise3  gui=none
highlight StorageClass  guifg=coral3          gui=none
highlight Function      guifg=coral1          gui=bold
highlight Identifier    guifg=coral4
highlight Special       guifg=coral3
highlight Constant      guifg=cornflowerblue
highlight! link SpecialKey Special

highlight Title         guifg=goldenrod                   gui=none
highlight Subtitle      guifg=darkgoldenrod
highlight ToDo          guifg=white         guibg=coral3
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

" tune Doxygen highlighting
highlight doxygenComment guifg=deepskyblue3 gui=none
highlight doxygenBrief guifg=slategray4 gui=none
highlight doxygenParam guifg=slategray3 gui=none
highlight doxygenOtherTODO guifg=maroon3 gui=bold,underline
highlight doxygenOtherWARN guifg=maroon3 gui=bold,underline
highlight! link doxygenSpecialOnelineDesc doxygenBrief

" diffs
highlight DiffChange guifg=steelblue guibg=grey20 gui=none
highlight DiffAdd guifg=deepskyblue2 guibg=grey20 gui=none
highlight DiffDelete guifg=black guibg=bg guifg=bg gui=none
highlight DiffText guifg=white guibg=steelblue4 gui=none

highlight diffOldFile guifg=red
highlight diffNewFile guibg=darkslategray guifg=slategray
highlight diffFile guibg=darkslategray guifg=skyblue1
highlight diffOnly guibg=darkslategray guifg=fg
highlight diffIdentical guifg=fg
highlight diffDiffer guifg=darkslategray
highlight diffBDiffer guifg=fg
highlight diffIsA guifg=fg
highlight diffNoEOL guifg=fg
highlight diffCommon guifg=fg
highlight diffRemoved guifg=tomato
highlight diffChanged guifg=slategray
highlight diffAdded guifg=skyblue
highlight diffLine guifg=grey50
highlight diffSubname guifg=fg
highlight diffComment guifg=grey50

highlight! link rstHyperlinkReference Directory
highlight netrwMarkFile gui=inverse
