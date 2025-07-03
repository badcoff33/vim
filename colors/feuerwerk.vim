vim9script
# Vim color theme
#
# Description: Keep things reduced.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=dark

g:colors_name = "feuerwerk"

const black    = "#000000"
const white    = "#FFFFFF"

const fg        = "#D8D8F0"
const fg_dk     = "#A3A3C0"
const fg_moredk = "#63739F"
const bg_lt     = "#252F48"
const bg        = "#1A253F"
const bg_dk     = "#101E28"

const gui_bgdk = "#203858"
const gui_bg   = "#204060"
const gui_bghl = "#5060A0"
const gui_fg   = "#BBDDFF"
const cl_bg    = "#101D33"

const blue_lt  = "#91AAFF"
const blue     = "#718FE3"
const blue_dk  = "#6380C0"
const blue_bg  = "#4360A0"

const yellow  = "#F8F840"
const purple  = "#C175F1"
const orange  = "#E1BC16"
const red     = "#EF4025"
const green   = "#10DD50"

var Fg      = (str) => empty(str) ? "" : "guifg=" .. str
var Bg      = (str) => empty(str) ? "" : "guibg=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

const Normal        = "gui=NONE cterm=NONE"
const Bold          = "gui=bold"
const Italic        = "gui=italic"
const Underline     = "gui=underline"
const BoldUnderline = "gui=bold,underline"
const BoldItalic    = "gui=bold,italic"

# Basics

execute "hi Bold" Bold
execute "hi CurSearch" Fg(black) Bg(orange) Normal
execute "hi Cursor" Fg(black) Bg(white) Normal
execute "hi CursorLine" Bg(cl_bg) Normal
execute "hi CursorLineNr" Fg(purple) Bg(cl_bg) Normal
execute "hi Folded" Fg(fg_dk) Bg(black) Normal
execute "hi IncSearch" Fg(black) Bg(purple) Normal
execute "hi Italic" Italic
execute "hi Label" Fg(orange) Bold
execute "hi LineNr" Fg(fg_moredk) Normal
execute "hi MatchParen" Fg(green) Bg("bg") Normal
execute "hi NonText" Fg(fg_moredk) Bg(cl_bg) Normal
execute "hi Normal" Fg(fg) Bg(bg_dk) Normal
execute "hi Pmenu" Fg(yellow) Bg(gui_bghl)
execute "hi PmenuSbar" Fg(blue_dk) Bg(blue_dk)
execute "hi PmenuSel" Fg(black) Bg(yellow)
execute "hi PmenuMatchSel" Fg(black) Bg(yellow) Underline
execute "hi PmenuThumb" Fg(blue_dk) Bg(blue_lt)
execute "hi PopupNotification" Fg(white) Bg(blue_bg)
execute "hi Search" Fg(purple) Bg(gui_bg) Normal
execute "hi StatusLine" Fg(white) Bg(gui_bghl) Normal
execute "hi StatusLineNC" Fg(gui_fg) Bg(gui_bg) Normal
execute "hi StatusLineTerm" Fg(black) Bg(orange) Normal
execute "hi TabPanelSel" Fg(yellow) Bg(bg_dk) Bold
execute "hi TabLineFill" Fg(yellow) Bg(bg) Normal
execute "hi TabLineSel" Fg(yellow) Bg(black) Underline
execute "hi Terminal" Fg(green) Bg(bg)
execute "hi User1" Fg(orange) Bg(gui_bghl) Bold
execute "hi User2" Fg(green) Bg(gui_bghl)
execute "hi VertSplit" Fg(gui_bg) Bg(gui_bg) Normal
execute "hi Visual" Fg(white) Bg(blue_dk)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Normal
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(fg_moredk) Normal
execute "hi Conditional" Fg(blue_lt) Normal
execute "hi Constant" Fg(green)
execute "hi Directory" Fg(blue) BoldUnderline
execute "hi Error" Fg(orange) Bg(cl_bg) Underline
execute "hi ErrorMsg" Fg(black) Bg(red) Normal
execute "hi Function" Fg(white)
execute "hi Identifier" Fg(fg_dk) Normal
execute "hi ModeMsg" Fg(green) Normal
execute "hi MoreMsg" Fg(purple) Normal
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
execute "hi cCppOutIf2" Italic
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

execute "hi DiffChange" Fg(blue) Bg(black)
execute "hi DiffText" Fg(yellow) Bg(bg)
execute "hi DiffDelete" Fg(orange) Bg(red)
execute "hi DiffAdd" Fg(blue_lt) Bg(black)

# Signify
execute "hi SignifySignAdd"             Fg(green)
execute "hi SignifySignDelete"          Fg(red)
execute "hi SignifySignDeleteFirstLine" Fg(red)
execute "hi SignifySignChange"          Fg(blue)
execute "hi SignifySignChangeDelete"    Fg(blue)
