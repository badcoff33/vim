vim9script
# A Vim color theme
# Intro: Great movie -- nice theme
# Name: Tron
# Maintainer: Markus Prepens

if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark
g:colors_name = "tron"

var white        = '#FFFFFF'
var black        = '#000000'
var fg0          = "#90ACBC"
var fg1          = "#5A7387"
var fg2          = "#AACCDD"
var fg3          = "#BBF0EF"
var fg4          = "#CBECFF"
var bg0          = "#0A0F11"
var bg1          = "#17181b"
var bg2          = "#192533"
var bg3          = "#1B324B"
var bg4          = "#2B4255"
var hl_line      = "#101A1F"
var bg_hl        = "#2B4255"
var vc_r         = "#B62D66"
var vc_g         = "#4BB5BE"
var vc_b         = "#387AAA"
var key2         = "#9BBDD6"
var key3         = "#AAAAAA"
var accent       = "#FFFFFF"
var mode_line_bg = "#2B4255"
var line_num     = "#5A7387"
# TRON palette
var yellow       = "#DEB45B"
var bluegreen    = "#4BB5BE"
var magenta      = "#B62D66"
var orange       = "#DEB45B"
var red          = "#B62D66"
var blue         = "#9FA4CF"
var green        = "#4BB5AE"
var lightred     = "#FF7DBB"
var lightblue    = "#A0DCFF"
var lightgreen   = "#AAF0CF"
var red_bg       = "#361016"
var blue_bg      = "#1B1662"
var green_bg     = "#03353E"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Attr = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

execute "hi Bold" Fg(fg2)  Attr("bold")
execute "hi Cursor" Fg(black) Bg(white) Attr("NONE")
execute "hi CursorLine"  Bg(hl_line)
execute "hi CursorLineNr" Fg(bluegreen) Bg(bg3) Attr("bold")
execute "hi ErrorMsg" Fg(orange) Bg("bg")
execute "hi IncSearch" Fg(blue_bg) Bg(lightblue) Attr("NONE")
execute "hi LineNr" Fg(lightgreen) Bg(bg2)
execute "hi LineNrAbove" Fg(bg4) Bg("bg") Attr("bold")
execute "hi LineNrBelow" Fg(bg4) Bg("bg") Attr("bold")
execute "hi MatchParen" Fg(bluegreen) Bg("bg") Attr("underline")
execute "hi ModeMsg" Fg(fg2) Bg("bg")
execute "hi NONE" Fg(fg2)  Attr("NONE")
execute "hi NonText" Fg(magenta) Bg(bg1)
execute "hi Normal" Fg(fg4) Bg(bg1) Attr("NONE")
execute "hi NormalFloat" Fg(yellow) Bg(green_bg) Attr("NONE")
execute "hi NormalNC" Fg(fg4) Bg(bg0) Attr("NONE")
execute "hi Question" Fg(green) Bg("bg")
execute "hi QuickFixLine"  Fg(yellow) Bg("bg") Attr("bold")
execute "hi Search" Fg(lightgreen) Bg(green_bg) Attr("NONE")
execute "hi Terminal" Fg(blue) Bg(bg2)
execute "hi Title" Fg(bluegreen)
execute "hi VertSplit" Fg(bg3) Bg(bg3) Attr("NONE")
execute "hi WarningMsg" Fg(magenta) Bg("bg")
execute "hi qfFileName" Fg(blue)
execute "hi qfSeparator" Fg("fg")
execute 'hi Pmenu' Fg(yellow) Bg(blue_bg) Attr('NONE')
execute 'hi PmenuSbar' Fg(fg3) Bg(bg3)
execute 'hi PmenuSel' Fg(black) Bg(yellow) Attr('NONE')
execute 'hi PmenuThumb' Fg(blue) Bg(bg4)
execute 'hi StatusLine' Fg(yellow) Bg(mode_line_bg) Attr('NONE')
execute 'hi StatusLineNC' Fg(fg4) Bg(bg2) Attr('NONE')
execute 'hi User1' Fg(black) Bg(blue) Attr('NONE')
execute 'hi Visual' Fg(blue_bg) Bg(blue)

highlight! link CurSearch IncSearch
highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded StatusLineNC
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Normal
highlight! link TabLineFill Normal
highlight! link TabLineSel StatusLine
highlight! link User2 StatusLine
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link WinBar StatusLine
highlight! link qfLineNr LineNr

# Code
execute "hi Statement" Fg(yellow) Attr("NONE")
execute "hi Conditional" Fg(magenta)  Attr("bold")
execute "hi Type" Fg(lightred)  Attr("NONE")
execute "hi Structure" Fg(blue)
execute "hi StorageClass" Fg(lightgreen)
execute "hi PreProc" Fg(white)  Attr("bold")
execute "hi PreCondit" Fg(lightgreen)  Attr("bold")
execute "hi Define" Fg(blue)  Attr("NONE")
execute "hi Comment" Fg(bluegreen)
execute "hi Function" Fg(lightgreen) Attr("bold")
execute "hi Identifier" Fg(fg3)
execute "hi Special" Fg(green)
execute "hi Constant" Fg(fg2)
execute "hi Number" Fg(white)
execute "hi Todo" Fg(fg2) Bg(bg3)
execute "hi Error" Fg(red) Bg(red_bg)
execute "hi Directory" Fg(lightgreen) Attr("underline") Special(lightgreen)

# Filetype VIM
execute "hi vimCommentTitle" Fg(white)  Attr("bold")

# Filetype C
execute "hi cCppOut" Fg(fg3)
execute "hi cCppOutIf2" Fg(fg3)
execute "hi cParen" Fg(fg3)
execute "hi cBlock" Fg(fg3)

# filetype HTML
execute "hi htmlH1" Fg(orange)  Attr("bold")
execute "hi htmlH2" Fg(orange)  Attr("bold")
execute "hi htmlH3" Fg(orange)  Attr("bold")

# markdown
execute "hi markdownCode" Fg(lightgreen)
execute "hi markdownCodeBlock" Fg(lightgreen)
execute "hi markdownUrl" Fg(blue) Attr("underline") Special(blue)
execute "hi markdownLinkText" Fg(blue)  Attr("none")

# restructured text
execute "hi rstEmphasis" Fg(green)
execute "hi rstStrongEmphasis" Fg(green)  Attr("bold")

# Diffs
execute "hi DiffText" Fg(lightblue) Bg(blue_bg) Attr("NONE")
execute "hi DiffAdd" Fg(green) Bg(green_bg) Attr("NONE")
execute "hi DiffChange" Fg(blue) Bg(blue_bg) Attr("NONE")
execute "hi DiffDelete" Fg(red) Bg(red)
