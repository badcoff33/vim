" Colorscheme: Frost

let g:colors_name = "frost"
set background=dark

if exists('&wincolor')
  augroup Wincolor
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if &readonly
          \ | set wincolor=BlendDown | else | set wincolor= | endif
  augroup END
elseif exists('&winhighlight')
  augroup Winhighlight
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if &readonly
          \ | set winhighlight=Normal:BlendDown | set winhighlight= | endif
  augroup END
endif

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

let GuiFg = {str -> empty(str) ? "":"guifg=".str}
let GuiBg = {str -> empty(str) ? "":"guibg=".str}
let GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Editor
execute "hi ColorColumn"  GuiBg(s:frost1)
execute "hi Cursor" GuiFg(s:frost0) GuiBg(s:frostViolet) GuiAttr("NONE")
execute "hi CursorLine"  GuiBg(s:frost1) GuiAttr("NONE")
execute "hi Error" GuiFg(s:frostRed) GuiBg("bg")
execute "hi iCursor" GuiFg(s:frost0) GuiBg(s:frost4)
execute "hi LineNr" GuiFg(s:frost3) GuiBg(s:frost0)
execute "hi MatchParen" GuiFg(s:frostBlue2) GuiBg(s:frost3)
execute "hi NonText" GuiFg(s:frost2)
execute "hi Normal" GuiFg(s:frostWhite) GuiBg(s:frost0)
execute "hi PMenu" GuiFg(s:frostBlue1) GuiBg(s:frost2) GuiAttr("NONE")
execute "hi PmenuSbar" GuiFg(s:frost4) GuiBg(s:frost2)
execute "hi PmenuThumb" GuiFg(s:frostBlue2) GuiBg(s:frost3)
execute "hi SpecialKey" GuiFg(s:frost3)
execute "hi SpellBad" GuiFg(s:frostRed) GuiBg(s:frost0) GuiAttr("undercurl")
execute "hi SpellCap" GuiFg(s:frostYellow) GuiBg(s:frost0) GuiAttr("undercurl")
execute "hi SpellLocal" GuiFg(s:frost5) GuiBg(s:frost0) GuiAttr("undercurl")
execute "hi SpellRare" GuiFg(s:frost6) GuiBg(s:frost0) GuiAttr("undercurl")
execute "hi Visual" GuiFg(s:frost6) GuiBg(s:frost3)
execute "hi VisualNOS"  GuiBg(s:frost2)
execute "hi Whitespace" GuiFg(s:frost3)
hi! link PMenuSel IncSearch

" Frost specific
execute "hi BlendDown" GuiBg(s:frost1)

" Neovim Support
execute "hi healthError" GuiFg(s:frostRed) GuiBg(s:frost1)
execute "hi healthSuccess" GuiFg(s:frostGreen) GuiBg(s:frost1)
execute "hi healthWarning" GuiFg(s:frostYellow) GuiBg(s:frost1)
execute "hi TermCursorNC"  GuiBg(s:frost1)

" Gutter
execute "hi CursorColumn"  GuiBg(s:frost1)
execute "hi CursorLineNr" GuiFg(s:frost4) GuiBg(s:frost0) GuiAttr("NONE")
execute "hi Folded" GuiFg(s:frost3) GuiBg(s:frost1) GuiAttr("bold")
execute "hi FoldColumn" GuiFg(s:frost3) GuiBg(s:frost0)
execute "hi SignColumn" GuiFg(s:frost1) GuiBg(s:frost0)

" Navigation
execute "hi Directory" GuiFg(s:frostBlue2)

" Prompt/Status
execute "hi EndOfBuffer" GuiFg(s:frost1)
execute "hi WarningMsg" GuiFg(s:frostBlack) GuiBg(s:frostYellow)
execute "hi ErrorMsg" GuiFg(s:frostBlack) GuiBg(s:frostRed)
execute "hi ModeMsg" GuiFg(s:frostBlack) GuiBg(s:frostGreen)
execute "hi MoreMsg" GuiFg(s:frostBlack) GuiBg(s:frostYellow)
execute "hi Question" GuiFg(s:frost4)
execute "hi StatusLine" GuiFg(s:frost6) GuiBg(s:frost3) GuiAttr("NONE")
execute "hi StatusLineNC" GuiFg(s:frost5) GuiBg(s:frost1) GuiAttr("NONE")
execute "hi StatusLineTerm" GuiFg(s:frostBlue2) GuiBg(s:frost3) GuiAttr("NONE")
execute "hi StatusLineTermNC" GuiFg(s:frost4) GuiBg(s:frost1) GuiAttr("NONE")
execute "hi VertSplit" GuiFg(s:frost2) GuiBg(s:frost0) GuiAttr("NONE")
hi! link WildMenu IncSearch

