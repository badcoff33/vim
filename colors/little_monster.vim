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
let s:black             = "#000000"
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
call color#Hi("ColorColumn", "", s:light_silver, "", "")
call color#Hi("Cursor", s:black, s:yellow, "NONE", "")
call color#Hi("CursorLine", "skip", s:background_plus, "", "")
call color#Hi("Error", s:red, "bg", "", "")
call color#Hi("iCursor", s:light_silver, s:workbench_grey, "", "")
call color#Hi("LineNr", s:light_silver, "bg", "", "")
call color#Hi("MatchParen", "", "", "underline,bold", "")
call color#Hi("NonText", s:red, s:silver, "", "")
call color#Hi("Normal", s:foreground, s:background, "", "")
call color#Hi("PMenu", s:silver, s:workbench_passive, "NONE", "")
call color#Hi("PMenuSbar", s:silver, s:workbench_passive, "", "")
call color#Hi("PMenuThumb", s:blue, s:workbench_grey, "", "")
call color#Hi("SpecialKey", s:silver, "", "", "")
call color#Hi("SpellBad", s:red, "bg", "undercurl", "")
call color#Hi("SpellCap", s:yellow, "bg", "undercurl", "")
call color#Hi("SpellLocal", s:red, "bg", "undercurl", "")
call color#Hi("SpellRare", s:red, "bg", "undercurl", "")
call color#Hi("Visual", s:workbench_grey, s:blue, "", "")
call color#Hi("VisualNOS", s:foreground, s:blue, "", "")
call color#Hi("Whitespace", s:silver, "", "", "")
hi! link PMenuSel IncSearch
hi! link CursorColumn CursorLine

" Frost specific
call color#Hi('BlendDown', s:light_silver, s:background_plus, '', '')

" Neovim Support
call color#Hi("healthError", s:red, s:light_silver, "", "")
call color#Hi("healthSuccess", s:green, s:light_silver, "", "")
call color#Hi("healthWarning", s:yellow, s:light_silver, "", "")
call color#Hi("TermCursorNC", "", s:light_silver, "", "")

" Gutter
call color#Hi("CursorLineNr", s:purple, s:background_plus, "NONE", "")
call color#Hi("FoldColumn", s:workbench_grey, s:background, "", "")
call color#Hi("Folded", s:red, s:background, "bold", "")
call color#Hi("SignColumn", s:light_silver, s:background, "", "")

" Navigation
call color#Hi("Directory", s:blue, "", "", "")

" Prompt/Status
call color#Hi("EndOfBuffer", s:light_silver, "bg", "", "")
call color#Hi("ErrorMsg", s:red, "bg", "", "")
call color#Hi("ModeMsg", s:green, "bg", "" , "")
call color#Hi("MoreMsg", s:yellow, "bg", "" , "")
call color#Hi("Question", s:accent, "bg", "", "")
call color#Hi("StatusLine", s:yellow, s:workbench_active, "bold", "")
call color#Hi("StatusLineNC", s:yellow, s:workbench_passive, "NONE", "")
call color#Hi("VertSplit", s:silver, "bg", "NONE", "")
call color#Hi("WarningMsg", s:accent, "bg", "", "")
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch

" Search
call color#Hi("IncSearch", s:background, s:green, "bold", "")
call color#Hi("Search", s:white, s:workbench_grey, "underline", s:blue)

 " QuickFix
call color#Hi("qfSeparator", "fg", "bg", "", "")
call color#Hi("QuickFixLine", "fg", "bg", "bold", "")
hi! link qfFileName Directory
hi! link qfLineNr Directory

" Tabs
call color#Hi("TabLineSel", s:yellow, s:workbench_active, "bold", "")
call color#Hi("TabLine", s:yellow, s:workbench_passive, "none", "")
hi! link TabLineSel StatusLine
hi! link TabLineFill Normal

" Window
call color#Hi("Title", s:green, "", "bold", "")
call color#Hi("Bold", "", "", "bold", "")
call color#Hi("Italic", "", "", "italic", "")
call color#Hi("Boolean", s:blue, "", "", "")
call color#Hi("Character", s:yellow, "", "", "")
call color#Hi("Comment", s:green, "", "", "")
call color#Hi("Conditional", s:orange, "", "", "")
call color#Hi("Constant", s:accent, "", "", "")
call color#Hi("Define", s:orange, "", "", "")
call color#Hi("Delimiter", s:blue, "", "", "")
call color#Hi("Exception", s:blue, "", "", "")
call color#Hi("Float", s:purple, "", "", "")
call color#Hi("Function", s:blue, "", "", "")
call color#Hi("Identifier", s:green, "", "NONE", "")
call color#Hi("Include", s:blue, "", "", "")
call color#Hi("Keyword", s:blue, "", "", "")
call color#Hi("Label", s:blue, "", "", "")
call color#Hi("Number", s:purple, "", "", "")
call color#Hi("Operator", s:yellow, "", "NONE", "")
call color#Hi("PreProc", s:blue, "", "NONE", "")
call color#Hi("Repeat", s:blue, "", "", "")
call color#Hi("Special", s:accent, "", "", "")
call color#Hi("SpecialChar", s:yellow, "", "", "")
call color#Hi("SpecialComment", s:blue, "", "", "")
call color#Hi("Statement", s:orange, "", "", "")
call color#Hi("StorageClass", s:blue, "", "", "")
call color#Hi("String", s:purple, "", "", "")
call color#Hi("Structure", s:blue, "", "", "")
call color#Hi("Tag", s:silver, "", "", "")
call color#Hi("Todo", s:yellow, "NONE", "", "")
call color#Hi("Type", s:blue, "", "NONE", "")
call color#Hi("Typedef", s:blue, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc

call color#Hi("DiffAdd", s:green, s:workbench_passive, "", "")
call color#Hi("DiffChange", s:yellow, s:workbench_passive, "", "")
call color#Hi("DiffDelete", s:black, s:red, "", "")
call color#Hi("DiffText", s:blue, s:workbench_active, "", "")

call color#Hi("cIncluded", s:blue, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call color#Hi("htmlArg", s:blue, "", "", "")
call color#Hi("htmlLink", s:silver, "", "NONE", "NONE")
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

call color#Hi("markdownBlockquote", s:blue, "", "", "")
call color#Hi("markdownCode", s:silver, "bg", "", "")
call color#Hi("markdownCodeBlock", s:silver, "bg", "", "")
call color#Hi("markdownCodeDelimiter", s:green, "bg", "", "")
call color#Hi("markdownFootnote", s:blue, "", "", "")
call color#Hi("markdownId", s:blue, "", "", "")
call color#Hi("markdownIdDeclaration", s:blue, "", "", "")
call color#Hi("markdownH1", s:yellow, "", "", "")
call color#Hi("markdownLinkText", s:blue, "", "", "")
call color#Hi("markdownUrl", s:light_silver, "", "underline", "")
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
