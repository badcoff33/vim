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

var fg        = "#202030"
var bg        = "#FCFCFC"
var bg_dimmed = "#F0F0F0"

var blue_dk = "#1148AF"
var blue    = "#2188EF"
var blue_lt = "#90C0FF"
var blue_bg = "#B8D0F3"

var red_dk  = "#8F2352"
var red     = "#CF3372"
var red_lt  = "#EF486F"
var red_bg  = "#FFC8B8"

var gray_dk = "#444447"
var gray    = "#959598"
var gray_lt = "#E1E1E5"
var gray_bg = "#F1F1F4"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Gui = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

command -nargs=0 TwoToneBright execute "hi Normal" Fg(fg) Bg(bg) Gui("NONE")
command -nargs=0 TwoToneDimmed execute "hi Normal" Fg(fg) Bg(bg_dimmed) Gui("NONE")

execute "hi Bold" Gui("bold")
execute "hi CurSearch" Fg(black) Bg(gray_lt) Gui("bold")
execute "hi Cursor" Bg(black) Cterm("NONE")
execute "hi CursorLine" Bg(gray_bg) Cterm("NONE")
execute "hi CursorLineNr" Fg(gray) Gui("bold")
execute "hi Folded" Fg(blue) Bg(gray_lt) Gui("NONE")
execute "hi IncSearch" Fg(red_dk) Bg(red_bg) Gui("bold")
execute "hi Italic" Gui("italic")
execute "hi Label" Fg(black) Gui("bold")
execute "hi LineNr" Fg(gray) Gui("bold")
execute "hi MatchParen" Fg(blue) Bg("bg") Gui("underline,bold")
execute "hi NonText" Fg(gray) Bg("bg")
execute "hi Normal" Fg(fg) Bg(bg) Gui("NONE")
execute "hi Pmenu" Fg(white) Bg(blue)
execute "hi PmenuSbar" Fg(red) Bg(red)
execute "hi PmenuSel" Fg(white) Bg(blue_dk) Gui("bold")
execute "hi PmenuThumb" Fg(red_dk) Bg(gray_lt)
execute "hi Search" Fg(black) Bg(gray_lt) Gui("NONE")
execute "hi StatusLine" Fg(black) Bg(gray_lt) Gui("NONE")
execute "hi StatusLineNC" Fg(gray_dk) Bg(gray_lt) Gui("NONE")
execute "hi StatusLineTerm" Fg(white) Bg(red) Gui("bold")
execute "hi Terminal" Fg(white) Bg(gray_dk)
execute "hi User1" Fg(gray_lt) Bg(gray_dk) Gui("NONE")
execute "hi User2" Fg(blue_dk) Bg(gray) Gui("italic")
execute "hi VertSplit" Fg(gray_lt) Bg(gray_lt) Gui("NONE")
execute "hi Visual" Fg(blue_dk) Bg(blue_bg)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine StatusLineNC
highlight! link TabLineFill StatusLine
highlight! link TabLineSel Label
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(gray) Gui("NONE")
execute "hi Conditional" Fg(red)  Gui("bold")
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue_dk)
execute "hi Error" Fg(red) Bg("bg") Gui("underline")
execute "hi ErrorMsg" Fg(red) Bg(red_bg) Gui("NONE")
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(red) Gui("NONE")
execute "hi ModeMsg" Fg(blue) Bg("bg") Gui("NONE")
execute "hi Number" Fg(blue)
execute "hi PreCondit" Fg(blue)  Gui("bold")
execute "hi PreProc" Fg(blue) Gui("NONE")
execute "hi Question" Fg(gray_dk) Bg("bg")
execute "hi QuickFixLine" Fg(blue) Bg("bg") Gui("bold")
execute "hi Special" Fg(red_dk)
execute "hi SpecialKey" Fg(blue)
execute "hi Statement" Fg(blue_dk)  Gui("bold")
execute "hi StorageClass" Fg(red)
execute "hi String" Fg(blue_dk)
execute "hi Structure" Fg(red) Gui("NONE")
execute "hi Title" Fg(black)  Gui("bold")
execute "hi Todo" Fg(blue) Bg("bg") Gui("bold,italic")
execute "hi Type" Fg(blue) Gui("NONE")
execute "hi WarningMsg" Fg(blue_dk) Bg(blue_bg)
execute "hi qfFileName" Fg(blue_lt)
execute "hi qfLineNr" Fg(red_lt)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blue)  Gui("bold")

# Filetype C

execute "hi cCppOut" Bg(gray_lt) Gui("NONE")
execute "hi cCppOutIf2" Bg(gray_lt) Gui("NONE")
execute "hi cParen" Fg(gray_dk)
execute "hi cBlock" Fg(gray_dk)

# Filetype HTML

execute "hi htmlH1" Fg(blue_dk) Gui("bold")
execute "hi htmlH2" Fg(blue)    Gui("bold")
execute "hi htmlH3" Fg(blue)    Gui("NONE")

# Filetype Markdown

execute "hi markdownCode" Fg(gray_dk) Bg(gray_lt)
execute "hi markdownCode" Fg(blue) Gui("italic")
execute "hi markdownCodeBlock" Fg(gray_dk)
execute "hi rstEmphasis" Fg(gray_dk)
execute "hi rstStrongEmphasis" Fg(gray_dk)  Gui("bold")

# Diffs

execute "hi DiffChange" Fg(blue) Bg(gray_lt)
execute "hi DiffText" Fg(blue) Bg(blue_bg) Gui("bold")
execute "hi DiffDelete" Fg(red) Bg(red_bg)
execute "hi DiffAdd" Fg(gray_dk) Bg(gray_lt) Gui("bold")