" Search
execute "hi IncSearch" GuiFg(s:frostBlack) GuiBg(s:frostGreen) GuiAttr("bold")
execute "hi Search" GuiFg(s:frostYellow) GuiBg(s:frost2) GuiAttr("bold")

 " QuickFix
hi! link qfFileName Directory
hi! link qfLineNr Directory
execute "hi qfSeparator" GuiFg("fg") GuiBg("bg")
execute "hi QuickFixLine" GuiFg("fg") GuiBg("bg") GuiAttr("bold")

" Tabs
execute "hi TabLine" GuiFg(s:frost5) GuiBg(s:frost1) GuiAttr("NONE")
execute "hi TabLineFill" GuiFg(s:frost4) GuiBg(s:frost1) GuiAttr("NONE")
execute "hi TabLineSel" GuiFg(s:frostYellow) GuiBg(s:frost4) GuiAttr("underline")

" Window
execute "hi Title" GuiFg(s:frost4)  GuiAttr("NONE")
execute "hi Bold"   GuiAttr("bold")
execute "hi Italic"   GuiAttr("italic")
execute "hi Boolean" GuiFg(s:frostBlue3)
execute "hi Character" GuiFg(s:frostYellow)
execute "hi Comment" GuiFg(s:frostGreen)  GuiAttr("italic")
execute "hi Conditional" GuiFg(s:frostBlue3)
execute "hi Constant" GuiFg(s:frostPumpkin)
execute "hi Define" GuiFg(s:frostBlue3)
execute "hi Delimiter" GuiFg(s:frost6)
execute "hi Exception" GuiFg(s:frostBlue3)
execute "hi Float" GuiFg(s:frostViolet)
execute "hi Function" GuiFg(s:frostBlue2)
execute "hi Identifier" GuiFg(s:frostGreen)  GuiAttr("NONE")
execute "hi Include" GuiFg(s:frostBlue3)
execute "hi Keyword" GuiFg(s:frostBlue3)
execute "hi Label" GuiFg(s:frostBlue3)
execute "hi Number" GuiFg(s:frostViolet)
execute "hi Operator" GuiFg(s:frostYellow)  GuiAttr("NONE")
execute "hi PreProc" GuiFg(s:frostBlue3)  GuiAttr("NONE")
execute "hi Repeat" GuiFg(s:frostBlue3)
execute "hi Special" GuiFg(s:frost5)
execute "hi SpecialChar" GuiFg(s:frostYellow)
execute "hi SpecialComment" GuiFg(s:frostBlue2)  GuiAttr("italic")
execute "hi Statement" GuiFg(s:frostBlue3)
execute "hi StorageClass" GuiFg(s:frostBlue3)
execute "hi String" GuiFg(s:frostViolet)
execute "hi Structure" GuiFg(s:frostBlue3)
execute "hi Tag" GuiFg(s:frost4)
execute "hi Todo" GuiFg(s:frostYellow) GuiBg("NONE")
execute "hi Type" GuiFg(s:frostBlue3)  GuiAttr("NONE")
execute "hi Typedef" GuiFg(s:frostBlue3)
hi! link Macro Define
hi! link PreCondit PreProc

execute "hi DiffAdd" GuiFg(s:frostGreen) GuiBg(s:frost1)
execute "hi DiffChange" GuiFg(s:frostYellow) GuiBg(s:frost2) GuiAttr("bold")
execute "hi DiffDelete" GuiFg(s:frostRed) GuiBg(s:frost1)
execute "hi DiffText" GuiFg(s:frostBlue3) GuiBg(s:frost1)

execute "hi cIncluded" GuiFg(s:frostBlue1)
hi! link cOperator Operator
hi! link cPreCondit PreCondit

execute "hi htmlArg" GuiFg(s:frostBlue1)
execute "hi htmlLink" GuiFg(s:frost4)  GuiAttr("NONE")
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

execute "hi markdownBlockquote" GuiFg(s:frostBlue1)
execute "hi markdownCode" GuiFg(s:frost6) GuiBg("bg")
execute "hi markdownCodeBlock" GuiFg(s:frost5) GuiBg("bg")
execute "hi markdownCodeDelimiter" GuiFg(s:frostGreen) GuiBg("bg")
execute "hi markdownFootnote" GuiFg(s:frostBlue1)
execute "hi markdownId" GuiFg(s:frostBlue1)
execute "hi markdownIdDeclaration" GuiFg(s:frostBlue1)
execute "hi markdownH1" GuiFg(s:frostYellow)
execute "hi markdownLinkText" GuiFg(s:frostBlue2)
execute "hi markdownUrl" GuiFg(s:frost4)  GuiAttr("underline")
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
