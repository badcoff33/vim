" Colorscheme: little monster

let g:colors_name = "little_monster"
set background=dark

if exists('&wincolor')
  augroup Wincolor
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if (&buftype!='' && &buftype!='nofile')
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

let s:white             = "#FFFFFF"
let s:workbench_passive = "#272F3F"
let s:workbench_active  = "#373F5F"
let s:workbench_grey    = "#3E4468"
let s:background        = "#1D2433"
let s:background_plus   = "#212735"
let s:foreground        = "#B2BACC"
let s:accent            = "#FFCC66"
let s:red               = "#EF6B73"
let s:green             = "#BAE67E"
let s:yellow            = "#FFD580"
let s:orange            = "#FFAE57"
let s:blue              = "#5CAFE0"
let s:purple            = "#C3A6FF"
let s:white             = "#D7DCE2"
let s:light_silver      = "#90909F"
let s:silver            = "#70707A"


" Editor
call lib#color#Hi("ColorColumn", "", s:light_silver, "", "")
call lib#color#Hi("Cursor", s:yellow, s:silver, "NONE", "")
call lib#color#Hi("CursorLine", "skip", s:background_plus, "", "")
call lib#color#Hi("Error", s:red, "bg", "", "")
call lib#color#Hi("iCursor", s:light_silver, s:workbench_grey, "", "")
call lib#color#Hi("LineNr", s:light_silver, "bg", "", "")
call lib#color#Hi("MatchParen", s:blue, s:workbench_grey, "", "")
call lib#color#Hi("NonText", s:red, s:silver, "", "")
call lib#color#Hi("Normal", s:foreground, s:background, "", "")
call lib#color#Hi("PMenu", s:background_plus, s:light_silver, "NONE", "")
call lib#color#Hi("PmenuSbar", s:silver, s:silver, "", "")
call lib#color#Hi("PmenuThumb", s:blue, s:workbench_grey, "", "")
call lib#color#Hi("SpecialKey", s:silver, "", "", "")
call lib#color#Hi("SpellBad", s:red, "bg", "undercurl", "")
call lib#color#Hi("SpellCap", s:yellow, "bg", "undercurl", "")
call lib#color#Hi("SpellLocal", s:red, "bg", "undercurl", "")
call lib#color#Hi("SpellRare", s:red, "bg", "undercurl", "")
call lib#color#Hi("Visual", s:workbench_grey, s:blue, "", "")
call lib#color#Hi("VisualNOS", s:foreground, s:blue, "", "")
call lib#color#Hi("Whitespace", s:silver, "", "", "")
hi! link PMenuSel IncSearch
hi! link CursorColumn CursorLine

" Frost specific
call lib#color#Hi('BlendDown', s:light_silver, s:background_plus, '', '')

" Neovim Support
call lib#color#Hi("healthError", s:red, s:light_silver, "", "")
call lib#color#Hi("healthSuccess", s:green, s:light_silver, "", "")
call lib#color#Hi("healthWarning", s:yellow, s:light_silver, "", "")
call lib#color#Hi("TermCursorNC", "", s:light_silver, "", "")

" Gutter
call lib#color#Hi("CursorLineNr", s:purple, s:background_plus, "NONE", "")
call lib#color#Hi("FoldColumn", s:workbench_grey, s:background, "", "")
call lib#color#Hi("Folded", s:red, s:background, "bold", "")
call lib#color#Hi("SignColumn", s:light_silver, s:background, "", "")

" Navigation
call lib#color#Hi("Directory", s:blue, "", "", "")

" Prompt/Status
call lib#color#Hi("EndOfBuffer", s:light_silver, "bg", "", "")
call lib#color#Hi("ErrorMsg", s:red, "bg", "", "")
call lib#color#Hi("ModeMsg", s:green, "bg", "" , "")
call lib#color#Hi("MoreMsg", s:yellow, "bg", "" , "")
call lib#color#Hi("Question", s:accent, "bg", "", "")
call lib#color#Hi("StatusLine", s:yellow, s:workbench_active, "bold", "")
call lib#color#Hi("StatusLineNC", s:yellow, s:workbench_passive, "NONE", "")
call lib#color#Hi("VertSplit", s:silver, "bg", "NONE", "")
call lib#color#Hi("WarningMsg", s:accent, "bg", "", "")
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch

