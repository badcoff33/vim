" Colorscheme: Frost

let g:colors_name = "frost"
set background=dark

let s:frostBlack   = "#121518"
let s:frostWhite   = "#DFDFF3"
let s:frost0       = "#2E3440"
let s:frost1       = "#3B4252"
let s:frost2       = "#434C5E"
let s:frost3       = "#4C566A"
let s:frost4       = "#516779"
let s:frost5       = "#7589A0"
let s:frost6       = "#A3B7D3"
let s:frostBlue1   = "#8194AB"
let s:frostBlue2   = "#81A1C1"
let s:frostBlue3   = "#88C0D0"
let s:frostRed     = "#BF616A"
let s:frostPumpkin = "#D08770"
let s:frostYellow  = "#EBCB8B"
let s:frostGreen   = "#A3BE8C"
let s:frostViolet  = "#B48EAD"

let s:GuiFg = {str -> empty(str) ? "":"guifg=".str}
let s:GuiBg = {str -> empty(str) ? "":"guibg=".str}
let s:GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Editor
execute "hi ColorColumn"  s:GuiBg(s:frost1)
execute "hi Cursor" s:GuiFg(s:frost0) s:GuiBg(s:frostViolet) s:GuiAttr("NONE")
execute "hi CursorLine"  s:GuiBg(s:frost1) s:GuiAttr("NONE")
execute "hi Error" s:GuiFg(s:frostRed) s:GuiBg("bg")
execute "hi iCursor" s:GuiFg(s:frost0) s:GuiBg(s:frost4)
execute "hi LineNr" s:GuiFg(s:frost3) s:GuiBg(s:frost0)
execute "hi MatchParen" s:GuiFg(s:frostBlue2) s:GuiBg(s:frost3)
execute "hi NonText" s:GuiFg(s:frost2)
execute "hi Normal" s:GuiFg(s:frostWhite) s:GuiBg(s:frost0)
execute "hi PMenu" s:GuiFg(s:frostBlue1) s:GuiBg(s:frost2) s:GuiAttr("NONE")
execute "hi PmenuSbar" s:GuiFg(s:frost4) s:GuiBg(s:frost2)
execute "hi PmenuThumb" s:GuiFg(s:frostBlue2) s:GuiBg(s:frost3)
execute "hi SpecialKey" s:GuiFg(s:frost3)
execute "hi SpellBad" s:GuiFg(s:frostRed) s:GuiBg(s:frost0) s:GuiAttr("undercurl")
execute "hi SpellCap" s:GuiFg(s:frostYellow) s:GuiBg(s:frost0) s:GuiAttr("undercurl")
execute "hi SpellLocal" s:GuiFg(s:frost5) s:GuiBg(s:frost0) s:GuiAttr("undercurl")
execute "hi SpellRare" s:GuiFg(s:frost6) s:GuiBg(s:frost0) s:GuiAttr("undercurl")
execute "hi Visual" s:GuiFg(s:frost6) s:GuiBg(s:frost3)
execute "hi VisualNOS"  s:GuiBg(s:frost2)
execute "hi Whitespace" s:GuiFg(s:frost3)
hi! link PMenuSel IncSearch

" Frost specific
execute "hi BlendDown" s:GuiBg(s:frost1)

" Neovim Support
execute "hi healthError" s:GuiFg(s:frostRed) s:GuiBg(s:frost1)
execute "hi healthSuccess" s:GuiFg(s:frostGreen) s:GuiBg(s:frost1)
execute "hi healthWarning" s:GuiFg(s:frostYellow) s:GuiBg(s:frost1)
execute "hi TermCursorNC"  s:GuiBg(s:frost1)

