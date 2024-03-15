vim9script
# Name: Apollo Maintainer: Markus Prepens
#
# A Vim color theme Intro: Apollo tries to be a less-is-more color theme to
# reduce distraction by fancy colors. But the temptation was too strong:
# Blueish and greenish colors should help to make things not too boring.
#
# Enjoy!

if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark

g:colors_name = "apollo"

var white = "#FFFFFF"
var black = "#000000"
var bg    = ["#132443", "#263154", "#344468", "#48506F"]
var moon  = ["#505868", "#9098A8", "#C0CBE8", "#E0E8FE"]
var green = ["#1D683C", "#22A358", "#27C168", "#27F070"]
var blue  = ["#2C609F", "#3068B8", "#4090D8", "#70B0F8"]
var red   = ["#B82042", "#E84070"]
var sun   = "#D0DF40"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Attr = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics
execute "hi Bold" Fg(moon[1])  Attr("bold")
execute "hi Cursor" Fg(white) Bg(blue[2])
execute "hi CursorLine"  Bg(bg[1]) Cterm("NONE")
execute "hi CursorLineNr" Fg(green[3]) Bg(bg[2]) Attr("bold")
execute "hi ErrorMsg" Fg(white) Bg(red[1])
execute "hi IncSearch" Fg(white) Bg(green[1]) Attr("NONE") Cterm("NONE")
execute "hi Italic" Fg(moon[1])  Attr("NONE")
execute "hi LineNr" Fg(blue[3]) Bg(bg[1])
execute "hi LineNrAbove" Fg(bg[3]) Bg("bg") Attr("bold")
execute "hi LineNrBelow" Fg(bg[3]) Bg("bg") Attr("bold")
execute "hi MatchParen" Fg(green[3]) Bg("bg") Attr("underline")
execute "hi ModeMsg" Fg(moon[1]) Bg("bg")
execute "hi NonText" Fg(blue[0]) Bg(bg[0])
execute "hi Normal" Fg(moon[3]) Bg(bg[0]) Attr("NONE")
execute "hi Pmenu" Fg(white) Bg(blue[1]) Attr("NONE")
execute "hi PmenuSbar" Fg(moon[2]) Bg(bg[2])
execute "hi PmenuSel" Fg(white) Bg(green[1]) Attr("NONE")
execute "hi PmenuThumb" Fg(blue[2]) Bg(bg[3])
execute "hi Question" Fg(green[2]) Bg("bg")
execute "hi QuickFixLine" Fg(blue[2]) Bg("bg") Attr("bold")
execute "hi Search" Fg(moon[3]) Bg(bg[3]) Attr("NONE")
execute "hi StatusLine" Fg(white) Bg(blue[2]) Attr("NONE") Cterm("NONE")
execute "hi StatusLineNC" Fg(moon[3]) Bg(bg[2]) Attr("NONE") Cterm("NONE")
execute "hi Terminal" Fg(green[3]) Bg(green[0])
execute "hi Title" Fg(green[3])
execute "hi User1" Fg(white) Bg(blue[1]) Attr("NONE")
execute "hi User2" Fg(black) Bg(sun)
execute "hi VertSplit" Fg(bg[1]) Bg(bg[1]) Attr("NONE")
execute "hi Visual" Bg(bg[2])
execute "hi WarningMsg" Fg(white) Bg(blue[1])
execute "hi qfFileName" Fg(blue[2])
execute "hi qfSeparator" Fg("fg")

highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded Normal
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLineSel IncSearch
highlight! link TabLine Normal
highlight! link TabLineFill Normal
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link qfLineNr LineNr
highlight! link CurSearch IncSearch

# Code
execute "hi Statement" Fg(green[3])
execute "hi Conditional" Fg(green[3])  Attr("bold")
execute "hi Type" Fg(blue[3])  Attr("NONE")
execute "hi Structure" Fg(blue[2])
execute "hi StorageClass" Fg(blue[3])
execute "hi PreProc" Fg(white)  Attr("bold")
execute "hi PreCondit" Fg(blue[3])  Attr("bold")
execute "hi Define" Fg(blue[2])  Attr("NONE")
execute "hi Comment" Fg(green[2])
execute "hi Function" Fg(blue[3]) Attr("bold")
execute "hi Identifier" Fg(green[3])
execute "hi Special" Fg(green[2])
execute "hi Constant" Fg(white)
execute "hi Number" Fg(white)
execute "hi Todo" Fg(moon[1]) Bg(bg[2])
execute "hi Error" Fg(red[1]) Bg(bg[2])
execute "hi Directory" Fg(blue[3])  Attr("underline")

# Filetype VIM
execute "hi vimCommentTitle" Fg(white)  Attr("bold")

# Filetype C
execute "hi cCppOut" Fg(moon[2])
execute "hi cCppOutIf2" Fg(moon[2])
execute "hi cParen" Fg(moon[2])
execute "hi cBlock" Fg(moon[2])

# filetype HTML
execute "hi htmlH1" Fg(green[3])  Attr("bold")
execute "hi htmlH2" Fg(green[3])  Attr("bold")
execute "hi htmlH3" Fg(green[2])  Attr("bold")

# markdown
execute "hi markdownCode" Fg(moon[2]) Bg(bg[2])
execute "hi markdownCodeBlock" Fg(moon[1])
execute "hi markdownUrl" Fg(moon[1]) Bg(bg[2]) Attr("underline")
execute "hi markdownLinkText" Fg(blue[2])  Attr("NONE")

# restructured text
execute "hi rstEmphasis" Fg(green[2])
execute "hi rstStrongEmphasis" Fg(green[2])  Attr("bold")

# Diffs
execute "hi DiffChange" Fg(white) Bg(bg[3])
execute "hi DiffText" Fg(blue[2]) Bg(bg[3]) Attr("bold")
execute "hi DiffDelete" Fg(red[1]) Bg(bg[2])
execute "hi DiffAdd" Fg(green[2]) Bg(bg[2]) Attr("bold")
