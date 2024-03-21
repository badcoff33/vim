vim9script
# Vim color theme
#
# Description: Keep things orangeuced. Only two basic colors used: orange and blue.
# To make things a little bit more subtle, each base colors is present in three
# flavors in addition to some gray-ish colors.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=dark

g:colors_name = "sparks"

var black    = "#000000"
var white    = "#FFFFFF"

var fg       = "#D0D0F0"
var bg       = "#1A253F"
var bg_dk    = "#0C0F2E"

var blue_lt  = "#91AAD3"
var blue     = "#819FC3"
var blue_dk  = "#6380B0"
var blue_bg  = "#25384F"

var yellow  = "#F8E840"
var orange  = "#E17C36"
var red     = "#EF3005"
var green   = "#10CC51"

var Fg      = (str) => empty(str) ? "" : "guifg=" .. str
var Bg      = (str) => empty(str) ? "" : "guibg=" .. str
var Attr    = (str) => empty(str) ? "" : "gui="   .. str
var Cterm   = (str) => empty(str) ? "" : "cterm=" .. str
var Special = (str) => empty(str) ? "" : "guisp=" .. str

# Basics

execute "hi Bold" Attr("bold")
execute "hi CurSearch" Fg(fg) Bg(bg) Attr("bold,underline")
execute "hi Cursor" Bg(blue) Cterm("NONE")
execute "hi CursorLine" Bg(bg_dk) Cterm("NONE")
execute "hi CursorLineNr" Fg(blue) Attr("bold")
execute "hi Folded" Fg(blue) Bg(blue_lt) Attr("NONE")
execute "hi IncSearch" Fg(black) Bg(yellow) Attr("NONE")
execute "hi Italic" Attr("italic")
execute "hi Label" Fg(black) Attr("bold")
execute "hi LineNr" Fg(blue) Attr("bold")
execute "hi MatchParen" Fg(green) Bg("bg") Attr("bold")
execute "hi NonText" Fg(blue) Bg("bg") Attr("NONE")
execute "hi Normal" Fg(fg) Bg(bg) Attr("NONE")
execute "hi Pmenu" Fg(black) Bg(green)
execute "hi PmenuSbar" Fg(blue_dk) Bg(blue_dk)
execute "hi PmenuSel" Fg(black) Bg(yellow) Attr("bold")
execute "hi PmenuThumb" Fg(blue_dk) Bg(blue_lt)
execute "hi Search" Fg(fg) Bg(bg) Attr("underline")
execute "hi StatusLine" Fg(white) Bg(blue_dk) Attr("NONE")
execute "hi StatusLineNC" Fg(white) Bg(blue_dk) Attr("NONE")
execute "hi StatusLineTerm" Fg(white) Bg(orange) Attr("bold")
execute "hi Terminal" Fg(blue_lt) Bg(bg_dk)
execute "hi User1" Fg(black) Bg(blue)
execute "hi User2" Fg(white) Bg(blue)
execute "hi VertSplit" Fg(blue_dk) Bg(blue_dk) Attr("NONE")
execute "hi Visual" Fg(white) Bg(blue)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Normal
highlight! link TabLineFill Normal
highlight! link TabLineSel User1
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

execute "hi Comment" Fg(blue) Attr("NONE")
execute "hi Conditional" Fg(blue_lt) Attr("bold")
execute "hi Constant" Fg(blue)
execute "hi Directory" Fg(blue) Attr("bold,underline")
execute "hi Error" Fg(orange) Bg("bg") Attr("underline")
execute "hi ErrorMsg" Fg(orange) Bg(bg) Attr("bold")
execute "hi Function" Fg(blue)
execute "hi Identifier" Fg(blue_lt) Attr("NONE")
execute "hi ModeMsg" Fg(blue) Bg(bg) Attr("NONE")
execute "hi MoreMsg" Fg(white) Bg(bg) Attr("NONE")
execute "hi Number" Fg(blue)
execute "hi PreCondit" Fg(white) Attr("bold")
execute "hi PreProc" Fg(white) Attr("NONE")
execute "hi Question" Fg(white) Bg(bg)
execute "hi QuickFixLine" Fg(blue) Bg("bg") Attr("bold")
execute "hi Special" Fg(blue_dk)
execute "hi SpecialKey" Fg(blue) Attr("italic")
execute "hi Statement" Fg(white) Attr("bold")
execute "hi StorageClass" Fg(white)
execute "hi String" Fg(fg)
execute "hi Structure" Fg(blue_dk) Attr("NONE")
execute "hi Title" Fg(white) Attr("bold")
execute "hi Todo" Fg(blue) Bg("bg") Attr("bold,italic")
execute "hi Type" Fg(white) Attr("NONE")
execute "hi WarningMsg" Fg(blue) Bg(bg)
execute "hi qfFileName" Fg(blue_lt)
execute "hi qfLineNr" Fg(orange)

# Filetype VIM

execute "hi vimCommentTitle" Fg(blue) Attr("bold")

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

execute "hi markdownCode" Fg(blue) Bg(blue_lt)
execute "hi markdownCode" Fg(blue) Attr("italic")
execute "hi markdownCodeBlock" Fg(blue_dk)

# Filetype ReStructuorangeText

execute "hi rstEmphasis" Fg(blue_lt)
execute "hi rstStrongEmphasis" Fg(blue_lt) Attr("bold")

# Diffs

execute "hi DiffChange" Fg(blue_lt) Bg(blue_dk)
execute "hi DiffText" Fg(blue) Bg(blue_dk)
execute "hi DiffDelete" Fg(orange) Bg(orange)
execute "hi DiffAdd" Fg(blue_lt) Bg(blue_dk)
