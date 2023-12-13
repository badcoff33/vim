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
set background=dark

g:colors_name = "twotone_dark"

var black    = "#000000"
var white    = "#FFFFFF"

var def_bg   = "#102030"
var def_fg   = "#FFF2FF"

var blue_dk = "#1148AF"
var blue    = "#2188EF"
var blue_lt = "#28B8FF"
var blue_bg = "#203890"

var red_dk  = "#CF3362"
var red     = "#EF4392"
var red_lt  = "#FFA8B8"
var red_bg  = "#902038"

var gray_dk = "#25333F"
var gray    = "#60717F"
var gray_lt = "#C0D5EF"

var Fg      = (str) => empty(str) ? "" : "guifg=" .. str
var Bg      = (str) => empty(str) ? "" : "guibg=" .. str
var Attr    = (str) => empty(str) ? "" : "gui="   .. str
var Cterm   = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

execute "hi Bold" Attr("bold")
execute "hi CurSearch" Fg(blue_lt) Bg(blue_bg) Attr("NONE")
execute "hi Cursor" Bg(blue) Cterm("NONE")
execute "hi CursorLine" Bg(gray_dk) Cterm("NONE")
execute "hi CursorLineNr" Fg(gray) Attr("bold")
execute "hi Folded" Fg(blue) Bg(gray_lt) Attr("NONE")
execute "hi IncSearch" Fg(red_lt) Bg(red_bg) Attr("NONE")
execute "hi Italic" Attr("italic")
execute "hi Label" Fg(black) Attr("bold")
execute "hi LineNr" Fg(gray) Attr("bold")
execute "hi MatchParen" Fg(blue) Bg("bg") Attr("underline,bold")
execute "hi NonText" Fg(gray) Bg("bg") Attr("NONE")
execute "hi Normal" Fg(def_fg) Bg(def_bg) Attr("NONE")
execute "hi Pmenu" Fg(blue_lt) Bg(blue_dk)
execute "hi PmenuSbar" Fg(red) Bg(red)
execute "hi PmenuSel" Fg(white) Bg(blue) Attr("bold")
execute "hi PmenuThumb" Fg(gray_dk) Bg(gray_lt)
execute "hi Search" Fg(blue_lt) Bg(gray_dk) Attr("NONE")
execute "hi StatusLine" Fg(white) Bg(blue_dk) Attr("NONE")
execute "hi StatusLineNC" Fg(white) Bg(gray_dk) Attr("NONE")
execute "hi StatusLineTerm" Fg(white) Bg(red) Attr("bold")
execute "hi User1" Fg(white) Bg(blue)
execute "hi User2" Fg(white) Bg(blue)
execute "hi VertSplit" Fg(gray_dk) Bg(gray_dk) Attr("NONE")
execute "hi Visual" Fg(blue_lt) Bg(blue_dk)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Pmenu
highlight! link TabLineFill Normal
highlight! link TabLineSel PmenuSel
highlight! link Terminal Normal
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(gray) Attr("NONE")
execute "hi Conditional" Fg(gray_lt) Attr("bold")
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue) Attr("bold,underline")
execute "hi Error" Fg(red) Bg("bg") Attr("underline")
execute "hi ErrorMsg" Fg(red_lt) Bg(red_dk) Attr("NONE")
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(red) Attr("NONE")
execute "hi ModeMsg" Fg(white) Bg(blue) Attr("NONE")
execute "hi MoreMsg" Fg(white) Bg(red_bg) Attr("NONE")
execute "hi Number" Fg(blue)
execute "hi PreCondit" Fg(blue) Attr("bold")
execute "hi PreProc" Fg(blue) Attr("NONE")
execute "hi Question" Fg(white) Bg(red_bg)
execute "hi QuickFixLine" Fg(blue) Bg("bg") Attr("bold")
execute "hi Special" Fg(red_dk)
execute "hi SpecialKey" Fg(blue) Attr("italic")
execute "hi Statement" Fg(white) Attr("bold")
execute "hi StorageClass" Fg(red)
execute "hi String" Fg(blue_lt)
execute "hi Structure" Fg(red) Attr("NONE")
execute "hi Title" Fg(white) Attr("bold")
execute "hi Todo" Fg(blue) Bg("bg") Attr("bold,italic")
execute "hi Type" Fg(blue) Attr("NONE")
execute "hi WarningMsg" Fg(white) Bg(blue)
execute "hi qfFileName" Fg(blue_lt)
execute "hi qfLineNr" Fg(red_lt)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blue) Attr("bold")

# Filetype C

execute "hi cCppOut" Bg(gray_lt) Attr("NONE")
execute "hi cCppOutIf2" Bg(gray_lt) Attr("NONE")
execute "hi cParen" Fg(gray)
execute "hi cBlock" Fg(gray)

# Filetype HTML

execute "hi htmlH1" Fg(blue_lt) Attr("bold")
execute "hi htmlH2" Fg(blue) Attr("bold")
execute "hi htmlH3" Fg(blue) Attr("NONE")

# Filetype Markdown

execute "hi markdownCode" Fg(gray) Bg(gray_lt)
execute "hi markdownCode" Fg(blue) Attr("italic")
execute "hi markdownCodeBlock" Fg(gray_dk)

# Filetype ReStructuredText

execute "hi rstEmphasis" Fg(gray_dk)
execute "hi rstStrongEmphasis" Fg(gray_dk) Attr("bold")

# Diffs

execute "hi DiffChange" Fg(gray_lt) Bg(gray_dk)
execute "hi DiffText" Fg(blue) Bg(gray_dk)
execute "hi DiffDelete" Fg(red_lt) Bg(red_bg)
execute "hi DiffAdd" Fg(blue_lt) Bg(gray_dk)
