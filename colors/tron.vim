" vim color theme
" name:        angry bee
" maintainer:  markus prepens
" colors taken from https://github.com/ianpan870102/tron-legacy-emacs-theme.
" Thanks!

if exists("syntax_on")
   syntax reset
endif

hi clear
let g:colors_name = "tron"
set background=dark

let s:fg0              ="#90ACBC"
let s:fg1              ="#5A7387"
let s:fg2              ="#BBCCDD"
let s:fg3              ="#BBF0EF"
let s:fg4              ="#CBECFF"
let s:bg0              ="#000000"
let s:bg1              ="#17181b"
let s:bg2              ="#192533"
let s:bg3              ="#1B324B"
let s:bg4              ="#2B4255"
let s:hl_line          ="#0E2638"
let s:bg_hl            ="#35605F"
let s:vc_r             ="#B62D66"
let s:vc_g             ="#4BB5BE"
let s:vc_b             ="#387AAA"
let s:key2             ="#9BBDD6"
let s:key3             ="#AAAAAA"
let s:accent           ="#FFFFFF"
let s:mode_line_bg     ="#3D5666"
let s:line_num         ="#5A7387"

" standardized palette
let s:yellow       = "#DEB45B"
let s:bluegreen    = "#4BB5BE"
let s:magenta      = "#B62D66"
let s:orange       = "#DEB45B"
let s:red          = "#B62D66"
let s:blue         = "#8Fd4FF"
let s:green        = "#4BB5AE"
let s:lightred     = "#FF7DBB"
let s:lightblue    = "#A0DCFF"
let s:lightgreen   = "#BBF0EF"
let s:red_bg       = "#361016"
let s:blue_bg      = "#040E3F"
let s:green_bg     = "#03353E"
let s:red_bghl     = "#462026"
let s:blue_bghl    = "#141E4F"
let s:green_bghl   = "#13454E"

" --- Editor ---
call color#Hi("ColorColumn", "", s:fg1, "", "")
call color#Hi("Cursor", s:fg4, s:red, "NONE", "")
call color#Hi("Error", s:red, "bg", "", "")
call color#Hi("iCursor", s:fg0, s:fg4, "", "")
call color#Hi("MatchParen", s:green, s:bg3, "", "")
call color#Hi("NonText", s:fg0, s:blue, "", "")
call color#Hi("Normal", s:fg0, s:bg1, "", "")
call color#Hi("SpecialKey", s:fg3, "", "", "")
call color#Hi("SpellBad", s:red, s:bg0, "undercurl", s:red)
call color#Hi("SpellCap", s:yellow, s:bg0, "undercurl", s:yellow)
call color#Hi("SpellLocal", s:fg4, s:bg0, "undercurl", s:red)
call color#Hi("SpellRare", s:fg4, s:bg0, "undercurl", s:red)
call color#Hi("Visual", "", s:bg_hl, "", "")
call color#Hi("VisualNOS", "", s:bg_hl, "", "")

" --- Gutter ---
call color#Hi("CursorColumn", "", s:fg1, "", "")
call color#Hi("CursorLine", "", s:hl_line, "NONE", "")
call color#Hi("CursorLineNr", s:fg3, s:magenta, "", "")
call color#Hi("LineNrAbove", s:line_num, s:magenta, "", "")
call color#Hi("LineNrBelow", s:line_num, s:magenta, "", "")
call color#Hi("LineNr", s:line_num, "", "NONE", "")
call color#Hi("Folded", s:fg3, s:fg1, "bold", "")
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr

" --- Navigation ---
call color#Hi("Directory", s:blue, "", "underline", "")

" --- Prompt/Status ---
call color#Hi("EndOfBuffer", s:fg1, "", "", "")
call color#Hi("WarningMsg", s:bg0, s:yellow, "", "")
call color#Hi("ErrorMsg", s:bg0, s:red, "", "")
call color#Hi("ModeMsg", s:bg0, s:green, "", "")
call color#Hi("MoreMsg", s:bg0, s:yellow, "", "")
call color#Hi("Question", s:fg4, "", "", "")