" Gutter
execute "hi CursorColumn"  s:GuiBg(s:frost1)
execute "hi CursorLineNr" s:GuiFg(s:frost4) s:GuiBg(s:frost0) s:GuiAttr("NONE")
execute "hi Folded" s:GuiFg(s:frost3) s:GuiBg(s:frost1) s:GuiAttr("bold")
execute "hi FoldColumn" s:GuiFg(s:frost3) s:GuiBg(s:frost0)
execute "hi SignColumn" s:GuiFg(s:frost1) s:GuiBg(s:frost0)

" Navigation
execute "hi Directory" s:GuiFg(s:frostBlue2)

" Prompt/Status
execute "hi EndOfBuffer" s:GuiFg(s:frost1)
execute "hi WarningMsg" s:GuiFg(s:frostBlack) s:GuiBg(s:frostYellow)
execute "hi ErrorMsg" s:GuiFg(s:frostBlack) s:GuiBg(s:frostRed)
execute "hi ModeMsg" s:GuiFg(s:frostBlack) s:GuiBg(s:frostGreen)
execute "hi MoreMsg" s:GuiFg(s:frostBlack) s:GuiBg(s:frostYellow)
execute "hi Question" s:GuiFg(s:frost4)
execute "hi StatusLine" s:GuiFg(s:frost6) s:GuiBg(s:frost3) s:GuiAttr("NONE")
execute "hi StatusLineNC" s:GuiFg(s:frost5) s:GuiBg(s:frost1) s:GuiAttr("NONE")
execute "hi StatusLineTerm" s:GuiFg(s:frostBlue2) s:GuiBg(s:frost3) s:GuiAttr("NONE")
execute "hi StatusLineTermNC" s:GuiFg(s:frost4) s:GuiBg(s:frost1) s:GuiAttr("NONE")
execute "hi VertSplit" s:GuiFg(s:frost2) s:GuiBg(s:frost0) s:GuiAttr("NONE")
hi! link WildMenu IncSearch

" Search
execute "hi IncSearch" s:GuiFg(s:frostBlack) s:GuiBg(s:frostGreen) s:GuiAttr("bold")
execute "hi Search" s:GuiFg(s:frostYellow) s:GuiBg(s:frost2) s:GuiAttr("bold")

 " QuickFix
hi! link qfFileName Directory
hi! link qfLineNr Directory
execute "hi qfSeparator" s:GuiFg("fg") s:GuiBg("bg")
execute "hi QuickFixLine" s:GuiFg("fg") s:GuiBg("bg") s:GuiAttr("bold")

" Tabs
execute "hi TabLine" s:GuiFg(s:frost5) s:GuiBg(s:frost1) s:GuiAttr("NONE")
execute "hi TabLineFill" s:GuiFg(s:frost4) s:GuiBg(s:frost1) s:GuiAttr("NONE")
execute "hi TabLineSel" s:GuiFg(s:frostYellow) s:GuiBg(s:frost4) s:GuiAttr("underline")

