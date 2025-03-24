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

var foreground = "#787072"
var Background = "#FFFFFF"
var Black = "#000000"
var White = "#FFFFFF"
var ShadowBg = "#F6F6F6"
var ShadowFg = "#C0C0C0"
var Highlight = "#FFE070"

var BlueBg = "#D8EFFF"
var BlueLt = "#C4CFFB"
var Blue =   "#6581BF"
var BlueDk = "#4341AF"

var RedBg = "#FBE9EB"
var RedLt = "#FFCACC"
var Red = "#FB8A9C"
var RedDk = "#BC6D76"

var GreenBg = "#D8F0CF"
var GreenLt = "#C3EBCE"
var Green = "#7FCA7C"
var GreenDk = "#45984F"

var BrownBg = "#EFEFDF"
var BrownLt = "#B3755C"
var Brown =   "#A3844C"
var BrownDk = "#7E7F68"

var Gray0 = "#2e3436"
var Gray1 = "#555753"
var Gray2 = "#888885"
var Gray3 = "#bababa"
var Gray4 = "#d3d7d3"
var Gray5 = "#eeeeec"

def H(n: string, d: dict<string>)
  var fg = has_key(d, "fg") ? d.fg : "fg"
  var bg = has_key(d, "bg") ? d.bg : "bg"
  var gui = has_key(d, "gui") ? d.gui : "NONE"
  var guisp = has_key(d, "guisp") ? d.gui : "NONE"
  var cterm = has_key(d, "cterm") ? d.cterm : "NONE"
  execute "highlight" n $"guifg={fg}" $"guibg={bg}" $"gui={gui}" $"cterm={cterm}" $"guisp={guisp}"
enddef

# Basics
H("Bold", {gui: "bold"})
H("CurSearch", {fg: BlueDk, bg: Gray5})
H("Conceal", {fg: ShadowFg, bg: ShadowBg})
H("CurSearch", {fg: BlueDk, bg: BlueBg })
H("Cursor", {fg: White, bg: Black })
H("CursorLine", {bg: ShadowBg})
H("CursorLineNr", {fg: Gray2, bg: Gray5, gui: "bold"})
H("Folded", {fg: Blue, bg: Background })
H("InSearch", {fg: White, bg: Gray0 })
H("italic", {gui: "italic"})
H("Label", {fg: Black, gui: "bold"})
H("LineNrAbove", {fg: Red, gui: "bold"})
H("LineNr", {fg: Gray2, gui: "bold"})
H("LineNrBelow", {fg: Blue, gui: "bold"})
H("MatchParen", {fg: GreenDk, bg: Background, gui: "underline"})
H("NonText", {fg: Gray3, bg: Background})
H("Normal", {fg: foreground, bg: Background })
H("Operator", {fg: GreenDk })
H("Pmenu", {fg: Black, bg: Gray4})
H("PmenuSbar", {fg: Gray4, bg: Gray2})
H("PmenuSel", {fg: White, bg: Black })
H("PmenuMatchSel", {fg: BrownLt, bg: Black, gui: "bold"})
H("PmenuThumb", {fg: GreenDk, bg: Gray1})
H("Search", {fg: Black, bg: BrownBg })
H("StatusLine", {fg: BlueLt, bg: Blue })
H("StatusLineNC", {fg: White, bg: Gray3 })
H("StatusLineTerm", {fg: White, bg: Blue })
H("TabLine", {fg: Gray2, bg: ShadowBg })
H("TabLineFill", {fg: Black, bg: ShadowBg })
H("TabLineSel", {fg: BlueBg, bg: BlueDk, gui: "bold"})
H("Terminal", {fg: foreground, bg: Background})
H("User1", {fg: White, bg: Gray4 })
H("User2", {fg: BlueLt, bg: BlueDk, gui: "italic"})
H("VertSplit", {fg: Gray4, bg: Gray5 })
H("Visual", {fg: Black, bg: BlueBg})
H("PopupNotification", {fg: Black, bg: Highlight})

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

# Code

H("Comment", {fg: BrownDk })
H("Conditional", {fg: Red })
H("Constant", {fg: Blue})
H("Directory", {fg: BlueDk, gui: "underline"})
H("Error", {fg: RedDk, bg: RedBg })
H("ErrorMsg", {fg: RedDk, bg: RedBg })
H("Function", {fg: Blue})
H("Identifier", {fg: GreenDk })
H("Ignore", {fg: Gray3, gui: "italic"})
H("ModeMsg", {fg: Black, bg: BrownBg })
H("Number", {fg: Blue})
H("PreCondit", {fg: RedDk, gui: "bold"})
H("PreProc", {fg: Black, gui: "bold"})
H("Question", {fg: Gray2, bg: Background})
H("QuickFixLine", {fg: Blue, bg: Background, gui: "bold"})
H("Special", {fg: Black})
H("SpecialKey", {fg: Blue})
H("Statement", {fg: BlueDk })
H("StorageClass", {fg: Red})
H("String", {fg: BrownLt})
H("Structure", {fg: Red })
H("Title", {fg: BlueDk, gui: "bold"})
H("Todo", {fg: Red, bg: Background, gui: "bold,underline"})
H("Type", {fg: RedDk })
H("WarningMsg", {fg: White, bg: GreenDk})
H("qfFileName", {fg: BlueDk})
H("qfLineNr", {fg: Red})

# Filetype VIM

H("vimCommentTitle", {fg: BrownDk, gui: "bold"})
H("vimHiKeyList", {fg: Blue})

# Filetype C

H("CppOut", {bg: Gray4 })
H("CppOutIf", {fg: Gray3, gui: "italic"})
H("CppOutIf2", {fg: Gray4, gui: "italic"})
H("Paren", {fg: Gray2})
H("Block", {fg: Gray2})

# Filetype HTML

H("htmlH1", {fg: BlueDk, gui: "bold"})
H("htmlH2", {fg: Blue, gui: "bold"})
H("htmlH3", {fg: Blue })
H("htmlitalic", {fg: ShadowFg, gui: "italic"})

# Filetype Markdown

H("markdownCode", {fg: Gray2, bg: Gray5})
H("markdownCodeBlock", {fg: Gray2, gui: "italic"})

# Filetype ReStructuredTExt

H("rstEmphasis", {fg: Gray2})
H("rstStrongEmphasis", {fg: Gray2, gui: "bold"})

# Diffs

H("DiffChange", {fg: Black, bg: BlueBg})
H("DiffText", {fg: White, bg: Black, gui: "bold"})
H("DiffDelete", {fg: RedDk, bg: RedBg})
H("DiffAdd", {fg: Black, bg: GreenBg, gui: "bold"})

# Signify

H("SignifySignAdd", {fg: Green})
H("SignifySignDelete", {fg: Red})
H("SignifySignDeleteFirstLine", {fg: Red})
H("SignifySignChange", {fg: Blue})
H("SignifySignChangeDelete", {fg: Blue})
