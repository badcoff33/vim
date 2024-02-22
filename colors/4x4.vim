vim9script
# Vim color theme
#
# Description: Four base colors in four flavours.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=light

g:colors_name = "4x4"

var black = "#000000"
var white = "#FFFFFF"

var fg        = "#162030"
var bg        = "#FEFEFF"
var bg_dimmed = "#ECF0F0"

var blue_dk = "#1148AF"
var blue    = "#2160C8"
var blue_lt = "#3F8FE8"
var blue_bg = "#BFCEFF"

var red_dk = "#AF2352"
var red    = "#DF3372"
var red_lt = "#F36897"
var red_bg = "#FF9AC0"

var green_dk = "#23AF52"
var green    = "#33DF72"
var green_lt = "#68F397"
var green_bg = "#9AFFC0"

var yellow_dk = "#838332"
var yellow    = "#A8A852"
var yellow_lt = "#CECE57"
var yellow_bg = "#F3F380"

var gray_dk =  "#444447"
var gray    =  "#959598"
var gray_lt =  "#CBCBCF"
var gray_bg =  "#ECECEF"

var Fg = (str) => empty(str) ? "" : "guifg=" .. str
var Bg = (str) => empty(str) ? "" : "guibg=" .. str
var Gui = (str) => empty(str) ? "" : "gui=" .. str
var Cterm = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

command! -nargs=0 Bright execute "hi Normal" Fg(fg) Bg(bg) Gui("NONE")
command! -nargs=0 Dimmed execute "hi Normal" Fg(fg) Bg(bg_dimmed) Gui("NONE")

execute "hi Bold" Gui("bold")
execute "hi CurSearch" Fg(black) Bg(yellow_lt) Gui("bold")
execute "hi Cursor" Bg(black) Cterm("NONE")
execute "hi CursorLine" Bg(gray_bg) Cterm("NONE")
execute "hi CursorLineNr" Fg(gray) Gui("bold")
execute "hi Folded" Fg(blue) Bg(gray_lt) Gui("NONE")
execute "hi IncSearch" Fg(yellow_bg) Bg(yellow_dk) Gui("bold")
execute "hi Italic" Gui("italic")
execute "hi Label" Fg(black) Gui("bold")
execute "hi LineNr" Fg(gray) Gui("bold")
execute "hi MatchParen" Fg(blue) Bg("bg") Gui("underline,bold")
execute "hi NonText" Fg(gray) Bg("bg")
execute "hi Normal" Fg(fg) Bg(bg) Gui("NONE")
execute "hi Pmenu" Fg(white) Bg(blue)
execute "hi PmenuSbar" Fg(red_lt) Bg(red_lt)
execute "hi PmenuSel" Fg(white) Bg(blue_dk) Gui("bold")
execute "hi PmenuThumb" Fg(red_dk) Bg(red_dk)
execute "hi Search" Fg(black) Bg(yellow_bg) Gui("NONE")
execute "hi StatusLine" Fg(blue_dk) Bg(gray_lt) Gui("NONE")
execute "hi StatusLineNC" Fg(gray_dk) Bg(gray_bg) Gui("NONE")
execute "hi StatusLineTerm" Fg(white) Bg(red) Gui("bold")
execute "hi Terminal" Fg(black) Bg(gray_bg)
execute "hi User1" Fg(green_lt) Bg(green_dk) Gui("NONE")
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

execute "hi Comment" Fg(green) Gui("NONE")
execute "hi Conditional" Fg(red)  Gui("bold")
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue_dk)
execute "hi Error" Fg(red) Bg("bg") Gui("underline")
execute "hi ErrorMsg" Fg(red) Bg(red_bg) Gui("NONE")
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(red) Gui("NONE")
execute "hi ModeMsg" Fg(green_dk) Bg(green_bg) Gui("NONE")
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