" Search
call lib#color#Hi("IncSearch", s:background, s:green, "bold", "")
call lib#color#Hi("Search", s:white, s:workbench_grey, "underline", s:blue)

 " QuickFix
call lib#color#Hi("qfSeparator", "fg", "bg", "", "")
call lib#color#Hi("QuickFixLine", "fg", "bg", "bold", "")
hi! link qfFileName Directory
hi! link qfLineNr Directory

" Tabs
call lib#color#Hi("TabLineSel", s:yellow, s:workbench_active, "bold", "")
call lib#color#Hi("TabLine", s:yellow, s:workbench_passive, "none", "")
hi! link TabLineSel StatusLine
hi! link TabLineFill Normal

" Window
call lib#color#Hi("Title", s:green, "", "bold", "")
call lib#color#Hi("Bold", "", "", "bold", "")
call lib#color#Hi("Italic", "", "", "italic", "")
call lib#color#Hi("Boolean", s:blue, "", "", "")
call lib#color#Hi("Character", s:yellow, "", "", "")
call lib#color#Hi("Comment", s:green, "", "", "")
call lib#color#Hi("Conditional", s:orange, "", "", "")
call lib#color#Hi("Constant", s:accent, "", "", "")
call lib#color#Hi("Define", s:orange, "", "", "")
call lib#color#Hi("Delimiter", s:blue, "", "", "")
call lib#color#Hi("Exception", s:blue, "", "", "")
call lib#color#Hi("Float", s:purple, "", "", "")
call lib#color#Hi("Function", s:blue, "", "", "")
call lib#color#Hi("Identifier", s:green, "", "NONE", "")
call lib#color#Hi("Include", s:blue, "", "", "")
call lib#color#Hi("Keyword", s:blue, "", "", "")
call lib#color#Hi("Label", s:blue, "", "", "")
call lib#color#Hi("Number", s:purple, "", "", "")
call lib#color#Hi("Operator", s:yellow, "", "NONE", "")
call lib#color#Hi("PreProc", s:blue, "", "NONE", "")
call lib#color#Hi("Repeat", s:blue, "", "", "")
call lib#color#Hi("Special", s:accent, "", "", "")
call lib#color#Hi("SpecialChar", s:yellow, "", "", "")
call lib#color#Hi("SpecialComment", s:blue, "", "", "")
call lib#color#Hi("Statement", s:orange, "", "", "")
call lib#color#Hi("StorageClass", s:blue, "", "", "")
call lib#color#Hi("String", s:purple, "", "", "")
call lib#color#Hi("Structure", s:blue, "", "", "")
call lib#color#Hi("Tag", s:silver, "", "", "")
call lib#color#Hi("Todo", s:yellow, "NONE", "", "")
call lib#color#Hi("Type", s:blue, "", "NONE", "")
call lib#color#Hi("Typedef", s:blue, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc

call lib#color#Hi("DiffAdd", s:green, s:workbench_passive, "", "")
call lib#color#Hi("DiffChange", s:yellow, s:workbench_passive, "bold", "")
call lib#color#Hi("DiffDelete", s:yellow, s:red, "", "")
call lib#color#Hi("DiffText", s:blue, s:workbench_passive, "", "")

call lib#color#Hi("cIncluded", s:blue, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call lib#color#Hi("htmlArg", s:blue, "", "", "")
call lib#color#Hi("htmlLink", s:silver, "", "NONE", "NONE")
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

call lib#color#Hi("markdownBlockquote", s:blue, "", "", "")
call lib#color#Hi("markdownCode", s:background_plus, "bg", "", "")
call lib#color#Hi("markdownCodeBlock", s:background_plus, "bg", "", "")
call lib#color#Hi("markdownCodeDelimiter", s:green, "bg", "", "")
call lib#color#Hi("markdownFootnote", s:blue, "", "", "")
call lib#color#Hi("markdownId", s:blue, "", "", "")
call lib#color#Hi("markdownIdDeclaration", s:blue, "", "", "")
call lib#color#Hi("markdownH1", s:yellow, "", "", "")
call lib#color#Hi("markdownLinkText", s:blue, "", "", "")
call lib#color#Hi("markdownUrl", s:light_silver, "", "underline", "")
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
