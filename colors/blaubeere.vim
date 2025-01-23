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

var fg          = "#404040"
var bg          = "#FFFFFF"
var cl_bg       = "#E5FCEF"
var shadow_bg   = "#F6F6F6"
var shadow_fg   = "#C0C0C0"
var black       = "#000000"
var white       = "#FFFFFF"
var blue_dk     = "#48416F"
var blue        = "#8A81BF"
var blue_lt     = "#ACC6DB"
var yellow      = "#FFE895"
var yellow_dk   = "#9D8E77"
var red         = "#FB8A9C"
var red_dk      = "#BC6D76"
var green       = "#7FCA7C"
var green_dk    = "#65A06F"
var aluminium_0 = "#2e3436"
var aluminium_1 = "#555753"
var aluminium_2 = "#888a85"
var aluminium_3 = "#babdb6"
var aluminium_4 = "#d3d7cf"
var aluminium_5 = "#eeeeec"

var Fg      = (str) => empty(str) ? "" : "guifg=" .. str
var Bg      = (str) => empty(str) ? "" : "guibg=" .. str
var Gui     = (str) => empty(str) ? "" : "gui=" .. str
var Cterm   = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

var Normal = "gui=NONE"
var Bold = "gui=bold"
var Italic = "gui=italic"
var Underline = "gui=underline"
var BoldUnderline = "gui=bold,underline"

# Basics

execute "hi Bold" Bold
execute "hi CurSearch" Fg(green_dk) Bg(aluminium_5) Bold
execute "hi Cursor" Bg(black) Cterm("NONE")
execute "hi CursorLine" Bg(cl_bg) Cterm("NONE")
execute "hi CursorLineNr" Fg(aluminium_2) Bg(aluminium_5) Bold
execute "hi Folded" Fg(blue) Bg(blue_lt) Normal
execute "hi IncSearch" Fg(white) Bg(aluminium_0) Normal
execute "hi Italic" Italic
execute "hi Label" Fg(black) Bold
execute "hi LineNrAbove" Fg(red) Bold
execute "hi LineNr" Fg(aluminium_2) Bold
execute "hi LineNrBelow" Fg(blue) Bold
execute "hi MatchParen" Fg(green_dk) Bg(bg) Underline
execute "hi NonText" Fg(aluminium_3) Bg("bg")
execute "hi Normal" Fg(fg) Bg(bg) Normal
execute "hi Operator" Fg(green) Normal
execute "hi Pmenu" Fg(aluminium_1) Bg(aluminium_5)
execute "hi PmenuSbar" Fg(aluminium_4) Bg(aluminium_4)
execute "hi PmenuSel" Fg(white) Bg(green_dk) Normal
execute "hi PmenuMatchSel" Fg(white) Bg(black) Normal
execute "hi PmenuThumb" Fg(green) Bg(green)
execute "hi Search" Bg(aluminium_5) Normal
execute "hi StatusLine" Fg(blue_lt) Bg(blue_dk) Normal
execute "hi StatusLineNC" Fg(aluminium_2) Bg(aluminium_5) Normal
execute "hi StatusLineTerm" Fg(white) Bg(blue) Normal
execute "hi TabLine" Fg(aluminium_2) Bg(shadow_bg) Normal
execute "hi TabLineFill" Fg(black) Bg(shadow_bg) Normal
execute "hi TabLineSel" Fg(blue_lt) Bg(blue_dk) Bold
execute "hi Terminal" Fg(fg) Bg(bg)
execute "hi User1" Fg(white) Bg(aluminium_4) Normal
execute "hi User2" Fg(blue_lt) Bg(blue_dk) Italic
execute "hi VertSplit" Fg(aluminium_4) Bg("bg") Normal
execute "hi Visual" Fg(black) Bg(aluminium_4)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link PopupNotification StatusLineNC
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(green_dk) Normal
execute "hi Conditional" Fg(red)  Normal
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue_dk) Underline
execute "hi Error" Fg(red) Bg("bg") Gui("underline")
execute "hi ErrorMsg" Fg(red_dk) Bg("bg") Normal
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(green_dk) Normal
execute "hi Ignore" Fg(aluminium_3) Italic
execute "hi ModeMsg" Fg(black) Bg(yellow) Normal
execute "hi Number" Fg(blue)
execute "hi PreCondit" Fg(blue)  Bold
execute "hi PreProc" Fg(blue) Normal
execute "hi Question" Fg(aluminium_2) Bg("bg")
execute "hi QuickFixLine" Fg(blue) Bg("bg") Bold
execute "hi Special" Fg(red_dk)
execute "hi SpecialKey" Fg(blue)
execute "hi Statement" Fg(blue_dk)  Normal
execute "hi StorageClass" Fg(red)
execute "hi String" Fg(yellow_dk)
execute "hi Structure" Fg(red) Normal
execute "hi Title" Fg(yellow_dk)  Bold
execute "hi Todo" Fg(blue) Bg("bg") Gui("bold,italic")
execute "hi Type" Fg(red_dk) Normal
execute "hi WarningMsg" Fg(white) Bg(green_dk)
execute "hi qfFileName" Fg(blue_lt)
execute "hi qfLineNr" Fg(red)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blue)  Bold

# Filetype C

execute "hi cCppOut" Bg(aluminium_4) Normal
execute "hi cCppOutIf" Italic
execute "hi cCppOutIf2" Bg(aluminium_4) Italic
execute "hi cParen" Fg(aluminium_2)
execute "hi cBlock" Fg(aluminium_2)

# Filetype HTML

execute "hi htmlH1" Fg(blue_dk) Bold
execute "hi htmlH2" Fg(blue)    Bold
execute "hi htmlH3" Fg(blue)    Normal
execute "hi htmlItalic" Fg(shadow_fg) Italic

# Filetype Markdown

execute "hi markdownCode" Fg(aluminium_2) Bg(aluminium_5)
execute "hi markdownCodeBlock" Fg(aluminium_2) Italic
execute "hi rstEmphasis" Fg(aluminium_2)
execute "hi rstStrongEmphasis" Fg(aluminium_2)  Bold

# Diffs

execute "hi DiffChange" Fg(blue) Bg(aluminium_4)
execute "hi DiffText" Fg(blue) Bg(blue_lt) Bold
execute "hi DiffDelete" Fg(red) Bg(red)
execute "hi DiffAdd" Fg(aluminium_2) Bg(aluminium_4) Bold

# Signify

execute "hi SignifySignAdd"             Fg(green)
execute "hi SignifySignDelete"          Fg(red)
execute "hi SignifySignDeleteFirstLine" Fg(red)
execute "hi SignifySignChange"          Fg(blue)
execute "hi SignifySignChangeDelete"    Fg(blue)
