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

g:colors_name = "two_tone"

var black = "#000000"
var white = "#FFFFFF"

var fg = "#162030"
var bg = "#FEFEFF"

var blue_dk = "#11489F"
var blue    = "#2183DF"
var blue_lt = "#80B0EF"
var blue_bg = "#AFD8FF"

var red_dk = "#AF2348"
var red    = "#CF3362"
var red_lt = "#EF4850"
var red_bg = "#FFC3C8"

var gray_dk = "#444447"
var gray    = "#959598"
var gray_lt = "#D1D1D5"
var gray_bg = "#F3F3F3"

var Normal        = "gui=NONE"
var Bold          = "gui=bold"
var Italic        = "gui=italic"
var Underline     = "gui=underline"
var BoldUnderline = "gui=bold,underline"
var BoldItalic    = "gui=bold,italic"

var Fg      = (str) => empty(str) ? "" : "guifg=" .. str
var Bg      = (str) => empty(str) ? "" : "guibg=" .. str
var Gui     = (str) => empty(str) ? "" : "gui=" .. str
var Cterm   = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

execute "hi Bold" Bold
execute "hi Conceal" Fg(blue) Bg(bg) Normal
execute "hi CurSearch" Fg(red_dk) Bg(red_bg) Normal
execute "hi Cursor" Fg(white) Bg(red) Cterm("NONE")
execute "hi CursorLine" Bg(gray_bg) Cterm("NONE")
execute "hi CursorLineNr" Fg(blue) Bg(blue_bg) Bold
execute "hi Folded" Fg(blue) Bg(gray_lt) Normal
execute "hi FoldColumn" Fg(blue) Bg("bg") Normal
execute "hi IncSearch" Fg(white) Bg(black) Bold
execute "hi Italic" Italic
execute "hi Label" Fg(black) Bold
execute "hi LineNr" Fg(gray_lt) Bg(white) Bold
execute "hi MatchParen" Fg(blue) Bg("bg") Underline
execute "hi NonText" Fg(gray) Bg("bg")
execute "hi Normal" Fg(fg) Bg(bg) Normal
execute "hi Pmenu" Fg(black) Bg(blue_bg)
execute "hi PmenuMatch" Fg(black) Bg(red_bg) Underline
execute "hi PmenuMatchSel" Fg(white) Bg(blue) BoldUnderline
execute "hi PmenuSbar" Fg(red_lt) Bg(red_lt)
execute "hi PmenuSel" Fg(white) Bg(blue) Bold
execute "hi PmenuThumb" Fg(red_dk) Bg(red_dk)
execute "hi Search" Fg(blue_dk) Bg(blue_bg) Normal
execute "hi StatusLine" Fg(white) Bg(black) Normal
execute "hi StatusLineNC" Fg(black) Bg(blue_bg) Normal
execute "hi StatusLineTerm" Fg(white) Bg(blue_dk) Bold
execute "hi TabLine" Fg("fg") Bg(gray_bg) Gui("none")
execute "hi TabLineFill" Fg("fg") Bg(gray_bg) Gui("none")
execute "hi TabLineSel" Fg(white) Bg(blue) Bold
execute "hi Terminal" Fg(gray_dk) Bg(bg)
execute "hi User1" Fg(blue_bg) Bg(black) Normal
execute "hi User2" Fg(red_bg) Bg(black) Normal
execute "hi VertSplit" Fg(gray_lt) Bg(gray_bg) Normal
execute "hi Visual" Fg(white) Bg(blue)

highlight! link CursorColumn CursorLine
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal
highlight! link PopupNotification StatusLine

# Code

execute "hi Comment" Fg(gray) Normal
execute "hi Constant" Fg(blue)
execute "hi Define" Fg(blue_dk) Bold
execute "hi Directory" Fg(blue_dk)
execute "hi Error" Fg(red_dk) Bg(red_bg)
execute "hi ErrorMsg" Fg(red_dk) Bg(red_bg) Normal
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(red) Normal
execute "hi Macro" Fg(blue_dk) Bold
execute "hi ModeMsg" Fg(blue) Bg("bg") Normal
execute "hi Number" Fg(blue)
execute "hi PreCondit" Fg(blue) Bold
execute "hi PreProc" Fg(blue) Normal
execute "hi Question" Fg(gray_dk) Bg("bg")
execute "hi QuickFixLine" Fg(red_dk) Bg(red_bg) Bold
execute "hi Special" Fg(red)
execute "hi SpecialKey" Fg(blue)
execute "hi Statement" Fg(black) Bold
execute "hi StorageClass" Fg(red_dk)
execute "hi String" Fg(red_dk)
execute "hi Structure" Fg(red) Normal
execute "hi Title" Fg(blue_dk) Bold
execute "hi Todo" Fg(blue) Bg("bg") Gui("bold,italic")
execute "hi Type" Fg(blue) Normal
execute "hi WarningMsg" Fg(blue_dk) Bg(blue_bg)
execute "hi qfFileName" Fg(blue_lt)
execute "hi qfLineNr" Fg(red_lt)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blue) Bold

# Filetype C

execute "hi cCppOut" Bg(gray_lt) Normal
execute "hi cCppOutIf2" Bg(gray_lt) Normal
execute "hi cParen" Fg(gray_dk)
execute "hi cBlock" Fg(gray_dk)

# Filetype HTML

execute "hi htmlH1" Fg(blue_dk) Bold
execute "hi htmlH2" Fg(blue) Bold
execute "hi htmlH3" Fg(blue) Normal

# Filetype Markdown

execute "hi markdownCode" Fg(blue)
execute "hi markdownCodeBlock" Fg(black) Italic
execute "hi rstEmphasis" Fg(gray_dk)
execute "hi rstStrongEmphasis" Fg(gray_dk) Bold

# Diffs

execute "hi DiffChange" Fg(gray_dk) Bg(gray_bg)
execute "hi DiffText" Fg(blue_dk) Bg(blue_bg) Normal
execute "hi DiffDelete" Fg(red_bg) Bg(red_bg)
execute "hi DiffAdd" Fg(white) Bg(gray_dk) Normal

# Signify

execute "hi SignifySignAdd"             Fg(blue_dk)
execute "hi SignifySignDelete"          Fg(red)
execute "hi SignifySignDeleteFirstLine" Fg(red)
execute "hi SignifySignChange"          Fg(blue_lt)
execute "hi SignifySignChangeDelete"    Fg(red_lt)
