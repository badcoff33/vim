vim9script
# Vim color theme
#
# Description: Keep things reduced. Only two basic colors used: red and blue.
# To make things a little bit more subtle, each base colors is present in three
# flavors in addition to some gray-ish colors.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=light

g:colors_name = "twotone"

var black    = "#000000"
var white    = "#FFFFFF"

var blue_dk = "#1148AF"
var blue    = "#2188EF"
var blue_lt = "#E0F0F3"

var red_dk  = "#AF2352"
var red     = "#EF2372"
var red_lt  = "#FFA8A8"

var gray = [
    "#282528",
    "#353335",
    "#474447",
    "#5A585A",
    "#7A787A",
    "#989598",
    "#BEB5BE",
    "#D5D1D5",
    "#E7E1E7",
    "#F8F5F8",
]

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Attr = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str

# Basics

execute "hi Bold" Attr("bold")
execute "hi CurSearch" Fg(black) Bg(gray[6]) Attr("NONE")
execute "hi Cursor" Bg(blue) Cterm("NONE")
execute "hi CursorLine" Bg(gray[9]) Cterm("NONE")
execute "hi CursorLineNr" Fg(gray[4]) Attr("bold")
execute "hi Folded" Fg(blue) Bg(gray[8]) Attr("NONE")
execute "hi IncSearch" Fg(white) Bg(black) Attr("NONE")
execute "hi Italic" Attr("italic")
execute "hi Label" Fg(black) Attr("bold")
execute "hi LineNr" Fg(gray[4]) Attr("bold")
execute "hi MatchParen" Fg(blue) Bg("bg") Attr("underline,bold")
execute "hi NonText" Fg(gray[6]) Bg("bg")
execute "hi Normal" Fg(gray[2]) Bg(white) Attr("NONE")
execute "hi Pmenu" Fg(black) Bg(gray[8])
execute "hi PmenuSbar" Fg(red) Bg(red)
execute "hi PmenuSel" Fg(white) Bg(blue) Attr("bold")
execute "hi PmenuThumb" Fg(gray[2]) Bg(gray[7])
execute "hi Search" Fg(black) Bg(gray[8]) Attr("NONE")
execute "hi StatusLine" Fg(white) Bg(black) Attr("NONE")
execute "hi StatusLineNC" Fg(gray[2]) Bg(gray[8]) Attr("NONE")
execute "hi StatusLineTerm" Fg(white) Bg(red) Attr("bold")
execute "hi User1" Fg(white) Bg(blue)
execute "hi User2" Fg(white) Bg(red)
execute "hi VertSplit" Fg(gray[8]) Bg(gray[8]) Attr("NONE")
execute "hi Visual" Bg(blue_lt)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Pmenu
highlight! link TabLineFill Normal
highlight! link TabLineSel PmenuSel
highlight! link Terminal Normal
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(gray[5]) Attr("NONE")
execute "hi Conditional" Fg(red)  Attr("bold")
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue_dk)
execute "hi Error" Fg(red) Bg("bg") Attr("underline")
execute "hi ErrorMsg" Fg(white) Bg(red) Attr("NONE")
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(red) Attr("NONE")
execute "hi ModeMsg" Fg(white) Bg(blue) Attr("NONE")
execute "hi Number" Fg(blue)
execute "hi PreCondit" Fg(blue)  Attr("bold")
execute "hi PreProc" Fg(blue) Attr("NONE")
execute "hi Question" Fg(gray[1]) Bg("bg")
execute "hi QuickFixLine" Fg(blue) Bg(gray[8]) Attr("bold")
execute "hi Special" Fg(blue)
execute "hi SpecialKey" Fg(blue)
execute "hi Statement" Fg(red)  Attr("bold")
execute "hi StorageClass" Fg(red)
execute "hi String" Fg(blue_dk)
execute "hi Structure" Fg(red) Attr("NONE")
execute "hi Title" Fg(black)  Attr("bold")
execute "hi Todo" Fg(blue) Bg("bg") Attr("bold,italic")
execute "hi Type" Fg(blue) Attr("NONE")
execute "hi WarningMsg" Fg(white) Bg(blue)
execute "hi qfFileName" Fg(blue)
execute "hi qfLineNr" Fg(red)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blue)  Attr("bold")

# Filetype C

execute "hi cCppOut" Bg(gray[9]) Attr("NONE")
execute "hi cCppOutIf2" Bg(gray[9]) Attr("NONE")
execute "hi cParen" Fg(gray[3])
execute "hi cBlock" Fg(gray[3])

# Filetype HTML

execute "hi htmlH1" Fg(blue_dk) Attr("bold")
execute "hi htmlH2" Fg(blue)    Attr("bold")
execute "hi htmlH3" Fg(blue)    Attr("NONE")

# Filetype Markdown

# execute "hi markdownCode" Fg(gray[3]) Bg(gray[9])
execute "hi markdownCode" Fg(blue) Attr("italic")
execute "hi markdownCodeBlock" Fg(gray[2])
execute "hi rstEmphasis" Fg(gray[2])
execute "hi rstStrongEmphasis" Fg(gray[2])  Attr("bold")

# Diffs

execute "hi DiffChange" Fg(blue) Bg(gray[9])
execute "hi DiffText" Fg(blue) Bg(gray[8])
execute "hi DiffDelete" Fg(red) Bg(gray[9])
execute "hi DiffAdd" Fg(gray[3]) Bg(gray[9])
