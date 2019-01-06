" Vim color theme
"
" Description:  This color theme uses color names, defined by X11 file
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
highlight Normal  guifg=grey85      guibg=grey16          ctermbg=black
highlight NonText guifg=dodgerblue1 guibg=bg              gui=none
highlight Visual  guifg=cadetblue1  guibg=grey30

" used if Nvim's option 'winhighlight' exists (Nvim)
if has ('nvim')
  highlight NormalFocus   guibg=grey13
  highlight NormalNoFocus guibg=grey16
  set winhighlight=Normal:NormalFocus,NormalNC:NormalNoFocus
endif

" where is the cursor?
highlight LineNr        guifg=grey38    guibg=bg          gui=none
highlight Cursor        guifg=black     guibg=cadetblue1
highlight CursorLineNr  guifg=grey38    guibg=grey17      gui=bold
highlight QuickFixLine                  guibg=bg          gui=bold
highlight CursorLine                    guibg=grey19
highlight! link CursorColumn CursorLine

" decorations
highlight VertSplit    guifg=grey27     guibg=bg     gui=none
highlight StatusLineNC guifg=grey48     guibg=grey20 gui=none
highlight StatusLine   guifg=white      guibg=grey30 gui=none
highlight User1        guifg=cadetblue2 guibg=grey30 gui=bold cterm=inverse
highlight User2        guifg=white      guibg=grey30 gui=none cterm=inverse
highlight User3        guifg=white      guibg=grey30 gui=none cterm=inverse
highlight FoldColumn   guifg=cadetblue3 guibg=bg     gui=none ctermbg=bg
highlight Folded       guifg=cadetblue3 guibg=bg     gui=NONE
highlight SignColumn   guifg=skyblue4   guibg=bg
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC

" search
highlight IncSearch  guifg=white  guibg=hotpink2 gui=bold
highlight Search     guifg=fg     guibg=grey35   gui=bold
highlight MatchParen guifg=cyan2  guibg=bg       gui=underline

" popup Menu
highlight Pmenu      guifg=white guibg=peachpuff3 gui=none 
highlight PmenuSel   guifg=white guibg=peachpuff4 gui=bold 
highlight PmenuSbar              guibg=lightblue4
highlight PmenuThumb guifg=white guibg=lightblue4
highlight! link WildMenu IncSearch

" tab line
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel StatusLine

" code
highlight Statement     guifg=lightblue4     gui=bold
highlight Conditional   guifg=lightblue4     gui=none
highlight PreProc       guifg=cadetblue3 gui=bold
highlight Comment       guifg=lightblue2
highlight Type          guifg=hotpink2       gui=none
highlight StorageClass  guifg=hotpink3       gui=none
highlight Function      guifg=hotpink1       gui=bold
highlight Identifier    guifg=hotpink2
highlight Special       guifg=hotpink3
highlight Constant      guifg=peachpuff
highlight! link SpecialKey Special

highlight Title     guifg=cadetblue1 gui=none
highlight Subtitle  guifg=cadetblue1
highlight ToDo      guifg=cadetblue2 guibg=bg gui=bold
highlight Error     guifg=white      guibg=tomato3
highlight Directory guifg=skyblue2   gui=underline

" messages
highlight ErrorMsg   guifg=coral2 guibg=bg gui=none
highlight WarningMsg guifg=coral2 guibg=bg gui=none
highlight ModeMsg    guifg=coral2 guibg=bg gui=none
highlight Question   guifg=coral2 guibg=bg gui=none
highlight MoreMsg    guifg=coral2 guibg=bg gui=none

" quickfix
highlight qfLineNr    guifg=lightblue2
highlight qfFileName  guifg=lightblue3 gui=underline
highlight qfSeparator guifg=fg
highlight qfError     guifg=grey60

" Vim script
highlight vimCommentTitle guifg=grey90      gui=bold
highlight vimGroupName    guifg=lightblue

" C code
highlight cCppOut     guifg=#6060e0       guibg=#333340
highlight cCppOutIf2  guifg=#c0c0e0       guibg=#333340
highlight cParen      guifg=deepskyblue3
highlight cBlock      guifg=deepskyblue4

" Doxygen 
highlight doxygenComment    guifg=cornsilk4  gui=none
highlight doxygenBrief      guifg=cornsilk2  gui=none
highlight doxygenParam      guifg=cornsilk2  gui=none
highlight doxygenOtherTODO  guifg=hotpink3   gui=bold,underline
highlight doxygenOtherWARN  guifg=hotpink3   gui=bold,underline
highlight! link DoxygenBody Comment 
highlight! link doxygenSpecialOnelineDesc doxygenBrief

highlight DiffChange    guifg=cyan4 guibg=lightcyan3 gui=none
highlight DiffText      guifg=lightcyan1 guibg=lightcyan4 gui=none
highlight DiffAdd       guifg=lightcyan1 guibg=lightcyan4 gui=none
highlight DiffDelete    guifg=hotpink4   guibg=hotpink4   gui=none

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
highlight htmlH1 guifg=peachpuff gui=bold
highlight htmlH2 guifg=peachpuff
highlight htmlH3 guifg=peachpuff
highlight htmlBold                gui=bold
highlight htmlItalic              gui=italic

" markdown
highlight! markdownCode guifg=green3 
highlight! link markdownCodeBlock Comment
