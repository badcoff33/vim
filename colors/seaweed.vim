vim9script
# Vim color theme
#
# Description: A dark color theme with blueish/greenish/gray-scale colors.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=dark

g:colors_name = "seaweed"

var fg = "#EDFFED"
var bg = "#202327"

var black    = "#000000"
var white    = "#FFFFFF"

var blueish     = "#21B1D3"
var greenish = "#21D3B2"
var yellow   = "#D3D321"

var gray9 = "#F8F8F8"
var gray8 = "#E7E2F7"
var gray7 = "#D5D1E5"
var gray6 = "#BEB0C3"
var gray5 = "#909C9F"
var gray4 = "#707F8A"
var gray3 = "#505A5A"
var gray2 = "#384747"
var gray1 = "#283535"
var gray0 = "#202828"

var Fg      =  (str) => empty(str) ? "" : "guifg=" .. str
var Bg      =  (str) => empty(str) ? "" : "guibg=" .. str
var Special =  (str) => empty(str) ? "" : "guisp=" .. str

var Normal        = "gui=NONE cterm=NONE"
var Bold          = "gui=bold"
var Italic        = "gui=italic"
var Underline     = "gui=underline"
var BoldUnderline = "gui=bold,underline"
var BoldItalic    = "gui=bold,italic"

# Basics

execute "hi Bold" Bold
execute "hi Cursor" Fg(black) Bg(white) Normal
execute "hi CursorLine" Bg(gray1) Normal
execute "hi CursorLineNr" Fg(gray4) Bold
execute "hi IncSearch" Fg(black) Bg(greenish) Normal
execute "hi Italic" Italic
execute "hi LineNr" Fg(gray4) Bold
execute "hi MatchParen" Fg(blueish) Bg("bg") BoldUnderline
execute "hi NonText" Fg(gray6) Bg("bg")
execute "hi Normal" Fg(fg) Bg(bg) Normal
execute "hi Pmenu" Fg(white) Bg(gray2)
execute "hi PmenuSel" Fg(white) Bg(blueish) Normal
execute "hi PmenuThumb" Fg(gray2) Bg(gray7)
execute "hi PmenuSbar" Fg(greenish) Bg(greenish)
execute "hi CurSearch" Fg(black) Bg(greenish) Normal
execute "hi Search" Fg(white) Bg('bg') Underline
execute "hi StatusLine" Fg(black) Bg(gray9) Normal
execute "hi StatusLineNC" Fg(gray9) Bg(gray3) Normal
execute "hi StatusLineTerm" Fg(white) Bg(greenish) Normal
execute "hi TabPanel" Fg(greenish) Bg(black)
execute "hi TabPanelSel" Fg(blueish) Bg(bg) Bold
execute "hi TabPanelFill" Fg(blueish) Bg(black) Bold
execute "hi Terminal" Fg(blueish) Bg(black)
execute "hi User1" Fg(black) Bg(gray9) Bold
execute "hi User2" Fg(black) Bg(gray9)
execute "hi VertSplit" Fg(gray2) Bg(gray2) Normal
execute "hi Visual" Fg(white) Bg(blueish)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link Folded Comment
highlight! link Ignore Comment
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Pmenu
highlight! link TabLineFill Normal
highlight! link TabLineSel PmenuSel
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code
execute "hi Comment" Fg(gray5) Normal
execute "hi Conditional" Fg(greenish)  Normal
execute "hi Constant" Fg(blueish)
execute "hi Directory" Fg(blueish) Underline
execute "hi Error" Fg(greenish) Bg("bg") Underline
execute "hi ErrorMsg" Fg(yellow) Bg(black) Normal
execute "hi Function" Fg(blueish)
execute "hi Identifier" Fg(greenish) Normal
execute "hi ModeMsg" Fg(yellow) Bg(black) Normal
execute "hi Number" Fg(blueish)
execute "hi PreCondit" Fg(blueish)  Bold
execute "hi PreProc" Fg(blueish) Normal
execute "hi Question" Fg(blueish) Bg("bg")
execute "hi QuickFixLine" Fg(blueish) Bg(gray2) Bold
execute "hi Special" Fg(blueish)
execute "hi SpecialKey" Fg(blueish)
execute "hi Statement" Fg(greenish)  Normal
execute "hi StorageClass" Fg(greenish)
execute "hi String" Fg(gray7)
execute "hi Structure" Fg(greenish) Normal
execute "hi Title" Fg(black)  Bold
execute "hi Todo" Fg(blueish) Bg("bg") BoldItalic
execute "hi Type" Fg(greenish) Normal
execute "hi WarningMsg" Fg(black) Bg(greenish)
execute "hi qfFileName" Fg(blueish)
execute "hi qfLineNr" Fg(greenish)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blueish)  Bold

# Filetype C

execute "hi cCppOut" Bg(gray3) Normal
execute "hi cCppOutIf2" Bg(gray3) Normal
execute "hi cParen" Fg(gray7)
execute "hi cBlock" Fg(gray7)

# Filetype HTML

execute "hi htmlH1" Fg(greenish)  Bold
execute "hi htmlH2" Fg(greenish)  Bold
execute "hi htmlH3" Fg(greenish)  Bold

# Some markup flavours

execute "hi markdownCode" Fg(gray6) Bg(gray2)
execute "hi markdownCodeBlock" Fg(gray6)
execute "hi rstEmphasis" Fg(blueish)
execute "hi rstStrongEmphasis" Fg(blueish)  Bold

# Diffs

execute "hi DiffChange" Fg(blueish) Bg(gray2)
execute "hi DiffText" Fg(blueish) Bg(gray2)
execute "hi DiffDelete" Fg(greenish) Bg(gray2)
execute "hi DiffAdd" Fg(gray7) Bg(gray2)
