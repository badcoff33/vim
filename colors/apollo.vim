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

var bg_winhl  = "#101F2F"
var bg0       = "#101A24"
var bg1       = "#263140"
var bg2       = "#344458"
var bg3       = "#48505F"

var fg0       = "#405868"
var fg1       = "#8098A8"
var fg2       = "#B0CBE8"
var fg3       = "#D0E8FE"

var red       = "#F84050"
var amber     = "#B8CF40"
var green_bg  = "#1F4838"
var green_dk  = "#20A154"
var green     = "#27E168"
var green_br  = "#27FF70"
var blue_dk   = "#1058B8"
var blue      = "#509CD8"
var blue_br   = "#70C0F8"

var Fg      =  (str) => empty(str) ? "" : "guifg=" .. str
var Bg      =  (str) => empty(str) ? "" : "guibg=" .. str
var Cterm   =  (str) => empty(str) ? "" : "cterm=" .. str
var Special =  (str) => empty(str) ? "" : "guisp=" .. str

var Normal        = "gui=NONE"
var Bold          = "gui=bold"
var Italic        = "gui=italic"
var Underline     = "gui=underline"
var BoldUnderline = "gui=bold,underline"
var BoldItalic    = "gui=bold,italic"

# Basics
execute "hi Bold" Fg(fg1)  Bold
execute "hi CurSearch" Fg(amber) Bg(bg2) Underline
execute "hi Cursor" Fg(white) Bg(red)
execute "hi CursorLine"  Bg(black) Cterm("NONE")
execute "hi CursorLineNr" Fg(green) Bg(bg2) Bold Cterm("None")
execute "hi ErrorMsg" Fg(red) Bg("bg")
execute "hi IncSearch" Fg(black) Bg(white) Normal Cterm("NONE")
execute "hi Italic" Fg(fg1)  Normal
execute "hi LineNr" Fg(blue_br) Bg(bg1) Cterm("NONE")
execute "hi LineNrAbove" Fg(fg0) Bg("bg") Bold
execute "hi LineNrBelow" Fg(fg1) Bg("bg") Bold
execute "hi MatchParen" Fg(green_br) Bg("bg") Underline
execute "hi ModeMsg" Fg(fg1) Bg("bg")
execute "hi NonText" Fg(blue_dk) Bg(bg0)
execute "hi Normal" Fg(white) Bg(bg0) Normal
execute "hi NormalWinHl" Fg(white) Bg(bg_winhl) Normal
execute "hi PopupNotification" Fg(black) Bg(green_dk) Normal
execute "hi Pmenu" Fg(green) Bg(bg2) Normal
execute "hi PmenuSbar" Bg(bg3)
execute "hi PmenuSel" Fg(white) Bg(green_dk) Normal
execute "hi PmenuMatchSel" BoldUnderline
execute "hi PmenuThumb" Bg(blue_br)
execute "hi Question" Fg(green) Bg("bg")
execute "hi QuickFixLine" Fg(green) Bg(bg2) Normal
execute "hi Search" Fg(amber) Bg(bg2) Normal
execute "hi StatusLine" Fg(white) Bg(bg3) Normal Cterm("NONE")
execute "hi StatusLineNC" Fg(white) Bg(bg1) Normal Cterm("NONE")
execute "hi TabLine" Fg(fg1) Bg(black) Normal
execute "hi TabLineFill" Fg(fg2) Bg(black) Normal
execute "hi TabLineSel" Fg(green) Bg("bg") Underline
execute "hi Terminal" Fg(fg3) Bg(bg0)
execute "hi Title" Fg(green_br)
execute "hi User1" Fg(white) Bg(blue) Normal
execute "hi User2" Fg(black) Bg(amber)
execute "hi VertSplit" Fg(bg1) Bg(bg2) Normal
execute "hi Visual" Fg(white) Bg(green_dk)
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
execute "hi Statement" Fg(green_br) Normal
execute "hi Conditional" Fg(white)  Italic
execute "hi Type" Fg(green)  Normal
execute "hi Structure" Fg(blue)
execute "hi StorageClass" Fg(blue_br)
execute "hi PreProc" Fg(white)  Bold
execute "hi PreCondit" Fg(blue_br)  Bold
execute "hi Define" Fg(blue)  Normal
execute "hi Comment" Fg(fg1)
execute "hi Function" Fg(green_br) Normal
execute "hi Identifier" Fg(blue_br)
execute "hi Special" Fg(green_dk)
execute "hi Constant" Fg(fg3)
execute "hi Number" Fg(white)
execute "hi Todo" Fg(fg1) Bg(bg2)
execute "hi Error" Fg(red) Bg(bg2)
execute "hi Directory" Fg(blue_br)  Underline

# Filetype VIM
execute "hi vimCommentTitle" Fg(white)  Bold

# Filetype C
execute "hi cCppOut" Fg(fg2)
execute "hi cCppOutIf2" Fg(fg2)
execute "hi cParen" Fg(fg2)
execute "hi cBlock" Fg(fg2)

# filetype HTML
execute "hi htmlH1" Fg(green_br)  Bold
execute "hi htmlH2" Fg(green_br)  Bold
execute "hi htmlH3" Fg(green)  Bold

# markdown
execute "hi markdownCode" Fg(green)
execute "hi markdownCodeBlock" Fg(white)
execute "hi markdownUrl" Fg(blue_dk) Underline
execute "hi markdownLinkText" Fg(blue_br)  Normal

# restructured text
execute "hi rstEmphasis" Fg(green)
execute "hi rstStrongEmphasis" Fg(green)  Bold

# Diffs
execute "hi DiffChange" Fg(white)  Bg(bg0)
execute "hi DiffText"   Fg(blue_br) Bg(bg3)
execute "hi DiffDelete" Fg(red)   Bg(red)
execute "hi DiffAdd"    Fg(green_br) Bg(bg3)

# Plugin: Signify
execute "hi SignifySignAdd"             Fg(green)
execute "hi SignifySignDelete"          Fg(red)
execute "hi SignifySignDeleteFirstLine" Fg(red)
execute "hi SignifySignChange"          Fg(blue)
execute "hi SignifySignChangeDelete"    Fg(blue)

