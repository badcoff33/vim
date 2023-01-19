vim9script

# A Vim color theme
# Intro: Apollo tries to be a less-is-more color theme. It uses less colors to
# gain better readability and colorful clutter. But the temptation was too
# strong: I added some blueish and greenish colors to make thins not too
# boring. Enjoy!
# Name: Apollo
# Maintainer: Markus Prepens

if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark

g:colors_name = "apollo"

var white   = "#FFFFFF"
var black   = "#000000"

var bg1      = "#132443"
var bg2      = "#263154"
var bg3      = "#344468"
var bg4      = "#48506F"
var silver1  = "#A0A0A8"
var silver2  = "#B8B8BE"
var silver3  = "#D0D0D8"
var silver4  = "#E0E0E8"
var green_bg = "#019378"
var green1   = "#02B360"
var green2   = "#07C168"
var green3   = "#07E070"
var green4   = "#07F88F"
var blue_bg  = "#2E4388"
var blue1    = "#3068B0"
var blue2    = "#60A0D8"
var blue3    = "#70B0F8"
var red1     = "#B82042"
var red2     = "#E84070"
var amber    = "#D0CF20"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Attr = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str

# Basics
execute "hi Bold" Fg(silver2)  Attr("bold")
execute "hi Cursor" Fg(black) Bg(white)
execute "hi CursorLine"  Bg(bg3) Cterm("NONE")
execute "hi CursorLineNr" Fg(green3) Bg(bg3) Attr("bold")
execute "hi ErrorMsg" Fg(red2) Bg("bg")
execute "hi IncSearch" Fg(black) Bg(white) Attr("bold") Cterm("NONE")
execute "hi Italic" Fg(silver2)  Attr("NONE")
execute "hi LineNr" Fg(blue3) Bg(bg2)
execute "hi LineNrAbove" Fg(bg4) Bg("bg") Attr("bold")
execute "hi LineNrBelow" Fg(bg4) Bg("bg") Attr("bold")
execute "hi MatchParen" Fg(green3) Bg("bg") Attr("underline")
execute "hi ModeMsg" Fg(silver2) Bg("bg")
execute "hi NonText" Fg(blue1) Bg(bg1)
execute "hi Normal" Fg(silver4) Bg(bg1) Attr("NONE")
execute "hi Pmenu" Fg(white) Bg(blue_bg) Attr("NONE")
execute "hi PmenuSbar" Fg(silver3) Bg(bg3)
execute "hi PmenuSel" Fg(white) Bg(green_bg) Attr("NONE")
execute "hi PmenuThumb" Fg(blue2) Bg(bg4)
execute "hi Question" Fg(green2) Bg("bg")
execute "hi QuickFixLine"  Fg(amber) Bg("bg") Attr("bold")
execute "hi Search" Fg(white) Bg(blue2) Attr("NONE")
execute "hi StatusLine" Fg(white) Bg(blue1) Attr("NONE") Cterm("NONE")
execute "hi StatusLineNC" Fg(silver4) Bg(bg3) Attr("NONE") Cterm("NONE")
execute "hi Terminal" Fg(green3) Bg(black)
execute "hi Title" Fg(green3)
execute "hi User1" Fg(white) Bg(green1)
execute "hi VertSplit" Fg(bg2) Bg(bg2) Attr("NONE")
execute "hi Visual" Fg(white) Bg(blue_bg)
execute "hi WarningMsg" Fg(blue1) Bg("bg")
execute "hi qfFileName" Fg(blue2)
execute "hi qfSeparator" Fg("fg")

highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded StatusLineNC
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLineSel StatusLine
highlight! link TabLine StatusLineNC
highlight! link TabLineFill StatusLineNC
highlight! link User2 StatusLine
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link qfLineNr    LineNr

# Code
execute "hi Statement" Fg(blue3)
execute "hi Conditional" Fg(blue3)  Attr("bold")
execute "hi Type" Fg(blue2)  Attr("NONE")
execute "hi Structure" Fg(blue2)
execute "hi StorageClass" Fg(blue3)
execute "hi PreProc" Fg(white)  Attr("bold")
execute "hi PreCondit" Fg(blue1)  Attr("bold")
execute "hi Define" Fg(blue2)  Attr("NONE")
execute "hi Comment" Fg(green3)
execute "hi Function" Fg(blue3) Attr("bold")
execute "hi Identifier" Fg(silver3)
execute "hi Special" Fg(green2)
execute "hi Constant" Fg(white)
execute "hi Number" Fg(white)
execute "hi Todo" Fg(silver2) Bg(bg3)
execute "hi Error" Fg(red2) Bg(bg3)
execute "hi Directory" Fg(silver4)  Attr("underline")

# Filetype VIM
execute "hi vimCommentTitle" Fg(white)  Attr("bold")

# Filetype C
execute "hi cCppOut" Fg(silver3)
execute "hi cCppOutIf2" Fg(silver3)
execute "hi cParen" Fg(silver3)
execute "hi cBlock" Fg(silver3)

# filetype HTML
execute "hi htmlH1" Fg(green4)  Attr("bold")
execute "hi htmlH2" Fg(green3)  Attr("bold")
execute "hi htmlH3" Fg(green2)  Attr("bold")

# markdown
execute "hi markdownCode" Fg(silver3) Bg(bg3)
execute "hi markdownCodeBlock" Fg(silver2)
execute "hi markdownUrl" Fg(silver2) Bg(bg3) Attr("underline")
execute "hi markdownLinkText" Fg(blue2)  Attr("NONE")

# restructured text
execute "hi rstEmphasis" Fg(green2)
execute "hi rstStrongEmphasis" Fg(green2)  Attr("bold")

# Diffs
execute "hi DiffChange" Fg(white) Bg(bg4)
execute "hi DiffText" Fg(blue2) Bg(bg4) Attr("bold")
execute "hi DiffDelete" Fg(red1) Bg(red1)
execute "hi DiffAdd" Fg(green2) Bg(bg3) Attr("bold")
