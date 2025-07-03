vim9script
# Vim color theme
#
# Description = Four base colors in four flavours.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=light
g:colors_name = "blaubeere"

const foreground = "#303030"
const background = "#FAFAFA"
const black      = "#000000"
const white      = "#FFFFFF"
const shadow_bg  = "#F0F0F0"
const shadow_fg  = "#C0C0C0"
const highlight  = "#FFE070"

const blue_bg = "#D8EFFF"
const blue_lt = "#C4CFFB"
const blue    = "#6581BF"
const blue_dk = "#4341AF"

const red_bg = "#FBE9EB"
const red_lt = "#FFCACC"
const red    = "#FB8A9C"
const red_dk = "#BC6D76"

const green_bg = "#D8F0CF"
const green_lt = "#C3EBCE"
const green    = "#7FCA7C"
const green_dk = "#45984F"

const brown_bg = "#EFEFDF"
const brown_lt = "#B3755C"
const brown    = "#A3844C"
const brown_dk = "#7E7F68"

const gray0 = "#2e3436"
const gray1 = "#555753"
const gray2 = "#888885"
const gray3 = "#bababa"
const gray4 = "#d3d7d3"
const gray5 = "#eeeeec"

const None = "NONE"
const Bold = "bold"
const Underline = "underline"
const BoldUnderline = "bold,underline"

def H(name: string, d: dict<string>)
  var fg =    has_key(d, "fg")    ? "guifg=" .. d.fg : ""
  var bg =    has_key(d, "bg")    ? "guibg=" .. d.bg : ""
  var gui =   has_key(d, "gui")   ? "gui=" .. d.gui : ""
  var guisp = has_key(d, "guisp") ? "guisp=" .. d.gui : ""
  var cterm = has_key(d, "cterm") ? "cterm=" .. d.cterm : ""
  execute $"highlight {name} {fg} {bg} {gui} {cterm} {guisp}"
enddef

# Basics
H("Bold", {gui: "bold"})
H("CurSearch", {fg: black, bg: gray3, gui: BoldUnderline})
H("Conceal", {fg: shadow_fg, bg: shadow_bg})
H("Cursor", {fg: white, bg: black })
H("CursorLine", {bg: white})
H("CursorLineNr", {fg: gray2, bg: gray5, gui: Bold})
H("Folded", {fg: blue, bg: background })
H("IncSearch", {fg: white, bg: gray0, gui: None })
H("italic", {gui: "italic"})
H("Label", {fg: black, gui: "bold"})
H("LineNrAbove", {fg: red, gui: "bold"})
H("LineNr", {fg: gray2, gui: "bold"})
H("LineNrBelow", {fg: blue, gui: "bold"})
H("MatchParen", {fg: green_dk, bg: background, gui: "underline"})
H("NonText", {fg: gray3, bg: background})
H("Normal", {fg: foreground, bg: background })
H("Operator", {fg: green_dk })
H("Pmenu", {fg: black, bg: gray4})
H("PmenuSbar", {fg: gray4, bg: gray2})
H("PmenuSel", {fg: white, bg: black })
H("PmenuMatchSel", {fg: green, bg: black, gui: "bold"})
H("PmenuThumb", {fg: green_dk, bg: gray1})
H("Search", {fg: black, bg: gray4 })
H("StatusLine", {fg: white, bg: blue, gui: "NONE" })
H("StatusLineNC", {fg: white, bg: gray3, gui: "NONE"})
H("StatusLineTerm", {fg: white, bg: blue })
H("TabLine", {fg: gray2, bg: shadow_bg, gui: "NONE" })
H("TabLineFill", {fg: black, bg: shadow_bg, gui: "NONE"})
H("TabLineSel", {fg: blue_bg, bg: blue_dk, gui: "bold"})
H("Terminal", {fg: gray1, bg: gray5})
H("User1", {fg: blue_lt, bg: blue })
H("User2", {fg: blue_lt, bg: blue_dk, gui: "italic"})
H("VertSplit", {fg: gray4, bg: gray5 })
H("Visual", {fg: white, bg: green_dk})
H("PopupNotification", {fg: black, bg: highlight})

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

H("Comment", {fg: brown_dk })
H("Conditional", {fg: red })
H("Constant", {fg: blue})
H("Directory", {fg: blue_dk, gui: "underline"})
H("Error", {fg: red_dk, bg: red_bg })
H("ErrorMsg", {fg: red_dk, bg: red_bg })
H("Function", {fg: blue})
H("Identifier", {fg: green_dk })
H("Ignore", {fg: gray3, gui: "italic"})
H("ModeMsg", {fg: black, bg: brown_bg })
H("Number", {fg: blue})
H("PreCondit", {fg: red_dk, gui: "bold"})
H("PreProc", {fg: black, gui: "bold"})
H("Question", {fg: gray2, bg: background})
H("QuickFixLine", {fg: blue, bg: background, gui: "bold"})
H("Special", {fg: black})
H("SpecialKey", {fg: blue})
H("Statement", {fg: blue_dk })
H("StorageClass", {fg: red})
H("String", {fg: brown_lt})
H("Structure", {fg: red })
H("Title", {fg: blue_dk, gui: "bold"})
H("Todo", {fg: red, bg: background, gui: "bold,underline"})
H("Type", {fg: red_dk })
H("WarningMsg", {fg: green_dk, bg: green_bg})
H("qfFileName", {fg: blue_dk})
H("qfLineNr", {fg: red})

# Filetype VIM

H("vimCommentTitle", {fg: brown_dk, gui: "bold"})
H("vimHiKeyList", {fg: blue})

# Filetype C

H("CppOut", {bg: gray4 })
H("CppOutIf", {fg: gray3, gui: "italic"})
H("CppOutIf2", {fg: gray4, gui: "italic"})
H("Paren", {fg: gray2})
H("Block", {fg: gray2})

# Filetype HTML

H("htmlH1", {fg: blue_dk, gui: "bold"})
H("htmlH2", {fg: blue, gui: "bold"})
H("htmlH3", {fg: blue })
H("htmlitalic", {fg: shadow_fg, gui: "italic"})

# Filetype Markdown

H("markdownCode", {fg: blue_dk, bg: shadow_bg})
H("markdownCodeBlock", {fg: blue_dk, gui: None})

# Filetype ReStructuredTExt

H("rstEmphasis", {fg: gray2})
H("rstStrongEmphasis", {fg: gray2, gui: "bold"})

# Vim Diff

H("DiffChange", {fg: blue_dk, bg: blue_bg})
H("DiffText", {fg: blue_dk, bg: blue_lt, gui: "bold"})
H("DiffDelete", {fg: red_dk, bg: red_bg, gui: "NONE"})
H("DiffAdd", {fg: green_dk, bg: green_bg})

# Filetype diff

H("diffFile", {fg: blue_dk, bg: blue_lt, gui: "bold"})

highlight! link diffRemoved DiffDelete
highlight! link diffAdded DiffAdd
highlight! link diffChanged DiffChange

# package Signify

H("SignifySignAdd", {fg: green})
H("SignifySignDelete", {fg: red})
H("SignifySignDeleteFirstLine", {fg: red})
H("SignifySignChange", {fg: blue})
H("SignifySignChangeDelete", {fg: blue})