" --- Decorations ---
call color#Hi("StatusLine", s:fg4, s:mode_line_bg, "NONE", "")
call color#Hi("StatusLineNC", s:fg0, s:bg2, "NONE", "")
call color#Hi("StatusLineTerm", s:blue, s:fg3, "NONE", "")
call color#Hi("IncSearch", s:yellow, s:bg3, "bold", "")
call color#Hi("Search", s:green, s:bg4, "NONE", "")

hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch
hi! link VertSplit StatusLineNC

call color#Hi("PmenuSbar", s:fg3, s:bg2, "", "")
call color#Hi("PmenuThumb", s:fg4, s:bg3, "", "")
hi! link PMenuSel IncSearch
hi! link PMenu    Search

call color#Hi("TabLine", s:fg4, s:fg1, "NONE", "")
call color#Hi("TabLineFill", s:fg4, s:fg1, "NONE", "")
call color#Hi("TabLineSel", s:red, s:fg4, "", "")

" --- Window ---
call color#Hi("Title", s:fg4, "", "NONE", "")
call color#Hi("Bold", "", "", "bold", "")
call color#Hi("Italic", "", "", "italic", "")
call color#Hi("Boolean", s:yellow, "", "", "")
call color#Hi("Character", s:yellow, "", "", "")
call color#Hi("Comment", s:fg1, "", "italic", "")
call color#Hi("Conditional", s:lightred, "", "", "")
call color#Hi("Constant", s:bluegreen, "", "", "")
call color#Hi("Delimiter", s:fg4, "", "", "")
call color#Hi("Exception", s:blue, "", "", "")
call color#Hi("Float", s:bluegreen, "", "", "")
call color#Hi("Function", s:yellow, "", "", "")
call color#Hi("Identifier", s:green, "", "NONE", "")
call color#Hi("Keyword", s:lightred, "", "", "")
call color#Hi("Label", s:blue, "", "", "")
call color#Hi("Number", s:magenta, "", "", "")
call color#Hi("Operator", s:yellow, "", "NONE", "")
call color#Hi("Repeat", s:red, "", "", "")
call color#Hi("Special", s:fg4, "", "", "")
call color#Hi("SpecialChar", s:yellow, "", "", "")
call color#Hi("SpecialComment", s:blue, "", "italic", "")
call color#Hi("Statement", s:lightred, "", "", "")
call color#Hi("StorageClass", s:blue, "", "", "")
call color#Hi("String", s:fg3, "", "", "")
call color#Hi("Structure", s:magenta, "", "", "")
call color#Hi("Tag", s:fg4, "", "", "")
call color#Hi("Todo", s:fg3, s:red, "NONE", "")
call color#Hi("Type", s:red, "", "NONE", "")
call color#Hi("Typedef", s:blue, "", "", "")

call color#Hi("PreProc", s:yellow, "", "bold", "")
call color#Hi("Include", s:yellow, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc
hi! link Define PreProc

call color#Hi("DiffAdd", s:green, s:bg2, "", "")
call color#Hi("DiffChange", s:yellow, s:bg2, "", "")
call color#Hi("DiffDelete", s:red, s:bg2, "", "")
call color#Hi("DiffText", s:blue, s:bg2, "", "")

call color#Hi("cIncluded", s:blue, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call color#Hi("htmlArg", s:blue, "", "", "")
call color#Hi("htmlLink", s:fg4, "", "NONE", "NONE")
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

call color#Hi("vimCommentTitle", s:blue, "", "bold", "")

call color#Hi("markdownBlockquote", s:blue, "", "", "")
call color#Hi("markdownCode", s:fg4, "bg", "", "")
call color#Hi("markdownCodeBlock", s:fg4, "bg", "", "")
call color#Hi("markdownCodeDelimiter", s:green, "bg", "", "")
call color#Hi("markdownFootnote", s:blue, "", "", "")
call color#Hi("markdownId", s:blue, "", "", "")
call color#Hi("markdownIdDeclaration", s:blue, "", "", "")
call color#Hi("markdownH1", s:yellow, "", "", "")
call color#Hi("markdownLinkText", s:blue, "", "", "")
call color#Hi("markdownUrl", s:fg4, "", "underline", "")
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
