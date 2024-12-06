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

var white    = "#FFFFFF"
var black    = "#000000"

var bg0       = "#132443"
var bg1       = "#263154"
var bg2       = "#344468"
var bg3       = "#48506F"

var fg0       = "#405868"
var fg1       = "#8098A8"
var fg2       = "#B0CBE8"
var fg3       = "#D0E8FE"

var red       = "#F84050"
var amber     = "#B8CF40"
var green_bg  = "#1F4843"
var green_dk  = "#20B144"
var green     = "#27E158"
var green_br  = "#27FF60"
var blue_dk   = "#1058B8"
var blue      = "#509CD8"
var blue_br   = "#70C0F8"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Attr = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics
execute "hi Bold" Fg(fg1)  Attr("bold")
execute "hi CurSearch" Fg(amber) Bg(bg2) Attr("underline")
execute "hi Cursor" Fg(white) Bg(red)
execute "hi CursorLine"  Bg(bg1) Cterm("NONE")
execute "hi CursorLineNr" Fg(green) Bg(bg2) Attr("bold") Cterm("None")
execute "hi ErrorMsg" Fg(red) Bg("bg")
execute "hi IncSearch" Fg(black) Bg(white) Attr("NONE") Cterm("NONE")
execute "hi Italic" Fg(fg1)  Attr("NONE")
execute "hi LineNr" Fg(blue_br) Bg(bg1) Cterm("NONE")
execute "hi LineNrAbove" Fg(fg0) Bg("bg") Attr("bold")
execute "hi LineNrBelow" Fg(fg1) Bg("bg") Attr("bold")
execute "hi MatchParen" Fg(green_br) Bg("bg") Attr("underline")
execute "hi ModeMsg" Fg(fg1) Bg("bg")
execute "hi NonText" Fg(blue_dk) Bg(bg0)
execute "hi Normal" Fg(fg3) Bg(bg0) Attr("NONE")
execute "hi Pmenu" Fg(green) Bg(bg1) Attr("NONE")
execute "hi PmenuSbar" Bg(bg3)
execute "hi PmenuSel" Fg(white) Bg(green_dk) Attr("NONE")
execute "hi PmenuThumb" Bg(blue_br)
execute "hi Question" Fg(green) Bg("bg")
execute "hi QuickFixLine" Fg(green) Bg(bg2) Attr("NONE")
execute "hi Search" Fg(amber) Bg(bg2) Attr("NONE")
execute "hi StatusLine" Fg(white) Bg(bg3) Attr("NONE") Cterm("NONE")
execute "hi StatusLineNC" Fg(white) Bg(bg1) Attr("NONE") Cterm("NONE")
execute "hi TabLine" Fg(fg1) Bg(black) Attr('NONE')
execute "hi TabLineFill" Fg(fg2) Bg(black) Attr('NONE')
execute "hi TabLineSel" Fg(green) Bg("bg") Attr('NONE')
execute "hi Terminal" Fg(fg3) Bg(bg0)
execute "hi Title" Fg(green_br)
execute "hi User1" Fg(white) Bg(blue) Attr("NONE")
execute "hi User2" Fg(black) Bg(amber)
execute "hi VertSplit" Fg(bg1) Bg(bg1) Attr("NONE")
# execute "hi Visual" Fg(fg2) Bg(bg3)
execute "hi Visual" Fg(green) Bg(green_bg)
execute "hi WarningMsg" Fg(black) Bg(amber)
execute "hi qfFileName" Fg(blue)
execute "hi qfSeparator" Fg("fg")

highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded Normal
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link qfLineNr LineNr

# Code
execute "hi Statement" Fg(green_br) Attr("NONE")
execute "hi Conditional" Fg(white)  Attr("italic")
execute "hi Type" Fg(green)  Attr("NONE")
execute "hi Structure" Fg(blue)
execute "hi StorageClass" Fg(blue_br)
execute "hi PreProc" Fg(white)  Attr("bold")
execute "hi PreCondit" Fg(blue_br)  Attr("bold")
execute "hi Define" Fg(blue)  Attr("NONE")
execute "hi Comment" Fg(fg1)
execute "hi Function" Fg(blue_br) Attr("bold")
execute "hi Identifier" Fg(blue_br)
execute "hi Special" Fg(green_dk)
execute "hi Constant" Fg(white)
execute "hi Number" Fg(white)
execute "hi Todo" Fg(fg1) Bg(bg2)
execute "hi Error" Fg(red) Bg(bg2)
execute "hi Directory" Fg(blue_br)  Attr("underline")

# Filetype VIM
execute "hi vimCommentTitle" Fg(white)  Attr("bold")

# Filetype C
execute "hi cCppOut" Fg(fg2)
execute "hi cCppOutIf2" Fg(fg2)
execute "hi cParen" Fg(fg2)
execute "hi cBlock" Fg(fg2)

# filetype HTML
execute "hi htmlH1" Fg(green_br)  Attr("bold")
execute "hi htmlH2" Fg(green_br)  Attr("bold")
execute "hi htmlH3" Fg(green)  Attr("bold")

# markdown
execute "hi markdownCode" Fg(green)
execute "hi markdownCodeBlock" Fg(white)
execute "hi markdownUrl" Fg(blue_dk) Attr("underline")
execute "hi markdownLinkText" Fg(blue_br)  Attr("NONE")

# restructured text
execute "hi rstEmphasis" Fg(green)
execute "hi rstStrongEmphasis" Fg(green)  Attr("bold")

# Diffs
execute "hi DiffChange" Fg(white)  Bg(bg0)
execute "hi DiffText"   Fg(blue_br) Bg(bg3)
execute "hi DiffDelete" Fg(red)   Bg(red)
execute "hi DiffAdd"    Fg(green_br) Bg(bg3)

# Plugin: Signify
highlight! link SignifySignAdd DiffAdd
highlight! link SignifySignDelete DiffDelete
highlight! link SignifySignDeleteFirstLine DiffDelete
highlight! link SignifySignChange DiffChange
highlight! link SignifySignChangeDelete DiffChange
