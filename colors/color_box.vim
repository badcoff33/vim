vim9script
# Vim color theme
#
# Description: Four base colors in four flavours.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=light

g:colors_name = "color_box"

var black     = "#000000"
var white     = "#FFFFFF"

var fg = "#404040"
var bg = "#F3F3F3"

var blue_dk = "#2168AF"
var blue    = "#4188C8"
var blue_lt = "#5FAFF3"
var blue_bg = "#CFF0FF"

var red_dk = "#AF2352"
var red    = "#DF3372"
var red_lt = "#F36897"
var red_bg = "#FFCFDF"

var orange_dk = "#A54322"
var orange    = "#DC5E43"
var orange_lt = "#EF915B"
var orange_bg = "#FFBF60"

var cyan_dk  = "#208888"
var cyan     = "#30AFA2"
var cyan_lt  = "#40CFC3"
var cyan_bg  = "#B8FFF0"

var green_dk = "#207452"
var green    = "#20BF72"
var green_lt = "#20DF83"
var green_bg = "#B8FFE0"

var violet_dk = "#9030B8"
var violet    = "#A755D5"
var violet_lt = "#B880D7"
var violet_bg = "#E0D0FF"

var yellow_dk = "#938002"
var yellow    = "#EFEC58"
var yellow_lt = "#FFFF67"
var yellow_bg = "#FFF890"

var gray_dk = "#444447"
var gray    = "#959598"
var gray_lt = "#CBCBCF"
var gray_bg = "#ECECEC"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Gui = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

execute "hi Bold" Gui("bold")
execute "hi CurSearch" Bg(white) Gui("underline")
execute "hi Cursor" Bg(black) Cterm("NONE")
execute "hi CursorLine" Bg(gray_bg) Cterm("NONE")
execute "hi CursorLineNr" Fg(gray_dk) Bg(gray_bg) Gui("bold")
execute "hi Folded" Fg(blue) Bg(gray_lt) Gui("NONE")
execute "hi IncSearch" Fg(white) Bg(cyan) Gui("NONE")
execute "hi Italic" Gui("italic")
execute "hi Label" Fg(black) Gui("bold")
execute "hi LineNr" Fg(gray) Gui("bold")
execute "hi MatchParen" Fg(green_dk) Bg(green_bg) Gui("bold")
execute "hi NonText" Fg(gray) Bg("bg")
execute "hi Normal" Fg(fg) Bg(bg) Gui("NONE")
execute "hi Pmenu" Fg(black) Bg(yellow_bg)
execute "hi PmenuSbar" Fg(gray_bg) Bg(gray_lt)
execute "hi PmenuSel" Fg(black) Bg(yellow_lt) Gui("NONE")
execute "hi PmenuThumb" Fg(gray_dk) Bg(gray_dk)
execute "hi Search" Bg(white) Gui("NONE")
execute "hi StatusLine" Fg(white) Bg(blue) Gui("NONE")
execute "hi StatusLineNC" Fg(black) Bg(gray_bg) Gui("NONE")
execute "hi StatusLineTerm" Fg(white) Bg(blue) Gui("bold")
execute "hi Terminal" Fg(fg) Bg(bg)
execute "hi User1" Fg(white) Bg(gray_lt) Gui("NONE")
execute "hi User2" Fg(blue_bg) Bg(blue_dk) Gui("italic")
execute "hi VertSplit" Fg(gray_bg) Bg(gray_bg) Gui("NONE")
execute "hi Visual" Fg(blue_dk) Bg(blue_bg)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine StatusLineNC
highlight! link TabLineFill StatusLineNC
highlight! link TabLineSel Label
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(green_dk) Gui("NONE")
execute "hi Conditional" Fg(red)  Gui("bold")
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue_dk)
execute "hi Error" Fg(red) Bg("bg") Gui("underline")
execute "hi ErrorMsg" Fg(red_dk) Bg(red_bg) Gui("NONE")
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(red) Gui("NONE")
execute "hi ModeMsg" Fg(black) Bg(yellow) Gui("NONE")
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
execute "hi Title" Fg(blue_dk)  Gui("bold")
execute "hi Todo" Fg(blue) Bg("bg") Gui("bold,italic")
execute "hi Type" Fg(violet) Gui("NONE")
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
execute "hi markdownCode" Fg(green_dk) Gui("italic")
execute "hi markdownCodeBlock" Fg(green_dk) Gui("italic")
execute "hi rstEmphasis" Fg(gray_dk)
execute "hi rstStrongEmphasis" Fg(gray_dk)  Gui("bold")

# Diffs

execute "hi DiffChange" Fg(blue) Bg(gray_lt)
execute "hi DiffText" Fg(blue) Bg(blue_bg) Gui("bold")
execute "hi DiffDelete" Fg(red) Bg(red_bg)
execute "hi DiffAdd" Fg(gray_dk) Bg(gray_lt) Gui("bold")

# Signify

execute "hi SignifySignAdd"             Fg(green)
execute "hi SignifySignDelete"          Fg(red)
execute "hi SignifySignDeleteFirstLine" Fg(red)
execute "hi SignifySignChange"          Fg(blue)
execute "hi SignifySignChangeDelete"    Fg(blue)