" Window
execute "hi Title" s:GuiFg(s:frost4)  s:GuiAttr("NONE")
execute "hi Bold"   s:GuiAttr("bold")
execute "hi Italic"   s:GuiAttr("italic")
execute "hi Boolean" s:GuiFg(s:frostBlue3)
execute "hi Character" s:GuiFg(s:frostYellow)
execute "hi Comment" s:GuiFg(s:frostGreen)  s:GuiAttr("italic")
execute "hi Conditional" s:GuiFg(s:frostBlue3)
execute "hi Constant" s:GuiFg(s:frostPumpkin)
execute "hi Define" s:GuiFg(s:frostBlue3)
execute "hi Delimiter" s:GuiFg(s:frost6)
execute "hi Exception" s:GuiFg(s:frostBlue3)
execute "hi Float" s:GuiFg(s:frostViolet)
execute "hi Function" s:GuiFg(s:frostBlue2)
execute "hi Identifier" s:GuiFg(s:frostGreen)  s:GuiAttr("NONE")
execute "hi Include" s:GuiFg(s:frostBlue3)
execute "hi Keyword" s:GuiFg(s:frostBlue3)
execute "hi Label" s:GuiFg(s:frostBlue3)
execute "hi Number" s:GuiFg(s:frostViolet)
execute "hi Operator" s:GuiFg(s:frostYellow)  s:GuiAttr("NONE")
execute "hi PreProc" s:GuiFg(s:frostBlue3)  s:GuiAttr("NONE")
execute "hi Repeat" s:GuiFg(s:frostBlue3)
execute "hi Special" s:GuiFg(s:frost5)
execute "hi SpecialChar" s:GuiFg(s:frostYellow)
execute "hi SpecialComment" s:GuiFg(s:frostBlue2)  s:GuiAttr("italic")
execute "hi Statement" s:GuiFg(s:frostBlue3)
execute "hi StorageClass" s:GuiFg(s:frostBlue3)
execute "hi String" s:GuiFg(s:frostViolet)
execute "hi Structure" s:GuiFg(s:frostBlue3)
execute "hi Tag" s:GuiFg(s:frost4)
execute "hi Todo" s:GuiFg(s:frostYellow) s:GuiBg("NONE")
execute "hi Type" s:GuiFg(s:frostBlue3)  s:GuiAttr("NONE")
execute "hi Typedef" s:GuiFg(s:frostBlue3)
hi! link Macro Define
hi! link PreCondit PreProc

execute "hi DiffAdd" s:GuiFg(s:frostGreen) s:GuiBg(s:frost1)
execute "hi DiffChange" s:GuiFg(s:frostYellow) s:GuiBg(s:frost2) s:GuiAttr("bold")
execute "hi DiffDelete" s:GuiFg(s:frostRed) s:GuiBg(s:frost1)
execute "hi DiffText" s:GuiFg(s:frostBlue3) s:GuiBg(s:frost1)

execute "hi cIncluded" s:GuiFg(s:frostBlue1)
hi! link cOperator Operator
hi! link cPreCondit PreCondit

execute "hi htmlArg" s:GuiFg(s:frostBlue1)
execute "hi htmlLink" s:GuiFg(s:frost4)  s:GuiAttr("NONE")
hi! link htmlBold Bold
hi! link htmlEndTag htmlTag
hi! link htmlItalic Italic
hi! link htmlH1 markdownH1
hi! link htmlH2 markdownH1
hi! link htmlH3 markdownH1
hi! link htmlH4 markdownH1
hi! link htmlH5 markdownH1
hi! link htmlH6 markdownH1
hi! link htmlSpecialChar SpecialChar
hi! link htmlTag Keyword
hi! link htmlTagN htmlTag

execute "hi markdownBlockquote" s:GuiFg(s:frostBlue1)
execute "hi markdownCode" s:GuiFg(s:frost6) s:GuiBg("bg")
execute "hi markdownCodeBlock" s:GuiFg(s:frost5) s:GuiBg("bg")
execute "hi markdownCodeDelimiter" s:GuiFg(s:frostGreen) s:GuiBg("bg")
execute "hi markdownFootnote" s:GuiFg(s:frostBlue1)
execute "hi markdownId" s:GuiFg(s:frostBlue1)
execute "hi markdownIdDeclaration" s:GuiFg(s:frostBlue1)
execute "hi markdownH1" s:GuiFg(s:frostYellow)
execute "hi markdownLinkText" s:GuiFg(s:frostBlue2)
execute "hi markdownUrl" s:GuiFg(s:frost4)  s:GuiAttr("underline")
hi! link markdownBold Bold
hi! link markdownItalic Italic
hi! link markdownItalicDelimiter Keyword
hi! link markdownBoldDelimiter Keyword
hi! link markdownFootnoteDefinition markdownFootnote
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownIdDelimiter Keyword
hi! link markdownLinkDelimiter Keyword
hi! link markdownLinkTextDelimiter Keyword
hi! link markdownListMarker Keyword
hi! link markdownRule Keyword
hi! link markdownHeadingDelimiter Keyword
