" Colorscheme: Northen Star

let g:colors_name = "frost"
set background=dark

let s:frostBlack   = "#121518"
let s:frost0       = "#2E3440"
let s:frost1       = "#3B4252"
let s:frost2       = "#434C5E"
let s:frost3       = "#4C566A"
let s:frost4       = "#516779"
let s:frost5       = "#7589A0"
let s:frost6       = "#DCDFE4"
let s:frostBlue1   = "#8FBCBB"
let s:frostBlue2   = "#81A1C1"
let s:frostBlue3   = "#88C0D0"
let s:frostRed     = "#BF616A"
let s:frostPumpkin = "#D08770"
let s:frostYellow  = "#EBCB8B"
let s:frostGreen   = "#A3BE8C"
let s:frostViolet  = "#B48EAD"


function! s:hi(group, guifg, guibg, attr, guisp)
  if a:guifg != ""
  exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
  exec "hi " . a:group . " guibg=" . a:guibg
  endif
  if a:attr != ""
  exec "hi " . a:group . " gui=" . a:attr
  endif
  if a:guisp != ""
  exec "hi " . a:group . " guisp=" . a:guisp
  endif
endfunction

"+--- Editor ---+
call s:hi("ColorColumn",   "",            s:frost1, "",          "")
call s:hi("Cursor",        s:frost0,      s:frost5, "NONE",      "")
call s:hi("CursorLine",    "",            s:frost1, "NONE",      "")
call s:hi("Error",         s:frostRed,    "bg",     "",          "")
call s:hi("iCursor",       s:frost0,      s:frost4, "",          "")
call s:hi("LineNr",        s:frost3,      s:frost0, "",          "")
call s:hi("MatchParen",    s:frostBlue2,  s:frost3, "",          "")
call s:hi("NonText",       s:frost2,      "",       "",          "")
call s:hi("Normal",        s:frost6,      s:frost0, "",          "")
call s:hi("PMenu",         s:frost4,      s:frost2, "NONE",      "")
call s:hi("PmenuSbar",     s:frost4,      s:frost2, "",          "")
call s:hi("PMenuSel",      s:frostBlue2,  s:frost3, "",          "")
call s:hi("PmenuThumb",    s:frostBlue2,  s:frost3, "",          "")
call s:hi("SpecialKey",    s:frost3,      "",       "",          "")
call s:hi("SpellBad",      s:frostRed,    s:frost0, "undercurl", "")
call s:hi("SpellCap",      s:frostYellow, s:frost0, "undercurl", "")
call s:hi("SpellLocal",    s:frost5,      s:frost0, "undercurl", "")
call s:hi("SpellRare",     s:frost6,      s:frost0, "undercurl", "")
call s:hi("Visual",        "",            s:frost3, "",          "")
call s:hi("VisualNOS",     "",            s:frost2, "",          "")

"+- Neovim Support -+
call s:hi("healthError",   s:frostRed,    s:frost1, "",          "")
call s:hi("healthSuccess", s:frostGreen,  s:frost1, "",          "")
call s:hi("healthWarning", s:frostYellow, s:frost1, "",          "")
call s:hi("TermCursorNC",  "",            s:frost1, "",          "")

"+--- Gutter ---+
call s:hi("CursorColumn",  "",            s:frost1, "",          "")
call s:hi("CursorLineNr",  s:frost4,      s:frost0, "NONE",      "")
call s:hi("Folded",        s:frost3,      s:frost1, "bold",      "")
call s:hi("FoldColumn",    s:frost3,      s:frost0, "",          "")
call s:hi("SignColumn",    s:frost1,      s:frost0, "",          "")

"+--- Navigation ---+
call s:hi("Directory",             s:frostBlue2,        "",       "",          "")

"+--- Prompt/Status ---+
call s:hi("EndOfBuffer",      s:frost1,     "",            "",     "")
call s:hi("WarningMsg",       s:frostBlack, s:frostYellow, "",     "")
call s:hi("ErrorMsg",         s:frostBlack, s:frostRed,    "",     "")
call s:hi("ModeMsg",          s:frostBlack, s:frostGreen,  "",     "")
call s:hi("MoreMsg",          s:frostBlack, s:frostYellow, "",     "")
call s:hi("Question",         s:frost4,     "",            "",     "")
call s:hi("StatusLine",       s:frost6,     s:frost3,      "NONE", "")
call s:hi("StatusLineNC",     s:frost5,     s:frost1,      "NONE", "")
call s:hi("StatusLineTerm",   s:frostBlue2, s:frost3,      "NONE", "")
call s:hi("StatusLineTermNC", s:frost4,     s:frost1,      "NONE", "")
call s:hi("WildMenu",         s:frostBlue2, s:frost1,      "",     "")
call s:hi("VertSplit",        s:frost2,     s:frost0,     "NONE",  "")

