vim9script
# Vim color theme
#
# Description: Keep things reduced.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=dark

g:colors_name = "sparks"

var black    = "#000000"
var white    = "#FFFFFF"

var fg        = "#D8D8F0"
var fg_dk     = "#B3B3D0"
var fg_moredk = "#63739F"
var bg        = "#18233D"
var bg_hl     = "#1F2845"

var gui_bgdk = "#203050"
var gui_bg   = "#204060"
var gui_bghl = "#5060A0"
var gui_fg   = "#BBDDFF"
var cl_bg    = "#101D33"

var blue_lt  = "#91AAFF"
var blue     = "#718FE3"
var blue_dk  = "#6380C0"

var yellow  = "#F8E840"
var purple  = "#C175F1"
var orange  = "#E1BC16"
var red     = "#EF4025"
var green   = "#10DD50"

var Fg      = (str) => empty(str) ? "" : "guifg=" .. str
var Bg      = (str) => empty(str) ? "" : "guibg=" .. str
var Attr    = (str) => empty(str) ? "" : "gui="   .. str
var Cterm   = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

var Normal = "gui=NONE"
var Bold = "gui=bold"
var Italic = "gui=italic"
var Underline = "gui=underline"
var BoldUnderline = "gui=bold,underline"
var BoldItalic = "gui=bold,italic"

# Basics

execute "hi Bold" Bold
execute "hi CurSearch" Fg(black) Bg(orange) Normal
execute "hi Cursor" Fg(black) Bg(white) Cterm("NONE")
execute "hi CursorLine" Bg(cl_bg) Cterm("NONE")
execute "hi CursorLineNr" Fg(purple) Bg(cl_bg) Normal
execute "hi Folded" Fg(fg_dk) Bg(black) Normal
execute "hi IncSearch" Fg(black) Bg(yellow) Normal  Cterm("NONE")
execute "hi Italic" Italic
execute "hi Label" Fg(orange) Bold
execute "hi LineNr" Fg(fg_moredk) Normal
execute "hi MatchParen" Fg(green) Bg("bg") Bold
execute "hi NonText" Fg(blue) Bg(cl_bg) Normal
execute "hi Normal" Fg(fg) Bg(bg) Normal
execute "hi NormalWinHl" Fg(fg) Bg(bg_hl) Normal
execute "hi Pmenu" Fg(black) Bg(orange)
execute "hi PmenuSbar" Fg(blue_dk) Bg(blue_dk)
execute "hi PmenuSel" Fg(black) Bg(yellow)
execute "hi PmenuThumb" Fg(blue_dk) Bg(blue_lt)
execute "hi Search" Fg(green) Bg(black) Underline
execute "hi StatusLine" Fg(gui_fg) Bg(gui_bg) Normal
execute "hi StatusLineNC" Fg(gui_fg) Bg(gui_bgdk) Normal
execute "hi StatusLineTerm" Fg(black) Bg(orange) Normal
execute "hi TabLineFill" Fg(yellow) Bg(black) Normal
execute "hi TabLineSel" Fg(yellow) Bg(bg) Underline
execute "hi Terminal" Fg(blue_lt) Bg(bg)
execute "hi User1" Fg(black) Bg(green)
execute "hi User2" Fg(black) Bg(blue)
execute "hi VertSplit" Fg(gui_bg) Bg(gui_bg) Normal
execute "hi Visual" Fg(white) Bg(blue_dk)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link PopupNotification StatusLineNC
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Normal
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(fg_dk) Normal
execute "hi Conditional" Fg(blue_lt) Normal
execute "hi Constant" Fg(green)
execute "hi Directory" Fg(blue) BoldUnderline
execute "hi Error" Fg(orange) Bg(cl_bg) Underline
execute "hi ErrorMsg" Fg(black) Bg(red) Normal
execute "hi Function" Fg(white)
execute "hi Identifier" Fg(fg_dk) Normal
execute "hi ModeMsg" Fg(black) Bg(green) Normal
execute "hi MoreMsg" Fg(green) Bg(bg) Normal
execute "hi Number" Fg(green)
execute "hi PreCondit" Fg(white) Bold
execute "hi PreProc" Fg(white) Normal
execute "hi Question" Fg(white) Bg(bg)
execute "hi QuickFixLine" Fg(blue) Bg("black") Bold
execute "hi Special" Fg(blue_dk)
execute "hi SpecialKey" Fg(blue) Normal
execute "hi Statement" Fg(white) Normal
execute "hi StorageClass" Fg(purple)
execute "hi String" Fg(yellow)
execute "hi Structure" Fg(blue_dk) Normal
execute "hi Title" Fg(white) Bold
execute "hi Todo" Fg(blue) Bg("bg") Bold
execute "hi Type" Fg(blue) Normal
execute "hi WarningMsg" Fg(black) Bg(blue) Normal
execute "hi qfFileName" Fg(blue_lt)
execute "hi qfLineNr" Fg(blue)

# Filetype VIM

execute "hi vimCommentTitle" Fg(yellow) Bold

# Filetype C

execute "hi cCppOut" Bg(blue_lt) Normal
execute "hi cCppOutIf2" Bg(blue_lt) Normal
execute "hi cParen" Fg(blue)
execute "hi cBlock" Fg(blue)

# Filetype HTML

execute "hi htmlH1" Fg(blue_lt) Bold
execute "hi htmlH2" Fg(blue) Bold
execute "hi htmlH3" Fg(blue) Normal

# Filetype Markdown

execute "hi markdownCode" Fg(green) Bg(cl_bg)
execute "hi markdownCodeBlock" Fg(green) Bg(bg)

# Filetype ReStructuorangeText

execute "hi rstEmphasis" Fg(blue_lt)
execute "hi rstStrongEmphasis" Fg(blue_lt) Bold

# Filetype Cmake

execute "hi cmakeArguments" Fg(green) Bg("Bg") Normal

# Diffs

execute "hi DiffChange" Fg(yellow) Bg(black)
execute "hi DiffText" Fg(blue) Bg(black)
execute "hi DiffDelete" Fg(black) Bg(red)
execute "hi DiffAdd" Fg(blue_lt) Bg(black)

# Signify

highlight! link SignifySignAdd DiffAdd
highlight! link SignifySignDelete DiffDelete
highlight! link SignifySignDeleteFirstLine DiffDelete
highlight! link SignifySignChange DiffChange
highlight! link SignifySignChangeDelete DiffChange
