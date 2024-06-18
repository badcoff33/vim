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

var fg       = "#D8D8F0"
var fg_dk    = "#B3B3D0"
var bg       = "#1A253F"

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
var red     = "#EF3005"
var green   = "#10DD50"

var Fg      = (str) => empty(str) ? "" : "guifg=" .. str
var Bg      = (str) => empty(str) ? "" : "guibg=" .. str
var Attr    = (str) => empty(str) ? "" : "gui="   .. str
var Cterm   = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

execute "hi Bold" Attr("bold")
execute "hi CurSearch" Fg(black) Bg(orange) Attr("NONE")
execute "hi Cursor" Bg(yellow) Cterm("NONE")
execute "hi CursorLine" Bg(cl_bg) Cterm("NONE")
execute "hi CursorLineNr" Fg(white) Bg(red) Attr("bold")
execute "hi Folded" Fg(fg_dk) Bg(black) Attr("NONE")
execute "hi IncSearch" Fg(black) Bg(yellow) Attr("NONE")
execute "hi Italic" Attr("italic")
execute "hi Label" Fg(orange) Attr("bold")
execute "hi LineNr" Fg(blue) Attr("NONE")
execute "hi MatchParen" Fg(green) Bg("bg") Attr("bold")
execute "hi NonText" Fg(blue) Bg(cl_bg) Attr("NONE")
execute "hi Normal" Fg(fg) Bg(bg) Attr("NONE")
execute "hi Pmenu" Fg(gui_fg) Bg(black)
execute "hi PmenuSbar" Fg(blue_dk) Bg(blue_dk)
execute "hi PmenuSel" Fg(black) Bg(purple)
execute "hi PmenuThumb" Fg(blue_dk) Bg(blue_lt)
execute "hi Search" Fg(orange) Bg(black) Attr("underline")
execute "hi StatusLine" Fg(white) Bg(gui_bghl) Attr("NONE")
execute "hi StatusLineNC" Fg(blue_lt) Bg(gui_bg) Attr("NONE")
execute "hi StatusLineTerm" Fg(black) Bg(orange) Attr("NONE")
execute "hi TabLineFill" Fg(yellow) Bg(black) Attr('NONE')
execute "hi TabLineSel" Fg(yellow) Bg(bg) Attr('underline')
execute "hi Terminal" Fg(blue_lt) Bg(black)
execute "hi User1" Fg(black) Bg(green)
execute "hi User2" Fg(black) Bg(blue)
execute "hi VertSplit" Fg(gui_bg) Bg(gui_bg) Attr("NONE")
execute "hi Visual" Fg(white) Bg(blue_dk)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Normal
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(green) Attr("NONE")
execute "hi Conditional" Fg(blue_lt) Attr("NONE")
execute "hi Constant" Fg(green)
execute "hi Directory" Fg(blue) Attr("bold,underline")
execute "hi Error" Fg(orange) Bg("bg") Attr("underline")
execute "hi ErrorMsg" Fg(red) Bg(cl_bg) Attr("bold")
execute "hi Function" Fg(white)
execute "hi Identifier" Fg(fg_dk) Attr("NONE")
execute "hi ModeMsg" Fg(yellow) Bg(bg) Attr("NONE")
execute "hi MoreMsg" Fg(green) Bg(bg) Attr("NONE")
execute "hi Number" Fg(green)
execute "hi PreCondit" Fg(white) Attr("bold")
execute "hi PreProc" Fg(white) Attr("NONE")
execute "hi Question" Fg(white) Bg(bg)
execute "hi QuickFixLine" Fg(blue) Bg("bg") Attr("bold")
execute "hi Special" Fg(blue_dk)
execute "hi SpecialKey" Fg(blue) Attr("italic")
execute "hi Statement" Fg(white) Attr("bold")
execute "hi StorageClass" Fg(white)
execute "hi String" Fg(yellow)
execute "hi Structure" Fg(blue_dk) Attr("NONE")
execute "hi Title" Fg(white) Attr("bold")
execute "hi Todo" Fg(blue) Bg("bg") Attr("bold,italic")
execute "hi Type" Fg(blue) Attr("italic")
execute "hi WarningMsg" Fg(blue) Bg(cl_bg)
execute "hi qfFileName" Fg(blue_lt)
execute "hi qfLineNr" Fg(blue)

# Filetype VIM

execute "hi vimCommentTitle" Fg(yellow) Attr("bold")

# Filetype C

execute "hi cCppOut" Bg(blue_lt) Attr("NONE")
execute "hi cCppOutIf2" Bg(blue_lt) Attr("NONE")
execute "hi cParen" Fg(blue)
execute "hi cBlock" Fg(blue)

# Filetype HTML

execute "hi htmlH1" Fg(blue_lt) Attr("bold")
execute "hi htmlH2" Fg(blue) Attr("bold")
execute "hi htmlH3" Fg(blue) Attr("NONE")

# Filetype Markdown

execute "hi markdownCode" Fg(green) Bg(cl_bg)
execute "hi markdownCodeBlock" Fg(green) Bg(cl_bg)

# Filetype ReStructuorangeText

execute "hi rstEmphasis" Fg(blue_lt)
execute "hi rstStrongEmphasis" Fg(blue_lt) Attr("bold")

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
