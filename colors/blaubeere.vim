vim9script
# Vim color theme
#
# Description: Four base colors in four flavours.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=light

g:colors_name = "blaubeere"

var black       = "#000000"
var white       = "#FFFFFF"
var blue_dk     = "#4841AF"
var blue        = "#6A61EF"
var blue_lt     = "#CFC8F3"
var yellow      = "#FFE895"
var yellow_dk   = "#9D8E77"
var red         = "#FB8A9C"
var red_dk      = "#BC6D76"
var green       = "#7FCA7C"
var green_dk    = "#4FA04C"
var aluminium_0 = "#2e3436"
var aluminium_1 = "#555753"
var aluminium_2 = "#888a85"
var aluminium_3 = "#babdb6"
var aluminium_4 = "#d3d7cf"
var aluminium_5 = "#eeeeec"

var fg = "#404040"
var bg = "#FFFFFF"
var shadow_bg = "#F0F0F0"
var shadow_fg = "#E0E0E0"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Gui = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

execute "hi Bold" Gui("bold")
execute "hi CurSearch" Bg(aluminium_5) Gui("BOLD")
execute "hi Cursor" Bg(black) Cterm("NONE")
execute "hi CursorLine" Bg(shadow_bg) Cterm("NONE")
execute "hi CursorLineNr" Fg(aluminium_2) Bg(aluminium_5) Gui("bold")
execute "hi Folded" Fg(blue) Bg(blue_lt) Gui("NONE")
execute "hi IncSearch" Fg(white) Bg(blue) Gui("NONE")
execute "hi Italic" Gui("italic")
execute "hi Label" Fg(black) Gui("bold")
execute "hi LineNr" Fg(aluminium_5) Gui("bold")
execute "hi MatchParen" Fg(green_dk) Bg(green) Gui("bold")
execute "hi NonText" Fg(aluminium_3) Bg("bg")
execute "hi Normal" Fg(fg) Bg(bg) Gui("NONE")
execute "hi Operator" Fg(green) Gui("NONE")
execute "hi Pmenu" Fg(black) Bg(yellow)
execute "hi PmenuSbar" Fg(aluminium_5) Bg(aluminium_4)
execute "hi PmenuSel" Fg(black) Bg(yellow_dk) Gui("NONE")
execute "hi PmenuThumb" Fg(aluminium_2) Bg(aluminium_3)
execute "hi Search" Bg(aluminium_5) Gui("NONE")
execute "hi StatusLine" Fg(white) Bg(aluminium_2) Gui("NONE")
execute "hi StatusLineNC" Fg(black) Bg(aluminium_3) Gui("NONE")
execute "hi StatusLineTerm" Fg(white) Bg(blue) Gui("NONE")
execute "hi TabLine" Fg(aluminium_3) Bg(shadow_bg) Gui("NONE")
execute "hi TabLineFill" Fg(black) Bg(shadow_bg) Gui("NONE")
execute "hi TabLineSel" Fg(black) Bg(bg) Gui("bold")
execute "hi Terminal" Fg(fg) Bg(bg)
execute "hi User1" Fg(white) Bg(aluminium_4) Gui("NONE")
execute "hi User2" Fg(blue_lt) Bg(blue_dk) Gui("italic")
execute "hi VertSplit" Fg(aluminium_5) Bg(aluminium_3) Gui("NONE")
execute "hi Visual" Fg(black) Bg(blue_lt)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(green_dk) Gui("NONE")
execute "hi Conditional" Fg(red)  Gui("NONE")
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue_dk)
execute "hi Error" Fg(red) Bg("bg") Gui("underline")
execute "hi ErrorMsg" Fg(red_dk) Bg(red) Gui("NONE")
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(red) Gui("NONE")
execute "hi ModeMsg" Fg(black) Bg(yellow) Gui("NONE")
execute "hi Number" Fg(blue)
execute "hi PreCondit" Fg(blue)  Gui("bold")
execute "hi PreProc" Fg(blue) Gui("NONE")
execute "hi Question" Fg(aluminium_2) Bg("bg")
execute "hi QuickFixLine" Fg(blue) Bg("bg") Gui("bold")
execute "hi Special" Fg(red_dk)
execute "hi SpecialKey" Fg(blue)
execute "hi Statement" Fg(blue_dk)  Gui("NONE")
execute "hi StorageClass" Fg(red)
execute "hi String" Fg(yellow_dk)
execute "hi Structure" Fg(red) Gui("NONE")
execute "hi Title" Fg(blue_dk)  Gui("bold")
execute "hi Todo" Fg(blue) Bg("bg") Gui("bold,italic")
execute "hi Type" Fg(red_dk) Gui("NONE")
execute "hi WarningMsg" Fg(blue_dk) Bg(blue_lt)
execute "hi qfFileName" Fg(blue_lt)
execute "hi qfLineNr" Fg(red)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blue)  Gui("bold")

# Filetype C

execute "hi cCppOut" Bg(aluminium_4) Gui("NONE")
execute "hi cCppOutIf" Gui("italic")
execute "hi cCppOutIf2" Bg(aluminium_4) Gui("italic")
execute "hi cParen" Fg(aluminium_2)
execute "hi cBlock" Fg(aluminium_2)

# Filetype HTML

execute "hi htmlH1" Fg(blue_dk) Gui("bold")
execute "hi htmlH2" Fg(blue)    Gui("bold")
execute "hi htmlH3" Fg(blue)    Gui("NONE")

# Filetype Markdown

execute "hi markdownCode" Fg(aluminium_2) Bg(aluminium_4)
execute "hi markdownCode" Fg(green_dk) Gui("italic")
execute "hi markdownCodeBlock" Fg(green_dk) Gui("italic")
execute "hi rstEmphasis" Fg(aluminium_2)
execute "hi rstStrongEmphasis" Fg(aluminium_2)  Gui("bold")

# Diffs

execute "hi DiffChange" Fg(blue) Bg(aluminium_4)
execute "hi DiffText" Fg(blue) Bg(blue_lt) Gui("bold")
execute "hi DiffDelete" Fg(red) Bg(red)
execute "hi DiffAdd" Fg(aluminium_2) Bg(aluminium_4) Gui("bold")

# Signify

execute "hi SignifySignAdd"             Fg(green)
execute "hi SignifySignDelete"          Fg(red)
execute "hi SignifySignDeleteFirstLine" Fg(red)
execute "hi SignifySignChange"          Fg(blue)
execute "hi SignifySignChangeDelete"    Fg(blue)

