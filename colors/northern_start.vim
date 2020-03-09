" Colorscheme: Northen Star

let g:colors_name = "northern_star"
set background=dark

let s:nord0 = "#2E3440"
let s:nord1 = "#3B4252"
let s:nord2 = "#434C5E"
let s:nord3 = "#4C566A"
let s:nord3_bright = "#616E88"
let s:nord4 = "#D8DEE9"
let s:nord5 = "#E5E9F0"
let s:nord6 = "#ECEFF4"
let s:nord7 = "#8FBCBB"
let s:nord8 = "#88C0D0"
let s:nord9 = "#81A1C1"
let s:nord10 = "#5E81AC"
let s:nord11 = "#BF616A"
let s:nord12 = "#D08770"
let s:nord13 = "#EBCB8B"
let s:nord14 = "#A3BE8C"
let s:nord15 = "#B48EAD"


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
call s:hi("ColorColumn",           "",             s:nord1,  "",          "")
call s:hi("Cursor",                s:nord0,        s:nord4,  "NONE",      "")
call s:hi("CursorLine",            "",             s:nord1,  "NONE",      "")
call s:hi("Error",                 s:nord0,        s:nord11, "",          "")
call s:hi("iCursor",               s:nord0,        s:nord4,  "",          "")
call s:hi("LineNr",                s:nord3,        s:nord0,  "",          "")
call s:hi("MatchParen",            s:nord8,        s:nord3,  "",          "")
call s:hi("NonText",               s:nord2,        "",       "",          "")
call s:hi("Normal",                s:nord4,        s:nord0,  "",          "")
call s:hi("PMenu",                 s:nord4,        s:nord2,  "NONE",      "")
call s:hi("PmenuSbar",             s:nord4,        s:nord2,  "",          "")
call s:hi("PMenuSel",              s:nord8,        s:nord3,  "",          "")
call s:hi("PmenuThumb",            s:nord8,        s:nord3,  "",          "")
call s:hi("SpecialKey",            s:nord3,        "",       "",          "")
call s:hi("SpellBad",              s:nord11,       s:nord0,  "undercurl", "")
call s:hi("SpellCap",              s:nord13,       s:nord0,  "undercurl", "")
call s:hi("SpellLocal",            s:nord5,        s:nord0,  "undercurl", "")
call s:hi("SpellRare",             s:nord6,        s:nord0,  "undercurl", "")
call s:hi("Visual",                "",             s:nord2,  "",          "")
call s:hi("VisualNOS",             "",             s:nord2,  "",          "")
"+- Neovim Support -+
call s:hi("healthError",           s:nord11,       s:nord1,  "",          "")
call s:hi("healthSuccess",         s:nord14,       s:nord1,  "",          "")
call s:hi("healthWarning",         s:nord13,       s:nord1,  "",          "")
call s:hi("TermCursorNC",          "",             s:nord1,  "",          "")

"+--- Gutter ---+
call s:hi("CursorColumn",          "",             s:nord1,  "",          "")
call s:hi("CursorLineNr",          s:nord4,        s:nord0,  "NONE",      "")
call s:hi("Folded",                s:nord3,        s:nord1,  "bold",      "")
call s:hi("FoldColumn",            s:nord3,        s:nord0,  "",          "")
call s:hi("SignColumn",            s:nord1,        s:nord0,  "",          "")

"+--- Navigation ---+
call s:hi("Directory",             s:nord8,        "",       "",          "")

"+--- Prompt/Status ---+
call s:hi("EndOfBuffer",           s:nord1,        "",       "",          "")
call s:hi("ErrorMsg",              s:nord4,        s:nord11, "",          "")
call s:hi("ModeMsg",               s:nord4,        "",       "",          "")
call s:hi("MoreMsg",               s:nord4,        "",       "",          "")
call s:hi("Question",              s:nord4,        "",       "",          "")
call s:hi("StatusLine",            s:nord8,        s:nord3,  "NONE",      "")
call s:hi("StatusLineNC",          s:nord4,        s:nord1,  "NONE",      "")
call s:hi("StatusLineTerm",        s:nord8,        s:nord3,  "NONE",      "")
call s:hi("StatusLineTermNC",      s:nord4,        s:nord1,  "NONE",      "")
call s:hi("WarningMsg",            s:nord0,        s:nord13, "",          "")
call s:hi("WildMenu",              s:nord8,        s:nord1,  "",          "")

"+--- Search ---+
call s:hi("IncSearch",             s:nord6,        s:nord10, "underline", "")
call s:hi("Search",                s:nord1,        s:nord8,  "NONE",      "")