"+--- Search ---+
call s:hi("IncSearch", s:frostBlack, s:frostGreen,  "bold", "")
call s:hi("Search",    s:frostBlack, s:frostYellow, "NONE",      "")

"+--- Tabs ---+
call s:hi("TabLine",     s:frost5,     s:frost1, "NONE",      "")
call s:hi("TabLineFill", s:frost4,     s:frost1, "NONE",      "")
call s:hi("TabLineSel",  s:frostGreen, s:frost4, "underline", "")

"+--- Window ---+
call s:hi("Title",          s:frost4,       "",     "NONE",   "")
call s:hi("Bold",           "",             "",     "bold",   "")
call s:hi("Italic",         "",             "",     "italic", "")
call s:hi("Boolean",        s:frostBlue3,   "",     "",       "")
call s:hi("Character",      s:frostYellow,  "",     "",       "")
call s:hi("Comment",        s:frostGreen,   "",     "italic", "")
call s:hi("Conditional",    s:frostBlue3,   "",     "",       "")
call s:hi("Constant",       s:frostPumpkin, "",     "",       "")
call s:hi("Define",         s:frostBlue3,   "",     "",       "")
call s:hi("Delimiter",      s:frost6,       "",     "",       "")
call s:hi("Exception",      s:frostBlue3,   "",     "",       "")
call s:hi("Float",          s:frostViolet,  "",     "",       "")
call s:hi("Function",       s:frostBlue2,   "",     "",       "")
call s:hi("Identifier",     s:frostGreen,   "",     "NONE",   "")
call s:hi("Include",        s:frostBlue3,   "",     "",       "")
call s:hi("Keyword",        s:frostBlue3,   "",     "",       "")
call s:hi("Label",          s:frostBlue3,   "",     "",       "")
call s:hi("Number",         s:frostViolet,  "",     "",       "")
call s:hi("Operator",       s:frostYellow,   "",     "NONE",   "")
call s:hi("PreProc",        s:frostBlue3,   "",     "NONE",   "")
call s:hi("Repeat",         s:frostBlue3,   "",     "",       "")
call s:hi("Special",        s:frost5,       "",     "",       "")
call s:hi("SpecialChar",    s:frostYellow,  "",     "",       "")
call s:hi("SpecialComment", s:frostBlue2,   "",     "italic", "")
call s:hi("Statement",      s:frostBlue3,   "",     "",       "")
call s:hi("StorageClass",   s:frostBlue3,   "",     "",       "")
call s:hi("String",         s:frostViolet,  "",     "",       "")
call s:hi("Structure",      s:frostBlue3,   "",     "",       "")
call s:hi("Tag",            s:frost4,       "",     "",       "")
call s:hi("Todo",           s:frostYellow,  "NONE", "",       "")
call s:hi("Type",           s:frostBlue3,   "",     "NONE",   "")
call s:hi("Typedef",        s:frostBlue3,   "",     "",       "")
hi!  link                   Macro           Define
hi!  link                   PreCondit       PreProc

call s:hi("DiffAdd",    s:frostGreen,  s:frost1, "",     "")
call s:hi("DiffChange", s:frostYellow, s:frost1, "",     "")
call s:hi("DiffDelete", s:frostRed,    s:frost1, "",     "")
call s:hi("DiffText",   s:frostBlue3,  s:frost1, "",     "")

call s:hi("cIncluded", s:frostBlue1, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call s:hi("htmlArg",  s:frostBlue1, "", "",     "")
call s:hi("htmlLink", s:frost4,     "", "NONE", "NONE")
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

call s:hi("markdownBlockquote",    s:frostBlue1,  "", "",     "")
call s:hi("markdownCode",          s:frost5,  "bg", "",     "")
call s:hi("markdownCodeBlock",     s:frost5,  "bg", "",     "")
call s:hi("markdownCodeDelimiter", s:frost4,  "bg", "",     "")
call s:hi("markdownFootnote",      s:frostBlue1,  "", "",     "")
call s:hi("markdownId",            s:frostBlue1,  "", "",     "")
call s:hi("markdownIdDeclaration", s:frostBlue1,  "", "",     "")
call s:hi("markdownH1",            s:frostYellow, "", "",     "")
call s:hi("markdownLinkText",      s:frostBlue2,  "", "",     "")
call s:hi("markdownUrl",           s:frost4,      "", "underline", "")
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
