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

const Foreground = "#303030"
const Background = "#FFFFFF"
const Black = "#000000"
const White = "#FFFFFF"
const ShadowBg = "#F6F6F6"
const ShadowFg = "#C0C0C0"
const Highlight = "#FFE070"

const BlueBg = "#D8EFFF"
const BlueLt = "#C4CFFB"
const Blue =   "#6581BF"
const BlueDk = "#4341AF"

const RedBg = "#FBE9EB"
const RedLt = "#FFCACC"
const Red = "#FB8A9C"
const RedDk = "#BC6D76"

const GreenBg = "#D8F0CF"
const GreenLt = "#C3EBCE"
const Green = "#7FCA7C"
const GreenDk = "#45984F"

const BrownBg = "#EFEFDF"
const BrownLt = "#B3755C"
const Brown =   "#A3844C"
const BrownDk = "#7E7F68"

const Gray0 = "#2e3436"
const Gray1 = "#555753"
const Gray2 = "#888885"
const Gray3 = "#bababa"
const Gray4 = "#d3d7d3"
const Gray5 = "#eeeeec"

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
H("CurSearch", {fg: Black, bg: Gray3, gui: BoldUnderline})
H("Conceal", {fg: ShadowFg, bg: ShadowBg})
H("Cursor", {fg: White, bg: Black })
H("CursorLine", {bg: ShadowBg})
H("CursorLineNr", {fg: Gray2, bg: Gray5, gui: Bold})
H("Folded", {fg: Blue, bg: Background })
H("IncSearch", {fg: White, bg: Gray0, gui: None })
H("italic", {gui: "italic"})
H("Label", {fg: Black, gui: "bold"})
H("LineNrAbove", {fg: Red, gui: "bold"})
H("LineNr", {fg: Gray2, gui: "bold"})
H("LineNrBelow", {fg: Blue, gui: "bold"})
H("MatchParen", {fg: GreenDk, bg: Background, gui: "underline"})
H("NonText", {fg: Gray3, bg: Background})
H("Normal", {fg: Foreground, bg: Background })
H("Operator", {fg: GreenDk })
H("Pmenu", {fg: Black, bg: Gray4})
H("PmenuSbar", {fg: Gray4, bg: Gray2})
H("PmenuSel", {fg: White, bg: Black })
H("PmenuMatchSel", {fg: Green, bg: Black, gui: "bold"})
H("PmenuThumb", {fg: GreenDk, bg: Gray1})
H("Search", {fg: Black, bg: Gray4 })
H("StatusLine", {fg: BlueLt, bg: Blue, gui: "NONE" })
H("StatusLineNC", {fg: White, bg: Gray3, gui: "NONE"})
H("StatusLineTerm", {fg: White, bg: Blue })
H("TabLine", {fg: Gray2, bg: ShadowBg, gui: "NONE" })
H("TabLineFill", {fg: Black, bg: ShadowBg, gui: "NONE"})
H("TabLineSel", {fg: BlueBg, bg: BlueDk, gui: "bold"})
H("Terminal", {fg: Gray5, bg: Gray0})
H("User1", {fg: White, bg: Blue })
H("User2", {fg: BlueLt, bg: BlueDk, gui: "italic"})
H("VertSplit", {fg: Gray4, bg: Gray5 })
H("Visual", {fg: White, bg: GreenDk})
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
H("WarningMsg", {fg: GreenDk, bg: GreenBg})
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

H("markdownCode", {fg: BlueDk, bg: ShadowBg})
H("markdownCodeBlock", {fg: BlueDk, gui: None})

# Filetype ReStructuredTExt

H("rstEmphasis", {fg: Gray2})
H("rstStrongEmphasis", {fg: Gray2, gui: "bold"})

# Diffs

H("DiffChange", {fg: Black, bg: BlueBg})
H("DiffText", {fg: White, bg: Blue})
H("DiffDelete", {fg: RedBg, bg: RedBg})
H("DiffAdd", {fg: Black, bg: GreenBg})

# Signify

H("SignifySignAdd", {fg: Green})
H("SignifySignDelete", {fg: Red})
H("SignifySignDeleteFirstLine", {fg: Red})
H("SignifySignChange", {fg: Blue})
H("SignifySignChangeDelete", {fg: Blue})
