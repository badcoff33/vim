" Vim color theme
"
" Description: A light color theme with very greyish tones. 

if exists("syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "gray_cat"

" basics
highlight Normal guifg=grey30 guibg=grey94
highlight NonText guifg=grey30 guibg=bg
highlight Visual guifg=grey10 guibg=yellow1
highlight Cursor guifg=white guibg=orangered

" used if Nvim's option 'winhighlight' exists (Nvim)
if has ('nvim')
  highlight NormalFocus   guibg=bg
  highlight NormalNoFocus guibg=bg
  highlight NormalFloat   guifg=grey30 guibg=bg 
  "set winhighlight=Normal:NormalFocus,NormalNC:NormalNoFocus
endif

" window decoration
highlight StatusLine guifg=grey90 guibg=grey30 gui=bold
highlight User1 guifg=grey90  guibg=grey30 gui=bold
highlight User2 guifg=grey90 guibg=grey30 gui=none
highlight User3 guifg=grey90 guibg=grey30 gui=none
highlight StatusLineNC guifg=grey30 guibg=grey80 gui=italic
highlight VertSplit guifg=grey80 guibg=grey80 gui=italic
highlight QuickFixLine guibg=bg gui=bold
highlight! link WildMenu IncSearch
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC

" line numbers / side decorations
highlight LineNr guifg=grey30 guibg=bg gui=bold,italic
highlight CursorLine guibg=bg
highlight CursorColumn guibg=bg
highlight CursorLineNr guifg=grey30 guibg=bg gui=bold,italic
highlight SignColumn guifg=grey30 guibg=bg
highlight! link FoldColumn Normal
highlight Folded guifg=grey30 guibg=bg gui=NONE

" tabs
highlight TabLineFill guifg=grey30 guibg=bg gui=NONE
highlight TabLine guifg=grey30 guibg=bg gui=none
highlight TabLineSel guifg=grey30 guibg=bg gui=bold,underline

" popup Menu
highlight Pmenu guifg=grey30 guibg=bg gui=none
highlight PmenuSel guifg=grey30 guibg=bg gui=underline,bold
highlight PmenuSbar guibg=bg
highlight PmenuThumb guifg=grey30

" search
highlight IncSearch guifg=grey30 guibg=orange gui=bold
highlight Search guifg=grey10 guibg=grey75 gui=none
highlight MatchParen guifg=grey10 guibg=bg gui=underline

" code
highlight Statement guifg=grey10 gui=bold
highlight Conditional guifg=grey20 gui=bold
highlight Type guifg=steelblue4 gui=none
highlight StorageClass guifg=grey80 gui=bold
highlight PreProc guifg=grey10 gui=bold
highlight Comment guifg=grey60
highlight Identifier guifg=grey30
highlight Special guifg=grey30
highlight Constant guifg=maroon3

" misc
highlight Title guifg=grey30
highlight Subtitle guifg=grey30
highlight todo guifg=grey30 guibg=bg
highlight Error guifg=orangered guibg=bg gui=undercurl
highlight Directory guifg=steelblue gui=underline

" messages
highlight WarningMsg guifg=steelblue guibg=bg gui=none
highlight ErrorMsg guifg=orangered guibg=bg gui=none
highlight! link ModeMsg StatusLine
highlight! link Question StatusLine

" quickfix colors
highlight qfFileName guifg=grey20 gui=none
highlight qfLineNr guifg=grey40
highlight qfSeparator guifg=grey50

" Doxygen highlighting
highlight doxygenComment guifg=grey40 gui=none
highlight doxygenBrief guifg=grey50 gui=bold
highlight doxygenParam guifg=grey60 gui=italic
highlight doxygenRefWord guifg=grey40 gui=underline
highlight doxygenSpecial guifg=grey50 gui=none
highlight doxygenSpecialOnelineDesc guifg=grey30

" Diff highlighting
highlight DiffChange guifg=grey30 guibg=bg gui=none
highlight DiffAdd guifg=grey30 guibg=bg gui=none
highlight DiffDelete guifg=grey30 guibg=bg gui=none
highlight DiffText guifg=grey30 guibg=bg gui=none

highlight diffOldFile guifg=grey30
highlight diffNewFile guifg=grey30
highlight diffFile guifg=grey30
highlight diffOnly guifg=grey30
highlight diffIdentical guifg=grey30
highlight diffDiffer guifg=grey30
highlight diffBDiffer guifg=grey30
highlight diffIsA guifg=grey30
highlight diffNoEOL guifg=grey30
highlight diffCommon guifg=grey30
highlight diffRemoved guifg=grey30
highlight diffChanged guifg=grey30
highlight diffAdded guifg=grey30
highlight diffLine guifg=grey30
highlight diffSubname guifg=grey30
highlight diffComment guifg=grey30

" netrw
highlight netrwMarkFile gui=inverse

" html
highlight htmlH1 guifg=grey30 gui=bold
highlight htmlH2 guifg=grey30 gui=bold
highlight htmlH3 guifg=grey30 gui=none
highlight htmlBold gui=bold
highlight htmlItalic gui=italic,bold

" markdown
highlight! link markdownCode String
highlight! link markdownCodeBlock Comment