"+--- Tabs ---+
call s:hi("TabLine",               s:nord4,        s:nord1,  "NONE",      "")
call s:hi("TabLineFill",           s:nord4,        s:nord1,  "NONE",      "")
call s:hi("TabLineSel",            s:nord8,        s:nord3,  "NONE",      "")

"+--- Window ---+
call s:hi("Title",                 s:nord4,        "",       "NONE",      "")

call s:hi("VertSplit",             s:nord2,        s:nord0,  "NONE",      "")

call s:hi("Boolean",               s:nord9,        "",       "",          "")
call s:hi("Character",             s:nord14,       "",       "",          "")
call s:hi("Comment",               s:nord3_bright, "",       "italic",    "")
call s:hi("Conditional",           s:nord9,        "",       "",          "")
call s:hi("Constant",              s:nord4,        "",       "",          "")
call s:hi("Define",                s:nord9,        "",       "",          "")
call s:hi("Delimiter",             s:nord6,        "",       "",          "")
call s:hi("Exception",             s:nord9,        "",       "",          "")
call s:hi("Float",                 s:nord15,       "",       "",          "")
call s:hi("Function",              s:nord8,        "",       "",          "")
call s:hi("Identifier",            s:nord4,        "",       "NONE",      "")
call s:hi("Include",               s:nord9,        "",       "",          "")
call s:hi("Keyword",               s:nord9,        "",       "",          "")
call s:hi("Label",                 s:nord9,        "",       "",          "")
call s:hi("Number",                s:nord15,       "",       "",          "")
call s:hi("Operator",              s:nord9,        "",       "NONE",      "")
call s:hi("PreProc",               s:nord9,        "",       "NONE",      "")
call s:hi("Repeat",                s:nord9,        "",       "",          "")
call s:hi("Special",               s:nord4,        "",       "",          "")
call s:hi("SpecialChar",           s:nord13,       "",       "",          "")
call s:hi("SpecialComment",        s:nord8,        "",       "italic",    "")
call s:hi("Statement",             s:nord9,        "",       "",          "")
call s:hi("StorageClass",          s:nord9,        "",       "",          "")
call s:hi("String",                s:nord14,       "",       "",          "")
call s:hi("Structure",             s:nord9,        "",       "",          "")
call s:hi("Tag",                   s:nord4,        "",       "",          "")
call s:hi("Todo",                  s:nord13,       "NONE",   "",          "")
call s:hi("Type",                  s:nord9,        "",       "NONE",      "")
call s:hi("Typedef",               s:nord9,        "",       "",          "")
hi! link Macro Define
hi! link PreCondit PreProc

call s:hi("cIncluded",             s:nord7,        "",       "",          "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call s:hi("DiffAdd",               s:nord14,       s:nord1,  "",          "")
call s:hi("DiffChange",            s:nord13,       s:nord1,  "",          "")
call s:hi("DiffDelete",            s:nord11,       s:nord1,  "",          "")
call s:hi("DiffText",              s:nord9,        s:nord1,  "",          "")

" Legacy groups for official git.vim and diff.vim syntax
hi! link diffAdded DiffAdd
hi! link diffChanged DiffChange
hi! link diffRemoved DiffDelete


call s:hi("htmlArg",               s:nord7,        "",       "",          "")
call s:hi("htmlLink",              s:nord4,        "",       "NONE",      "NONE")
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

call s:hi("markdownBlockquote",    s:nord7,        "",       "",          "")
call s:hi("markdownCode",          s:nord7,        "",       "",          "")
call s:hi("markdownCodeDelimiter", s:nord7,        "",       "",          "")
call s:hi("markdownFootnote",      s:nord7,        "",       "",          "")
call s:hi("markdownId",            s:nord7,        "",       "",          "")
call s:hi("markdownIdDeclaration", s:nord7,        "",       "",          "")
call s:hi("markdownH1",            s:nord8,        "",       "",          "")
call s:hi("markdownLinkText",      s:nord8,        "",       "",          "")
call s:hi("markdownUrl",           s:nord4,        "",       "NONE",      "")
hi! link markdownBold Bold
hi! link markdownBoldDelimiter Keyword
hi! link markdownFootnoteDefinition markdownFootnote
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownIdDelimiter Keyword
hi! link markdownItalic Italic
hi! link markdownItalicDelimiter Keyword
hi! link markdownLinkDelimiter Keyword
hi! link markdownLinkTextDelimiter Keyword
hi! link markdownListMarker Keyword
hi! link markdownRule Keyword
hi! link markdownHeadingDelimiter Keyword

