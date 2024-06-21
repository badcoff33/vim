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
var bg       = ["#132443", "#263154", "#344468", "#48506F"]
var fg       = ["#405868", "#8098A8", "#B0CBE8", "#D0E8FE"]
var red      = "#F84070"
var amber    = "#C8BF40"
var green_dk = "#27C148"
var green    = "#27E158"
var green_br = "#27FF60"
var blue_dk  = "#3068B8"
var blue     = "#4090D8"
var blue_br  = "#70B0F8"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Attr = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics
execute "hi Bold" Fg(fg[1])  Attr("bold")
execute "hi Cursor" Fg(black) Bg(white)
execute "hi CursorLine"  Bg(bg[1]) Cterm("NONE")
execute "hi CursorLineNr" Fg(green_br) Bg(bg[2]) Attr("bold")
execute "hi ErrorMsg" Fg(white) Bg(red)
execute "hi IncSearch" Fg(black) Bg(amber) Attr("underline") Cterm("NONE")
execute "hi Italic" Fg(fg[1])  Attr("NONE")
execute "hi LineNr" Fg(blue_br) Bg(bg[1])
execute "hi LineNrAbove" Fg(bg[3]) Bg("bg") Attr("bold")
execute "hi LineNrBelow" Fg(bg[3]) Bg("bg") Attr("bold")
execute "hi MatchParen" Fg(green_br) Bg("bg") Attr("underline")
execute "hi ModeMsg" Fg(fg[1]) Bg("bg")
execute "hi NonText" Fg(blue_dk) Bg(bg[0])
execute "hi Normal" Fg(fg[3]) Bg(bg[0]) Attr("NONE")
execute "hi Pmenu" Fg(black) Bg(green_dk) Attr("NONE")
execute "hi PmenuSbar" Bg(bg[2])
execute "hi PmenuSel" Fg(black) Bg(green_br) Attr("NONE")
execute "hi PmenuThumb" Bg(blue_br)
execute "hi Question" Fg(green) Bg("bg")
execute "hi QuickFixLine" Fg(blue) Bg("bg") Attr("bold")
execute "hi Search" Fg(amber) Bg("bg") Attr("underline")
execute "hi StatusLine" Fg(green_br) Bg(bg[2]) Attr("NONE") Cterm("NONE")
execute "hi StatusLineNC" Fg(green_br) Bg(black) Attr("NONE") Cterm("NONE")
execute "hi TabLine" Fg(fg[1]) Bg(black) Attr('NONE')
execute "hi TabLineFill" Fg(fg[2]) Bg(black) Attr('NONE')
execute "hi TabLineSel" Fg(green) Bg("bg") Attr('NONE')
execute "hi Terminal" Fg(fg[3]) Bg(bg[0])
execute "hi Title" Fg(green_br)
execute "hi User1" Fg(white) Bg(blue) Attr("NONE")
execute "hi User2" Fg(black) Bg(amber)
execute "hi VertSplit" Fg(bg[1]) Bg(bg[1]) Attr("NONE")
execute "hi Visual" Fg(white) Bg(green_dk)
execute "hi WarningMsg" Fg(white) Bg(blue_dk)
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
highlight! link CurSearch IncSearch

# Code
execute "hi Statement" Fg(green_br) Attr("NONE")
execute "hi Conditional" Fg(white)  Attr("italic")
execute "hi Type" Fg(green)  Attr("NONE")
execute "hi Structure" Fg(blue)
execute "hi StorageClass" Fg(blue_br)
execute "hi PreProc" Fg(white)  Attr("bold")
execute "hi PreCondit" Fg(blue_br)  Attr("bold")
execute "hi Define" Fg(blue)  Attr("NONE")
execute "hi Comment" Fg(fg[1])
execute "hi Function" Fg(blue_br) Attr("bold")
execute "hi Identifier" Fg(green_dk)
execute "hi Special" Fg(green)
execute "hi Constant" Fg(white)
execute "hi Number" Fg(white)
execute "hi Todo" Fg(fg[1]) Bg(bg[2])
execute "hi Error" Fg(red) Bg(bg[2])
execute "hi Directory" Fg(blue_br)  Attr("underline")

# Filetype VIM
execute "hi vimCommentTitle" Fg(white)  Attr("bold")

# Filetype C
execute "hi cCppOut" Fg(fg[2])
execute "hi cCppOutIf2" Fg(fg[2])
execute "hi cParen" Fg(fg[2])
execute "hi cBlock" Fg(fg[2])

# filetype HTML
execute "hi htmlH1" Fg(green_br)  Attr("bold")
execute "hi htmlH2" Fg(green_br)  Attr("bold")
execute "hi htmlH3" Fg(green)  Attr("bold")

# markdown
execute "hi markdownCode" Fg(fg[2]) Bg(bg[2])
execute "hi markdownCodeBlock" Fg(fg[1])
execute "hi markdownUrl" Fg(fg[1]) Bg(bg[2]) Attr("underline")
execute "hi markdownLinkText" Fg(blue)  Attr("NONE")

# restructured text
execute "hi rstEmphasis" Fg(green)
execute "hi rstStrongEmphasis" Fg(green)  Attr("bold")

# Diffs
execute "hi DiffChange" Fg(amber) Bg(bg[3])
execute "hi DiffText" Fg(blue) Bg(bg[3])
execute "hi DiffDelete" Fg(red) Bg(bg[2])
execute "hi DiffAdd" Fg(green) Bg(bg[2])

# Plugin: Signify
highlight! link SignifySignAdd DiffAdd
highlight! link SignifySignDelete DiffDelete
highlight! link SignifySignDeleteFirstLine DiffDelete
highlight! link SignifySignChange DiffChange
highlight! link SignifySignChangeDelete DiffChange
