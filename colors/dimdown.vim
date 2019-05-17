" Vim color theme
"
" Description: This color theme uses color names, defined by X11 file
" 'rgb.txt'. Once you get used to the color names, it is quit easy to start or
" change a color theme file. IMO, more easier than hex numbers.
" Here is a nice list of colors: 'https://en.wikipedia.org/wiki/X11_color_names'

if exists("syntax_on")
  syntax reset
endif

highlight clear
set background=dark
let g:colors_name = "dimdown"

" very basic things
highlight Normal guifg=grey85 guibg=grey16 ctermbg=black
highlight NonText guifg=skyblue1 guibg=bg gui=none
highlight Visual guifg=grey20 guibg=grey80

" used if Nvim's option 'winhighlight' exists (Nvim)
if has ('nvim')
  highlight NormalFocus guibg=grey13
  highlight NormalNoFocus guibg=grey16
  set winhighlight=Normal:NormalFocus,NormalNC:NormalNoFocus
endif

" where is the cursor?
highlight LineNr guifg=grey38 guibg=bg gui=none
highlight Cursor guifg=white guibg=lightblue3
highlight CursorLineNr guifg=grey38 guibg=grey17 gui=bold
highlight QuickFixLine guibg=bg gui=bold
highlight CursorLine guibg=grey19
highlight! link CursorColumn CursorLine

" decorations
highlight VertSplit guifg=grey27 guibg=bg gui=none
highlight StatusLineNC guifg=grey48 guibg=grey20 gui=none
highlight StatusLine guifg=white guibg=grey30 gui=none
highlight User1 guifg=skyblue2 guibg=grey30 gui=bold cterm=inverse
highlight User2 guifg=skyblue1 guibg=grey30 gui=none cterm=inverse
highlight User3 guifg=skyblue1 guibg=grey30 gui=none cterm=inverse
highlight FoldColumn guifg=skyblue3 guibg=bg gui=none ctermbg=bg
highlight Folded guifg=skyblue3 guibg=bg gui=NONE
highlight SignColumn guifg=skyblue4 guibg=bg
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC

" search
highlight IncSearch guifg=white guibg=indianred2 gui=bold
highlight Search guifg=fg guibg=grey35 gui=bold
highlight MatchParen guifg=cyan2 guibg=bg gui=underline

" popup Menu
highlight Pmenu guifg=white guibg=deepskyblue gui=none 
highlight PmenuSel guifg=white guibg=deepskyblue gui=bold 
highlight PmenuSbar guibg=lightblue4
highlight PmenuThumb guifg=white guibg=lightblue4
highlight! link WildMenu IncSearch

" tab line
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel StatusLine

" code
highlight Statement guifg=coral3 gui=none
highlight Conditional guifg=indianred3 gui=none
highlight PreProc guifg=skyblue1 gui=none
highlight Comment guifg=lightblue
highlight Type guifg=indianred3 gui=none
highlight StorageClass guifg=coral3 gui=none
highlight Function guifg=coral1 gui=none
highlight Identifier guifg=skyblue2
highlight Special guifg=indianred3
highlight Constant guifg=lightblue2
highlight! link SpecialKey Special

highlight Title guifg=skyblue1 gui=none
highlight Subtitle guifg=skyblue1
highlight ToDo guifg=skyblue2 guibg=bg gui=bold
highlight Error guifg=tomato3 guibg=bg gui=undercurl
highlight Directory guifg=skyblue1 gui=underline

" messages
highlight ErrorMsg guifg=yellow2 guibg=bg gui=none
highlight WarningMsg guifg=yellow2 guibg=bg gui=none
highlight ModeMsg guifg=yellow2 guibg=bg gui=none
highlight Question guifg=yellow2 guibg=bg gui=none
highlight MoreMsg guifg=yellow2 guibg=bg gui=none

" quickfix
highlight! link qfLineNr LineNr 
highlight qfFileName guifg=lightblue2 gui=underline
highlight qfSeparator guifg=fg
highlight qfError guifg=grey60

" Vim script
highlight vimCommentTitle guifg=grey90 gui=bold
highlight vimGroupName guifg=grey85

" C code
highlight cCppOut guifg=#6060e0 guibg=#333340
highlight cCppOutIf2 guifg=#c0c0e0 guibg=#333340
highlight cParen guifg=deepskyblue3
highlight cBlock guifg=deepskyblue4

" Doxygen 
highlight doxygenComment guifg=grey55 gui=none
highlight doxygenBrief guifg=grey66 gui=none
highlight doxygenParam guifg=grey40 gui=none
highlight doxygenOtherTODO guifg=indianred3 gui=bold,underline
highlight doxygenOtherWARN guifg=indianred3 gui=bold,underline
highlight! link DoxygenBody Comment 
highlight! link doxygenSpecialOnelineDesc doxygenBrief

highlight DiffChange guifg=cyan4 guibg=white gui=none
highlight DiffText guifg=white guibg=white gui=none
highlight DiffAdd guifg=white guibg=white gui=none
highlight DiffDelete guifg=indianred4 guibg=bg gui=none

" diff buffer
highlight diffOldFile guifg=fg
highlight diffNewFile guifg=yellow2
highlight diffFile guifg=yellow2
highlight diffOnly guifg=yellow2
highlight diffIdentical guifg=fg
highlight diffDiffer guifg=fg
highlight diffBDiffer guifg=fg
highlight diffIsA guifg=fg
highlight diffNoEOL guifg=fg
highlight diffCommon guifg=fg
highlight diffRemoved guifg=fg gui=italic
highlight diffChanged guifg=fg
highlight diffAdded guifg=white gui=bold
highlight diffLine guifg=yellow1
highlight diffSubname guifg=fg
highlight diffComment guifg=fg

" netrw
highlight netrwMarkFile gui=inverse

" asciidoc
highlight! link asciidocTitleUnderline Type

" html
highlight htmlH1 guifg=deepskyblue gui=bold
highlight htmlH2 guifg=deepskyblue
highlight htmlH3 guifg=deepskyblue
highlight htmlBold gui=bold
highlight htmlItalic gui=italic

" markdown
highlight! link markdownCode Comment
highlight! link markdownCodeBlock Comment
