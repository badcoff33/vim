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

let s:workbench  = "#171C28"
let s:background = "#1D2433"
let s:pencil     = "#A2AAB2"
let s:ui_grey    = "#6679A4"
let s:ui_dimmed  = "#50618A"
let s:ui_dark    = "#30416A"
let s:accent     = "#FFCC66"
let s:red        = "#EF6B73"
let s:green      = "#BAE67E"
let s:yellow     = "#FFD580"
let s:orange     = "#FFAE57"
let s:blue       = "#5CAFE6"
let s:purple     = "#C3A6FF"
let s:foreground = "#D7DCE2"
let s:light_grey = "#8695B7"
let s:grey       = "#2F3B54"
let s:dark_grey  = "#1D2433"

" Editor
call lib#color#Hi("ColorColumn", "", s:light_grey, "", "")
call lib#color#Hi("Cursor", s:background, s:purple, "NONE", "")
call lib#color#Hi("CursorLine", "", s:grey, "NONE", "")
call lib#color#Hi("Error", s:red, "bg", "", "")
call lib#color#Hi("iCursor", s:light_grey, s:grey, "", "")
call lib#color#Hi("LineNr", s:light_grey, "bg", "", "")
call lib#color#Hi("MatchParen", s:blue, s:grey, "", "")
call lib#color#Hi("NonText", s:red, s:grey, "", "")
call lib#color#Hi("Normal", s:foreground, s:background, "", "")
call lib#color#Hi("PMenu", s:dark_grey, s:light_grey, "NONE", "")
call lib#color#Hi("PmenuSbar", s:grey, s:ui_dimmed, "", "")
call lib#color#Hi("PmenuThumb", s:blue, s:grey, "", "")
call lib#color#Hi("SpecialKey", s:grey, "", "", "")
call lib#color#Hi("SpellBad", s:red, "bg", "undercurl", "")
call lib#color#Hi("SpellCap", s:yellow, "bg", "undercurl", "")
call lib#color#Hi("SpellLocal", s:red, "bg", "undercurl", "")
call lib#color#Hi("SpellRare", s:red, "bg", "undercurl", "")
call lib#color#Hi("Visual", s:foreground, s:blue, "", "")
call lib#color#Hi("VisualNOS", s:foreground, s:blue, "", "")
call lib#color#Hi("Whitespace", s:grey, "", "", "")
hi! link PMenuSel IncSearch

" Frost specific
call lib#color#Hi('BlendDown', s:pencil, s:workbench, '', '')

" Neovim Support
call lib#color#Hi("healthError", s:red, s:light_grey, "", "")
call lib#color#Hi("healthSuccess", s:green, s:light_grey, "", "")
call lib#color#Hi("healthWarning", s:yellow, s:light_grey, "", "")
call lib#color#Hi("TermCursorNC", "", s:light_grey, "", "")

" Gutter
call lib#color#Hi("CursorColumn", "", s:light_grey, "", "")
call lib#color#Hi("CursorLineNr", s:purple, s:ui_grey, "NONE", "")
call lib#color#Hi("FoldColumn", s:grey, s:light_grey, "", "")
call lib#color#Hi("Folded", s:grey, s:light_grey, "bold", "")
call lib#color#Hi("SignColumn", s:light_grey, s:background, "", "")

" Navigation
call lib#color#Hi("Directory", s:blue, "", "", "")

" Prompt/Status
call lib#color#Hi("EndOfBuffer", s:light_grey, "bg", "", "")
call lib#color#Hi("ErrorMsg", s:red, "bg", "", "")
call lib#color#Hi("ModeMsg", s:green, "bg", "" , "")
call lib#color#Hi("MoreMsg", s:yellow, "bg", "" , "")
call lib#color#Hi("Question", s:accent, "bg", "", "")
call lib#color#Hi("StatusLine", s:yellow, s:ui_grey, "bold", "")
call lib#color#Hi("StatusLineNC", s:foreground, s:ui_dimmed, "NONE", "")
call lib#color#Hi("VertSplit", s:grey, "bg", "NONE", "")
call lib#color#Hi("WarningMsg", s:accent, "bg", "", "")
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch

" Search
call lib#color#Hi("IncSearch", s:background, s:green, "bold", "")
call lib#color#Hi("Search", s:foreground, s:ui_dark, "NONE", "")

 " QuickFix
call lib#color#Hi("qfSeparator", "fg", "bg", "", "")
call lib#color#Hi("QuickFixLine", "fg", "bg", "bold", "")
hi! link qfFileName Directory
hi! link qfLineNr Directory

" Tabs
call lib#color#Hi("TabLineSel", s:yellow, s:light_grey, "bold", "")
call lib#color#Hi("TabLine", s:yellow, s:grey, "none", "")
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
call lib#color#Hi("Tag", s:grey, "", "", "")
call lib#color#Hi("Todo", s:yellow, "NONE", "", "")
call lib#color#Hi("Type", s:blue, "", "NONE", "")
call lib#color#Hi("Typedef", s:blue, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc

call lib#color#Hi("DiffAdd", s:green, '', "", "")
call lib#color#Hi("DiffChange", s:yellow, '', "bold", "")
call lib#color#Hi("DiffDelete", s:red, '', "", "")
call lib#color#Hi("DiffText", s:blue, '', "", "")

call lib#color#Hi("cIncluded", s:blue, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call lib#color#Hi("htmlArg", s:blue, "", "", "")
call lib#color#Hi("htmlLink", s:grey, "", "NONE", "NONE")
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
call lib#color#Hi("markdownCode", s:dark_grey, "bg", "", "")
call lib#color#Hi("markdownCodeBlock", s:dark_grey, "bg", "", "")
call lib#color#Hi("markdownCodeDelimiter", s:green, "bg", "", "")
call lib#color#Hi("markdownFootnote", s:blue, "", "", "")
call lib#color#Hi("markdownId", s:blue, "", "", "")
call lib#color#Hi("markdownIdDeclaration", s:blue, "", "", "")
call lib#color#Hi("markdownH1", s:yellow, "", "", "")
call lib#color#Hi("markdownLinkText", s:blue, "", "", "")
call lib#color#Hi("markdownUrl", s:light_grey, "", "underline", "")
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
