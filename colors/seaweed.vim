vim9script
# Vim color theme
#
# Description: A dark color theme with blue/greenish/gray-scale colors.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=dark

g:colors_name = "seaweed"

var black    = "#000000"
var white    = "#FFFFFF"

var blue     = "#21B8FF"
var greenish = "#2FF3C2"

var gray9 = "#F8F8F8"
var gray8 = "#E7E2E7"
var gray7 = "#D5D1D5"
var gray6 = "#BEB0BE"
var gray5 = "#989098"
var gray4 = "#7A708A"
var gray3 = "#5A505A"
var gray2 = "#473B47"
var gray1 = "#352835"
var gray0 = "#282028"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Attr = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str

# Basics

execute "hi Bold" Attr("bold")
execute "hi Cursor" Fg(black) Bg(greenish) Cterm("NONE")
execute "hi CursorLine" Bg(gray1) Cterm("NONE")
execute "hi CursorLineNr" Fg(gray4) Attr("bold")
execute "hi IncSearch" Fg(black) Bg(greenish) Attr("NONE")
execute "hi Italic" Attr("italic")
execute "hi LineNr" Fg(gray4) Attr("bold")
execute "hi MatchParen" Fg(blue) Bg("bg") Attr("underline,bold")
execute "hi NonText" Fg(gray6) Bg("bg")
execute "hi Normal" Fg(gray7) Bg(black) Attr("NONE")
execute "hi Pmenu" Fg(white) Bg(gray3)
execute "hi PmenuSel" Fg(white) Bg(blue) Attr("NONE")
execute "hi PmenuThumb" Fg(gray2) Bg(gray7)
execute "hi PmenuSbar" Fg(greenish) Bg(greenish)
execute "hi CurSearch" Fg(black) Bg(greenish) Attr("NONE")
execute "hi Search" Fg(white) Bg('bg') Attr("underline")
execute "hi StatusLine" Fg(black) Bg(gray9) Attr("NONE")
execute "hi StatusLineNC" Fg(gray9) Bg(gray2) Attr("NONE")
execute "hi StatusLineTerm" Fg(white) Bg(greenish) Attr("NONE")
execute "hi Terminal" Fg(blue) Bg(black)
execute "hi User1" Fg(black) Bg(gray8) Attr("bold")
execute "hi User2" Fg(black) Bg(white)
execute "hi VertSplit" Fg(gray2) Bg(gray2) Attr("NONE")
execute "hi Visual" Fg(white) Bg(blue)

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
execute "hi Comment" Fg(gray5) Attr("NONE")
execute "hi Conditional" Fg(greenish)  Attr("NONE")
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue) Attr("underline")
execute "hi Error" Fg(greenish) Bg("bg") Attr("underline")
execute "hi ErrorMsg" Fg(black) Bg(greenish) Attr("NONE")
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(greenish) Attr("NONE")
execute "hi ModeMsg" Fg(black) Bg(blue) Attr("NONE")
execute "hi Number" Fg(blue)
execute "hi PreCondit" Fg(blue)  Attr("bold")
execute "hi PreProc" Fg(blue) Attr("NONE")
execute "hi Question" Fg(blue) Bg("bg")
execute "hi QuickFixLine" Fg(blue) Bg(gray2) Attr("bold")
execute "hi Special" Fg(blue)
execute "hi SpecialKey" Fg(blue)
execute "hi Statement" Fg(greenish)  Attr("NONE")
execute "hi StorageClass" Fg(greenish)
execute "hi String" Fg(gray7)
execute "hi Structure" Fg(greenish) Attr("NONE")
execute "hi Title" Fg(black)  Attr("bold")
execute "hi Todo" Fg(blue) Bg("bg") Attr("bold,italic")
execute "hi Type" Fg(greenish) Attr("NONE")
execute "hi WarningMsg" Fg(black) Bg(greenish)
execute "hi qfFileName" Fg(blue)
execute "hi qfLineNr" Fg(greenish)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blue)  Attr("bold")

# Filetype C

execute "hi cCppOut" Bg(gray3) Attr("NONE")
execute "hi cCppOutIf2" Bg(gray3) Attr("NONE")
execute "hi cParen" Fg(gray7)
execute "hi cBlock" Fg(gray7)

# Filetype HTML

execute "hi htmlH1" Fg(greenish)  Attr("bold")
execute "hi htmlH2" Fg(greenish)  Attr("bold")
execute "hi htmlH3" Fg(greenish)  Attr("bold")

# Some markup flavours

execute "hi markdownCode" Fg(gray6) Bg(gray2)
execute "hi markdownCodeBlock" Fg(gray6)
execute "hi rstEmphasis" Fg(blue)
execute "hi rstStrongEmphasis" Fg(blue)  Attr("bold")

# Diffs

execute "hi DiffChange" Fg(blue) Bg(gray2)
execute "hi DiffText" Fg(blue) Bg(gray2)
execute "hi DiffDelete" Fg(greenish) Bg(gray2)
execute "hi DiffAdd" Fg(gray7) Bg(gray2)
